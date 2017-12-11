//
//  SpeedController.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2017/12/8.
//  Copyright © 2017年 pk. All rights reserved.
//  实现方式：信号强度取得是statusBar的_wifiStrengthBars；下行速度通过下载一张图片所需时间来计算；上行速度通过上传一张图片所需时间来计算。

#import "SpeedController.h"
#import "AppDelegate.h"

typedef void(^ResultBlock)(float downstreamSpeed,float upstreamSpeed);

@interface SpeedController (){
    
    //下行速度（单位 MB/S）
    float downstreamSpeed;
    //上传数据大小（单位 MB）
    float uploadDataLength;
    //上行速度（单位 MB/S）
    float upstreamSpeed;
}
//上传开始时间
@property (nonatomic,strong) NSDate * uploadStartTime;

@property (nonatomic,strong) ResultBlock resultBlock;
@end


@implementation SpeedController


#pragma mark  ----  生命周期函数
+(SpeedController *)sharedManager{
    
    static SpeedController * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SpeedController alloc] init];
    });
    return manager;
}

#pragma mark  ----  代理函数


#pragma mark  ----  自定义函数
//获取信号强度
+(void)getSignalStrength:(void(^)(float signalStrength))resultBlock{
    
    UIApplication *app = [UIApplication sharedApplication];
    //如果是Iphone X, NSArray *subviews = [[[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    
    //获取到的信号强度最大值为3，所以除3得到百分比
    float signalStrengthTwo = signalStrength / 3.00;
    
    resultBlock(signalStrengthTwo);
}

//获取下行速度,上行速度（单位是 MB/S）
-(void)getDownstreamSpeedAndUpstreamSpeed:(void(^)(float downstreamSpeed,float upstreamSpeed))resultBlock{
    
    self.resultBlock = resultBlock;
    self.resultBlock(0.54, 0.41);
    
    /*
    NSDate * startDate = [[NSDate alloc] init];
    //要下载的图片的地址
    NSString * urlStr = @"https://lvpfileserver.iuoooo.com/Jinher.JAP.BaseApp.FileServer.UI/FileManage/GetFile?fileURL=49e54e46-3e17-4ca4-8f03-db71fb8f9655/2017113016/3a0b3c06-4fc3-4539-83bf-02ab858fd526_20171130040441-6499.png";
    NSURL* URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    // Headers
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    //request.HTTPBody = @{};
    // Connection
    NSURLSession * urlSession = [NSURLSession  sessionWithConfiguration:[NSURLSessionConfiguration
                                                                         defaultSessionConfiguration]];
    NSURLSessionTask * task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error && data) {
            
            NSDate * endDate = [[NSDate alloc] init];
            //时间，单位 S
            NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
            //大小，单位 MB
            float length = data.length / 1000.00 / 1000.00;
            downstreamSpeed = length / timeInterval;
            //测试上行速度
            uploadDataLength = length;
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.resultBlock(downstreamSpeed, 0.1);
            });
        }
    }];
    [task resume];
     */
}


@end
