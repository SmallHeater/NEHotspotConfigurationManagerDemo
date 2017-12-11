//
//  signalView.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2017/12/4.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "SignalView.h"
#import "NSString+NormalMethod.h"

#define FONT14 [UIFont systemFontOfSize:14.0]

@implementation SignalView

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTitle:(NSString *)title andData:(NSString *)data{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imageView];
        self.imageView.frame = CGRectMake(0, 0, 25, 29);
        self.imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 2, 0, frame.size.width - CGRectGetMaxX(self.imageView.frame), 29);
        self.titleLabel.text = title;
        [self addSubview:self.dataLabel];
        self.dataLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), frame.size.width, frame.size.height - CGRectGetMaxY(self.imageView.frame));
        self.dataLabel.text = data;
    }
    return self;
}


#pragma mark  ----  自定义函数
+(float)viewWidthWithStr:(NSString *)title{
    
    float width = 0;
    width += 27;
    NSString * forthStr = @"信号强度";
    float forthWidth = [NSString textWidthWithText:forthStr font:FONT14 inHeight:14.0];
    width += forthWidth;
    return width;
}


#pragma mark  ----  懒加载
-(UIImageView *)imageView{

    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT14;
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

-(UILabel *)dataLabel{
    
    if (!_dataLabel) {
        
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.font = FONT14;
        _dataLabel.textColor = [UIColor grayColor];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dataLabel;
}

@end
