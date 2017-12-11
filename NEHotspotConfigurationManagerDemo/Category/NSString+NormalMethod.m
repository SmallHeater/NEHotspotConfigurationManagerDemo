//
//  NSString+NormalMethod.m
//  JHCommunication
//
//  Created by Pingk on 15/11/3.
//  Copyright (c) 2015年 SM. All rights reserved.
//

#import "NSString+NormalMethod.h"

@implementation NSString (NormalMethod)

/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
- (BOOL)isEmpty {
    
    
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}


+ (BOOL)contentIsNullORNil:(NSString *)content
{
    if ([content isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([content isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([content isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}


/**
 *  用空白字符替换nil
 *
 *  @return <#return value description#>
 */
+ (NSString *)replaceNilStr:(NSString *)str
{
    if ([self contentIsNullORNil:str]) {
        return @"";
    }
    return str;
}

/**
 *  获取当前时间的秒数
 *
 *  @return 有小数点
 */
+ (NSString *)timeSPOfNow
{
    NSDate *datenow = [NSDate date];//现在时间
    NSTimeInterval interval = [datenow timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%f",interval];
    return timeSp;
}

/**
 *  当前时间戳，用于发送socket消息的消息体
 *
 *  @return 时间戳，不带小数点
 */
+ (NSString *)timestampSince1970
{
    NSDate *datenow = [NSDate date];//现在时间
    NSTimeInterval interval = [datenow timeIntervalSince1970] * 1000;
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",interval];
    return timeSp;
}

/**
 *  时间戳转化时间
 *
 *  @param time 时间戳
 *
 *  @return 时间字符串
 */
+(NSString *)chatTime:(NSString *)time
{
    NSDate *dat = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:dat];
    
    NSString *str = nil;
    NSDate *dat23e = [NSDate date];
    NSString *string = [NSString stringWithFormat:@"%@",dat23e];
    NSString *years = [string substringToIndex:10]; //年月日
    NSString *years2 = [date substringToIndex:10];
    NSString *timeString = [string substringFromIndex:11];
    NSString *timeString2 = [date substringFromIndex:11];
    NSString *timeSecond = [timeString substringToIndex:5];
    NSString *timeSecond2 = [timeString2 substringToIndex:5];
    
    if ([years isEqualToString:years2]) {
        if ([[timeSecond2 substringToIndex:4] isEqualToString:[timeSecond substringToIndex:4]]) {
            if ( ([[timeSecond2 substringFromIndex:4] intValue] - [[timeSecond2 substringFromIndex:4] intValue]) == 0) {
                str = nil;
            }
        }else{
            str = timeSecond2;
        }
    }else{
        if ([[years substringToIndex:4] intValue] - [[years2 substringToIndex:4] intValue] == 0) {
            NSString *s = [years2 substringFromIndex:5];
            NSString *monthsLast = [s substringToIndex:2];
            NSString *dayLast = [s substringFromIndex:3];
            str = [NSString stringWithFormat:@"%@月%@日",monthsLast,dayLast];
            
        }else{
            NSString *s = [years2 substringFromIndex:5];
            NSString *monthsLast = [s substringToIndex:2];
            NSString *dayLast = [s substringFromIndex:3];
            str = [NSString stringWithFormat:@"%@年%@月%@日",[years2 substringToIndex:4],monthsLast,dayLast];
            
        }
    }
    return str;
}

/**
 *  获取GUID
 *
 *  @return <#return value description#>
 */
+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = ( NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString ;
}

/**
 *  聊天消息的日期显示 格式重组
 *
 *  @param date NSDate 的示例
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)timeCount:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //2014 04-30 15:48:51
    NSString * time2 = [formatter stringFromDate:date];
    return [self chatTimeFormatWithDate:time2];
}

/**
 *  转化日期显示
 *
 *  @param time2 按照 “yyyy-MM-dd HH:mm:ss” 格式显示的日期
 *
 *  @return 转化后的日期
 */
+ (NSString *)chatTimeFormatWithDate:(NSString *)time2
{
    //2014 04-30 15:48:51
    NSString *str = nil;
    NSDate *dat23e = [NSDate date];
    NSString *string = [NSString stringWithFormat:@"%@",dat23e];
    NSString *years = [string substringToIndex:10]; //年月日
    NSString *years2 = [time2 substringToIndex:10];
    NSString *timeString = [string substringFromIndex:11];
    NSString *timeString2 = [time2 substringFromIndex:11];
    NSString *timeMiao = [timeString substringToIndex:5];
    NSString *timeMiao2 = [timeString2 substringToIndex:5];
    
    if ([years isEqualToString:years2]) {
        if ([[timeMiao2 substringToIndex:4] isEqualToString:[timeMiao substringToIndex:4]]) {
            if ( ([[timeMiao2 substringFromIndex:4] intValue] - [[timeMiao2 substringFromIndex:4] intValue]) == 0) {
                str = nil;
            }
        }else{
            
            NSString *fen = [timeMiao2 substringToIndex:2];
            timeMiao2 = [timeMiao2 substringToIndex:5];
            
            if ([fen intValue] >=1 && [fen intValue] <= 5) {
                str = [NSString stringWithFormat:@"凌晨%@",timeMiao2];
            }else if ([fen intValue] >=6 && [fen intValue] <= 8){
                
                str = [NSString stringWithFormat:@"早上%@",timeMiao2];
            }else if ([fen intValue] >=9 && [fen intValue] <= 10){
                
                str = [NSString stringWithFormat:@"上午%@",timeMiao2];
                
            }else if ([fen intValue] >=11 && [fen intValue] <= 12){
                
                str = [NSString stringWithFormat:@"中午%@",timeMiao2];
            }
            else if ([fen intValue] >=13 && [fen intValue] <= 17){
                
                str = [NSString stringWithFormat:@"下午%@",timeMiao2];
                
            }else if ([fen intValue] >=18 && [fen intValue] <= 23){
                
                str = [NSString stringWithFormat:@"晚上%@",timeMiao2];
                
            }else if ([fen intValue] == 0){
                str = [NSString stringWithFormat:@"晚上%@",timeMiao2];
            }
        }
    }else if ([[years substringToIndex:4] isEqualToString:[years2 substringToIndex:4]]){
        //前一天
        if ([[years substringFromIndex:8] intValue] - [[years2 substringFromIndex:8] intValue] == 1) {
            NSString *s = [NSString stringWithFormat:@"昨天%@",timeMiao2];
            str = s;
        }else{
            
            NSString *fen = [timeMiao2 substringToIndex:2];
            timeMiao2 = [timeMiao2 substringToIndex:5];
            if ([fen intValue] >=1 && [fen intValue] <= 5) {
                str = [NSString stringWithFormat:@"凌晨%@",timeMiao2];
            }else if ([fen intValue] >=6 && [fen intValue] <= 8){
                
                str = [NSString stringWithFormat:@"早上%@",timeMiao2];
            }else if ([fen intValue] >=9 && [fen intValue] <= 10){
                
                str = [NSString stringWithFormat:@"上午%@",timeMiao2];
                
            }else if ([fen intValue] >=11 && [fen intValue] <= 12){
                
                str = [NSString stringWithFormat:@"中午%@",timeMiao2];
            }
            else if ([fen intValue] >=13 && [fen intValue] <= 17){
                
                str = [NSString stringWithFormat:@"下午%@",timeMiao2];
                
            }else if ([fen intValue] >=18 && [fen intValue] <= 23){
                str = [NSString stringWithFormat:@"晚上%@",timeMiao2];
            }else if ([fen intValue] == 0){
                str = [NSString stringWithFormat:@"晚上%@",timeMiao2];
            }
            NSString *str2 = [time2 substringFromIndex:5];
            str2 = [str2 substringToIndex:5];
            NSString *monthsLast = [str2 substringToIndex:2];
            NSString *dayLast = [str2 substringFromIndex:3];
            str = [NSString stringWithFormat:@"%@月%@日%@",monthsLast,dayLast,str];
        }
    }
    return str;
}

/**
 *  时间戳转化为日期
 *
 *  @param time 时间戳
 *
 *  @return 时间字符串
 */
+(NSString *)getDateLikeMMDD:(NSString *)time
{
    NSDate *dat = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:dat];
    NSString *str = nil;
    NSString *years2 = [date substringToIndex:10];

    NSString *s = [years2 substringFromIndex:5];
    NSString *monthsLast = [s substringToIndex:2];
    NSString *dayLast = [s substringFromIndex:3];
    str = [NSString stringWithFormat:@"%@月%@日",monthsLast,dayLast];
    return str;
}

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param height 指定高度
 *
 *  @return 计算好的宽度
 */
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font inHeight:(CGFloat)height{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize= [text boundingRectWithSize: CGSizeMake(MAXFLOAT, height)                       
                                         options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
    return labelSize.width;
}

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param width 指定宽度
 *
 *  @return 计算好的高度
 */
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font inWidth:(CGFloat)width{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize= [text boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                         options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
    return labelSize.height;
}

/**
 *  获取经过url编码后的字符串
 *
 *  @param str 需要编码的urlString
 *
 *  @return 经过url编码后的字符串
 */
+(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  获取经过url解码后的字符串
 *
 *  @param str 需要解码的urlString
 *
 *  @return 经过url解码后的字符串
 */
+(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}



/**
 *  字符串gbk解码
 *
 *  @param string 需要解码的字符串
 *
 *  @return 经过GBK解码后的字符串
 */
+ (NSString *)decodeGBKEncodingString:(NSString *)string
{
    NSStringEncoding enc  = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *urlencoding = [string stringByReplacingPercentEscapesUsingEncoding:enc];
    return urlencoding;
}


/**
 *  字符串gbk编码
 *
 *  @param string 需要GBK编码的字符串
 *
 *  @return 经过GBK编码后的字符串
 */
+ (NSString *)encodeStringWithGBK:(NSString *)string
{
    NSStringEncoding enc  = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *urlencoding = [string stringByAddingPercentEscapesUsingEncoding:enc];
    return urlencoding;
}

@end
