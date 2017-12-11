//
//  signalView.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2017/12/4.
//  Copyright © 2017年 pk. All rights reserved.
//  view,左上方显示图片，右上方显示label，下方显示label

#import <UIKit/UIKit.h>

@interface SignalView : UIView

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * dataLabel;

+(float)viewWidthWithStr:(NSString *)title;

-(instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTitle:(NSString *)title andData:(NSString *)data;
@end
