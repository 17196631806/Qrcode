//
//  ScanView.h
//  Qrcode
//
//  Created by YaSha_Tom on 2017/8/25.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanView : UIView

@property (nonatomic,strong)UIView *viewOfInterest;

@property(nonatomic, strong) UIView *line;

@property (nonatomic,strong)UIButton *cancelButton;

- (void)scanLineAnimate;

@end
