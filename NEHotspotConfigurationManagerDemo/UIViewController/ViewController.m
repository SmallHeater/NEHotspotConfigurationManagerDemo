//
//  ViewController.m
//  NEHotspotConfigurationManagerDemo
//
//  Created by xianjunwang on 2017/11/6.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "ViewController.h"
//连接wifi的框架
#import <NetworkExtension/NetworkExtension.h>
//获取当前wifi的框架
#import <SystemConfiguration/CaptiveNetwork.h>
#import "SpeedController.h"
#import "NSString+NormalMethod.h"
#import "SignalView.h"

#define FONT14 [UIFont systemFontOfSize:14.0]
#define BOLDFONT14 [UIFont boldSystemFontOfSize:14.0]
#define BOLDFONT18 [UIFont boldSystemFontOfSize:18.0]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
//加入wifi按钮
@property (nonatomic,strong) UIButton * addWifiBtn;
//加入过的wifi按钮
@property (nonatomic,strong) UIButton * wifiListBtn;
//开始测速按钮
@property (nonatomic,strong) UIButton * startSpeedBtn;
//表盘view
@property (nonatomic,strong) UIView * dialView;
@property (nonatomic,strong) UIImageView * diaImageView;
//指针imageView
@property (nonatomic,strong) UIImageView * pointImageView;

//参数view
@property (nonatomic,strong) UIView * parameterView;

@property (nonatomic,strong) CALayer * pointLayer;
//信号强度
@property (nonatomic,assign) float signalStrength;
//信号强度label
@property (nonatomic,strong) UILabel * signalStrengthLabel;
//上行速度label
@property (nonatomic,strong) UILabel * upstreamSpeedLabel;
//上行速度
@property (nonatomic,assign) float upstreamSpeed;
//下行速度label
@property (nonatomic,strong) UILabel * downstreamSpeedLabel;
//上传开始时间
@property (nonatomic,strong) NSDate * uploadStartTime;
//网络情况label
@property (nonatomic,strong) UILabel * internetLabel;
@end

@implementation ViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.addWifiBtn];
    [self.view addSubview:self.wifiListBtn];
    [self.view addSubview:self.startSpeedBtn];
    
    [self.view addSubview:self.dialView];
    [self.view addSubview:self.parameterView];
    
    self.signalStrength = 0;
    self.upstreamSpeed = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  自定义函数
//加入wifi的响应
-(void)addWifiBtnClicked{
    
    NSString * wifiName = @"appmfl.com";
    //配置要加入的wifi名和密码,isWEP:YES,是WEP;NO,是WPA/WPA2。
    NEHotspotConfiguration * configuration = [[NEHotspotConfiguration alloc] initWithSSID:wifiName passphrase:@"jinher0101" isWEP:NO];
    
    [[NEHotspotConfigurationManager sharedManager] applyConfiguration:configuration completionHandler:^(NSError * _Nullable error) {
        
        //有时无法加入WIFI，没有返回error
        if ([[self getCurrentWifi] isEqualToString:wifiName]) {
            
            if (error) {
                
                //无法加入网络，需移除
                [[NEHotspotConfigurationManager sharedManager] removeConfigurationForSSID:wifiName];
            }
            else{
                
                //连接wifi成功
                NSLog(@"连接WiFi成功");
            }
        }
        else{
            
            //无法加入网络，需移除
            [[NEHotspotConfigurationManager sharedManager] removeConfigurationForSSID:wifiName];
        }
    }];
}

//wifi列表的响应
-(void)wifiListBtnClicked{
    
    [[NEHotspotConfigurationManager sharedManager] getConfiguredSSIDsWithCompletionHandler:^(NSArray<NSString *> * array) {
        
        for (NSString * str in array) {
            
            NSLog(@"加入过的WiFi：%@",str);
        }
    }];
}

//开始测速的响应
-(void)startSpeedBtnClicked{
    
    //获取信号强度
    [SpeedController getSignalStrength:^(float signalStrength) {
        
        self.signalStrength = signalStrength;
        //旋转最大值
        float maxSignalStrength = 172.0 / 180.0;
        if (self.signalStrength >= maxSignalStrength) {
            
            [self updateWeightx:maxSignalStrength];
        }
        else{
            
            [self updateWeightx:self.signalStrength];
        }
        
        NSUInteger signal = self.signalStrength * 100;
        NSString * signalStrengthStr = [[NSString alloc] initWithFormat:@"%ld%@",signal,@"%"];
        self.signalStrengthLabel.text = signalStrengthStr;
    }];
    
    //获取上行下行速度
    [[SpeedController sharedManager] getDownstreamSpeedAndUpstreamSpeed:^(float downstreamSpeed, float upstreamSpeed) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.upstreamSpeed = upstreamSpeed;
            self.downstreamSpeedLabel.text = [[NSString alloc] initWithFormat:@"%.2f MB/S",downstreamSpeed];
            self.upstreamSpeedLabel.text = [[NSString alloc] initWithFormat:@"%.2f MB/S",upstreamSpeed];
        });
    }];
}

