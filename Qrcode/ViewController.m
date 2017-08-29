//
//  ViewController.m
//  Qrcode
//
//  Created by YaSha_Tom on 2017/8/25.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
#import <Masonry.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>



@interface ViewController ()< AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickEvent) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(275, 40));
    }];    
}

- (void)clickEvent {
    ScanViewController *scan = [[ScanViewController alloc]init];
    [self.navigationController pushViewController:scan animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
