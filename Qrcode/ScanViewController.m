//
//  ScanViewController.m
//  Qrcode
//
//  Created by YaSha_Tom on 2017/8/25.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ScanViewController.h"
#import <MTBBarcodeScanner.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ScanView.h"
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>


@interface ScanViewController ()< AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic,strong)ScanView *scanView;

@property(nonatomic,strong)MTBBarcodeScanner *barcodeScanner;

@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码";
    
    _scanView = [[ScanView alloc] init];
    [[_scanView.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    _barcodeScanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_scanView];
   
    [self.view addSubview:_scanView];
//    [self lightSensitive];
    [self scan];
}
- (void)scan {
    [self lightSensitive];
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        NSError *error = nil;
        [_barcodeScanner startScanningWithResultBlock:^(NSArray<AVMetadataMachineReadableCodeObject *> *codes) {
            _barcodeScanner.scanRect = _scanView.viewOfInterest.frame;
            
            AVMetadataMachineReadableCodeObject *codeObject = [codes firstObject];
            NSString *tempString = [NSString stringWithFormat:@"%@", codeObject.stringValue];
            NSString *result;
            if ([tempString canBeConvertedToEncoding:NSISOLatin1StringEncoding]) {
                result = [NSString stringWithCString:[tempString cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
            } else {
                result = tempString;
            }
            if (!result) {
                
            }
            NSLog(@"识别结果:%@", result);
            
        } error:&error];
    }];
}

- (void)lightSensitive {
    
    // 1.获取硬件设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2.创建输入流
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    
    // 3.创建设备输出流
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    
    // AVCaptureSession属性
    self.session = [[AVCaptureSession alloc]init];
    // 设置为高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    // 添加会话输入和输出
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    // 9.启动会话
    [self.session startRunning];
    
}

#pragma mark- AVCaptureVideoDataOutputSampleBufferDelegate的方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    NSLog(@"=======%f",brightnessValue);
    if (brightnessValue < 0 ) {// 打开闪光灯
        NSLog(@"----11112222222----%f",brightnessValue);
       self.barcodeScanner.torchMode = YES;
        
    }else if(brightnessValue > 0  ) {// 关闭闪光灯
        NSLog(@"----222221111111----%f",brightnessValue);
        self.barcodeScanner.torchMode = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