//获取当前wifi
-(NSString *)getCurrentWifi{
    
    NSString * wifiName = @"";
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        wifiName = @"";
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

//旋转指针
- (void)updateWeightx:(CGFloat)weight {
    
    
    CGFloat angle = M_PI * weight;
    
    [UIView animateWithDuration:2 animations:^{
        self.pointImageView.transform = CGAffineTransformMakeRotation(angle);
    }];
    
}

#pragma mark  ----  懒加载
-(UIButton *)addWifiBtn{
    
    if (!_addWifiBtn) {
        
        _addWifiBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_addWifiBtn setFrame:CGRectMake(20, 64, 60, 40)];
        [_addWifiBtn setTitle:@"加入wifi" forState:UIControlStateNormal];
        [_addWifiBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_addWifiBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_addWifiBtn addTarget:self action:@selector(addWifiBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addWifiBtn;
}

-(UIButton *)wifiListBtn{
    
    if (!_wifiListBtn) {
        
        _wifiListBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_wifiListBtn setFrame:CGRectMake(CGRectGetMaxX(self.addWifiBtn.frame) + 20, 64, 60, 40)];
        [_wifiListBtn setTitle:@"wifi列表" forState:UIControlStateNormal];
        [_wifiListBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_wifiListBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_wifiListBtn addTarget:self action:@selector(wifiListBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wifiListBtn;
}

-(UIButton *)startSpeedBtn{
    
    if (!_startSpeedBtn) {
        
        _startSpeedBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_startSpeedBtn setFrame:CGRectMake(CGRectGetMaxX(self.wifiListBtn.frame) + 20, 64, 80, 40)];
        [_startSpeedBtn setTitle:@"开始测速" forState:UIControlStateNormal];
        [_startSpeedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_startSpeedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_startSpeedBtn addTarget:self action:@selector(startSpeedBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startSpeedBtn;
}

-(UIView *)dialView{
    
    if (!_dialView) {
        
        _dialView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, SCREENWIDTH, 136)];
        
        UIImageView * firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table.tiff"]];
        firstImageView.frame = CGRectMake((CGRectGetWidth(_dialView.frame) - 240) / 2, 0, 240, 136);
        [_dialView addSubview:firstImageView];
        self.diaImageView = firstImageView;
        
        UIImageView * secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointer.tiff"]];
        secondImageView.frame = CGRectMake(firstImageView.center.x - 72, CGRectGetMaxY(firstImageView.frame) - 24, 81, 18);
        [_dialView addSubview:secondImageView];
        self.pointImageView = secondImageView;
        /*
         设置锚点（以视图上的哪一点为旋转中心，（0，0）是左下角，（1，1）是右上角，（0.5，0.5）是中心）
         (0.5,roate)就是指针底部圆的圆心位置，我们旋转就是按照这个位置在旋转
         */
        CGRect oldFrame = secondImageView.frame;
        secondImageView.layer.anchorPoint = CGPointMake(0.9, 0.5);
        secondImageView.frame = oldFrame;
    }
    return _dialView;
}

-(UIView *)parameterView{
    
    if (!_parameterView) {
        
        _parameterView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dialView.frame) + 20, SCREENWIDTH, 140)];
        
        NSString * forthStr = @"摄像机网络环境检测";
        float forthWidth = [NSString textWidthWithText:forthStr font:BOLDFONT18 inHeight:22.0];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, forthWidth, 22.0)];
        titleLabel.font = BOLDFONT18;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.text = forthStr;
        [_parameterView addSubview:titleLabel];
        
        float width = [SignalView viewWidthWithStr:@"信号强度"];
        
        //间隔宽度
        float interval = (SCREENWIDTH - width * 3) / 4;
        
        
        SignalView * signalView = [[SignalView alloc] initWithFrame:CGRectMake(interval, CGRectGetMaxY(titleLabel.frame) + 20, width, 44) andImageName:@"signal_def.tiff" andTitle:@"信号强度" andData:@"0"];
        [_parameterView addSubview:signalView];
        self.signalStrengthLabel = signalView.dataLabel;
        
        SignalView * upstreamSpeedView = [[SignalView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(signalView.frame) + interval, CGRectGetMaxY(titleLabel.frame) + 20, width, 44) andImageName:@"Upload_def.tiff" andTitle:@"上行速度" andData:@"0 MB/S"];
        [_parameterView addSubview:upstreamSpeedView];
        self.upstreamSpeedLabel = upstreamSpeedView.dataLabel;
        
        SignalView * downstreamSpeedView = [[SignalView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(upstreamSpeedView.frame) + interval, CGRectGetMaxY(titleLabel.frame) + 20, width, 44) andImageName:@"download_def.tiff" andTitle:@"下行速度" andData:@"0 MB/S"];
        [_parameterView addSubview:downstreamSpeedView];
        self.downstreamSpeedLabel = downstreamSpeedView.dataLabel;
        
    }
    return _parameterView;
}

@end
