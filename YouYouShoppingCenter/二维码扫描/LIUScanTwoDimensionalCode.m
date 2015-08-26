//
//  LIUScanTwoDimensionalCode.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/28.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define kScreenBounds           [UIScreen mainScreen].bounds

#define kWidth(W)               W/self.bounds.size.width
#define kHeight(H)              H/self.bounds.size.height

#import "LIUScanTwoDimensionalCode.h"

@interface LIUScanTwoDimensionalCode ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureDevice *scanDevice; //扫描设备

@property(nonatomic,strong)AVCaptureInput *input; //输入流

@property(nonatomic,strong)AVCaptureMetadataOutput *output; //输出的数据流

@property(nonatomic,strong)AVCaptureSession *session;   //捕捉会话

@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer; //展示layour

@property(nonatomic,strong)UIView *boxView;
@property(nonatomic,strong)CALayer *scanLayer;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)SuccessBlock successBlock;

@end

@implementation LIUScanTwoDimensionalCode

- (void)startScanSuccess:(SuccessBlock)successBlock {
     self.successBlock = successBlock;
    [self start];
}

- (void)start {
    //10 开始扫描
    [self.session startRunning];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatScanSub];
    }
    return self;
}

//初始化各种扫描控件
- (void)creatScanSub {
    
    //1.获取设备号
    self.scanDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.创建输入输出流
    NSError *error;
    {
        self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.scanDevice error:&error];
        if (!self.input) {
            NSLog(@"%@",error);
            return;
        }
        self.output = [[AVCaptureMetadataOutput alloc]init];
    }
    
    //3.实例化捕捉会话
    {
        self.session = [[AVCaptureSession alloc]init];
        //3.1
        [self.session addInput:self.input];
        //3.2
        [self.session addOutput:self.output];
    }
    
    //4.创建串行队列并添加到会话中
    {
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("myqueue", NULL);
        //4.1将媒体输出流添加到会话中
        [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //4.2设置输出媒体数据类型为QRCode
        [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }
    
    //5.实例化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    //6.设置预览图层的填充方式
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //7.设置图层的frame
    [self.previewLayer setFrame:self.layer.bounds];
    //8.讲图层添加到预览view的图层上
    [self.layer addSublayer:self.previewLayer];
    
    //9.设置扫描范围//kHeight((self.bounds.size.height-200)*0.5)  kWidth(self.bounds.size.width-((self.bounds.size.width-200)*0.5))
    //这里扫描范围的控制是以又顶点为原点（0，0，1，1），然后interest的x，y，width，height都相互交换了，注意这点
    self.output.rectOfInterest = CGRectMake(kHeight((self.bounds.size.height-200)*0.5),kWidth((self.bounds.size.width-200)*0.5),kHeight(200),kWidth(200));
    //9.1扫描框
    //self.boxView = [[UIView alloc]initWithFrame:CGRectMake((self.bounds.size.width-200)*0.5,(self.bounds.size.height-200)*0.5,200, 200)];
    //self.boxView = [[UIView alloc]initWithFrame:CGRectMake((kWidth(self.bounds.size.width-((self.bounds.size.width-200)*0.5))-kWidth(200))*self.bounds.size.width, kHeight((self.bounds.size.height-200)*0.5)*self.bounds.size.height, kWidth(200)*self.bounds.size.height, kHeight(200)*self.bounds.size.height)];
    self.boxView = [[UIView alloc]initWithFrame:CGRectMake((self.bounds.size.width - (self.bounds.size.width-200)*0.5)-200,kHeight((self.bounds.size.height-200)*0.5)*self.bounds.size.height, kWidth(200)*self.bounds.size.width, kHeight(200)*self.bounds.size.height)];
    self.boxView.layer.borderColor = [UIColor greenColor].CGColor;
    self.boxView.layer.borderWidth = 1.f;
    [self addSubview:self.boxView];
    //9.2扫描线
    self.scanLayer = [[CALayer alloc]init];
    self.scanLayer.frame = CGRectMake(0, 0, self.boxView.bounds.size.width, 1);
    self.scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [self.boxView.layer addSublayer:self.scanLayer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    
    
}

//移动扫描线
- (void)moveScanLayer:(NSTimer *)timer {
    
    CGRect frame = self.scanLayer.frame;
    if (_boxView.frame.size.height < self.scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        self.scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1f animations:^{
            self.scanLayer.frame = frame;
        }];
    }
}

//代理
#pragma --mark AVCaptureMetadaOutputdelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    //判断是否有数据
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metaDataObj = [metadataObjects firstObject];
        //判断回传的数据类型
        if ([[metaDataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self stopReading];
            [self.delegate scanSuccess:[metaDataObj stringValue] AndScanObj:self];
            if (self.successBlock) {
                self.successBlock([metaDataObj stringValue]);
            }
            
            //[self stopReading];
        }
    }
    
}

- (void)stopReading {
    [self.session stopRunning];
    self.session = nil;
    [self.timer invalidate];
//    [self.scanLayer removeFromSuperlayer];
//    [self.previewLayer removeFromSuperlayer];
}


- (void)dismiss {
    [self removeFromSuperview];
}

- (void)cancle:(UIButton *)sender {
    [self dismiss];
}



@end
