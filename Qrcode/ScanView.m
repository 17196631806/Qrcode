//
//  ScanView.m
//  Qrcode
//
//  Created by YaSha_Tom on 2017/8/25.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ScanView.h"
#import <Masonry.h>


#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    _viewOfInterest = [[UIView alloc] init];
    _viewOfInterest.backgroundColor = [UIColor clearColor];
    _viewOfInterest.layer.masksToBounds = YES;
    _viewOfInterest.layer.borderWidth = 1;
    _viewOfInterest.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_viewOfInterest];
    [_viewOfInterest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
 
    _line = [[UIView alloc] initWithFrame:CGRectMake(self.viewOfInterest.frame.origin.x + 1, self.viewOfInterest.frame.origin.y + 1, 250, 2)];
    //line.center = view.center;
    _line.backgroundColor = [UIColor blueColor];
    [_viewOfInterest addSubview:_line];
    [self scanLineAnimate];
}

- (void)scanLineAnimate
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(didScanLineFinished)];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:HUGE_VALF];
    _line.center = CGPointMake(_line.center.x, 250);
    [UIView commitAnimations];
}

@end
