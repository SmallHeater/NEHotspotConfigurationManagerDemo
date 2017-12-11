//
//  NSString+NormalMethod.h
//  JHCommunication
//
//  Created by Pingk on 15/11/3.
//  Copyright (c) 2015年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (NormalMethod)

/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
- (BOOL)isEmpty;

+ (BOOL)contentIsNullORNil:(NSString *)content;

/**
 *  用空白字符替换nil
 *
 *  @return <#return value description#>
 */
+ (NSString *)replaceNilStr:(NSString *)str;

/**
 *  获取当前时间的秒数
 *
 *  @return 有小数点
 */
+ (NSString *)timeSPOfNow;

/**
 *  当前时间戳，用于发送socket消息的消息体
 *
 *  @return 时间戳，不带小数点
 */
+ (NSString *)timestampSince1970;


/**
 *  时间戳转化时间
 *
 *  @param time 时间戳
 *
 *  @return 时间字符串
 */
+(NSString *)chatTime:(NSString *)time;

/**
 *  获取GUID
 *
 *  @return GUID
 */
+ (NSString *)getUniqueStrByUUID;

/**
 *  聊天消息的日期显示 格式重组
 *
 *  @param date NSDate 的示例
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)timeCount:(NSDate *)date;

/**
 *  转化日期显示
 *
 *  @param time2 按照 “yyyy-MM-dd HH:mm:ss” 格式显示的日期
 *
 *  @return 转化后的日期
 */
+ (NSString *)chatTimeFormatWithDate:(NSString *)time2;

/**
 *  时间戳转化为日期MMDD
 *
 *  @param time 时间戳
 *
 *  @return 时间字符串
 */
+(NSString *)getDateLikeMMDD:(NSString *)time;

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param height 指定高度
 *
 *  @return 计算好的宽度
 */
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font inHeight:(CGFloat)height;

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param width 指定宽度
 *
 *  @return 计算好的高度
 */
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font inWidth:(CGFloat)width;

/**
 *  获取经过url编码后的字符串
 *
 *  @param str 需要编码的urlString
 *
 *  @return 经过url编码后的字符串
 */
+(NSString *)URLEncodedString:(NSString *)str;

/**
 *  获取经过url解码后的字符串
 *
 *  @param str 需要解码的urlString
 *
 *  @return 经过url解码后的字符串
 */
+(NSString *)URLDecodedString:(NSString *)str;

/**
 *  获取URL请求串的参数
 *
 *  @param url 需要解析的url
 *
 *  @return 经过解析后的请求参数集合
 */
+ (NSDictionary*)queryDictionaryWithURL:(NSString*)url;

/**
 *  字符串gbk解码
 *
 *  @param string 需要解码的字符串
 *
 *  @return 经过GBK解码后的字符串
 */
+ (NSString *)decodeGBKEncodingString:(NSString *)string;


/**
 *  字符串gbk编码
 *
 *  @param string 需要GBK编码的字符串
 *
 *  @return 经过GBK编码后的字符串
 */
+ (NSString *)encodeStringWithGBK:(NSString *)string;

@end
