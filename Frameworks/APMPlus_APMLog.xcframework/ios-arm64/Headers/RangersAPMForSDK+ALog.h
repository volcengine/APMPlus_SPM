//
//  RangersAPMForSDK+ALog.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2023/5/11.
//

#import <APMPlus_Public/RangersAPMForSDK.h>
#import <APMPlus_APMLog/RangersAPMALogUtil.h>

/**
 Objective-C 日志记录方法，使用方法和 'NSLog' 相似
  
 OC method
 */
#pragma mark - Objective-C

/**
 记录一条 Debug 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_DEBUG(@"100000", @"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_FORSDK_ALOG_DEBUG(SDKID, tag, format, ...)\
@autoreleasepool {RANGERSAPM_FORSDK_ALOG([SDKID UTF8String], kLogLevelDebug, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

/**
 记录一条 Info 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_INFO(@"100000", @"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_FORSDK_ALOG_INFO(SDKID, tag, format, ...)\
@autoreleasepool {RANGERSAPM_FORSDK_ALOG([SDKID UTF8String], kLogLevelInfo, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

/**
 记录一条 Warn 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_WARN(@"100000", @"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_FORSDK_ALOG_WARN(SDKID, tag, format, ...)\
@autoreleasepool {RANGERSAPM_FORSDK_ALOG([SDKID UTF8String], kLogLevelWarn, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

/**
 记录一条 Error 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_ERROR(@"100000", @"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_FORSDK_ALOG_ERROR(SDKID, tag, format, ...)\
@autoreleasepool {RANGERSAPM_FORSDK_ALOG([SDKID UTF8String], kLogLevelError, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

#define NSCHAR_LOG(format, ...) ([[NSString stringWithFormat:format, ##__VA_ARGS__, nil] UTF8String])

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMForSDKConfig (ALog)

/**
 自定义日志配置
 */
@property (nonatomic, strong) RangersAPMALogParams *alogParams;

@end

@interface RangersAPMForSDK (ALog)

/**
 开启自定义日志功能
 */
- (void)setALogEnabled;

/**
 关闭自定义日志功能
 */
- (void)setALogDisabled;

/**
 自定义日志功能是否开启
 */
- (BOOL)isALogEnabled;

/**
 写自定义日志时同时输出到控制台
 */
- (void)enableConsoleLog;

/**
 手动上报自定义日志
 @param fetchStartTime 需要上报的自定义日志的起始时间
 @param fetchEndTime 需要上报的自定义日志的结束时间
 @param callback 上传状态回调，isSuccess == YES 代表上传成功，fileCount 表示本次上报文件个数
 */
- (void)reportALogWithFetchStartTime:(NSTimeInterval)fetchStartTime
                        fetchEndTime:(NSTimeInterval)fetchEndTime
                            callback:(void(^)(BOOL isSuccess, NSInteger fileCount))callback;
/**
 Swift 日志记录方法
 */
#pragma mark - Swift

/**
* 写入Debug Log
* Recommended Usage：RangersAPM.debugALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
- (void)debugALog:(NSString *)format
              tag:(nullable NSString *)tag
         fileName:(NSString *)fileName
         funcName:(NSString *)funcName
             line:(int)line;

/**
* 写入Info Log
* Recommended Usage：RangersAPM.infoALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
- (void)infoALog:(NSString *)format
             tag:(nullable NSString *)tag
        fileName:(NSString *)fileName
        funcName:(NSString *)funcName
            line:(int)line;

/**
* 写入Warn Log
* Recommended Usage：RangersAPM.warnALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
- (void)warnALog:(NSString *)format
             tag:(nullable NSString *)tag
        fileName:(NSString *)fileName
        funcName:(NSString *)funcName
            line:(int)line;

/**
* 写入Error Log
* Recommended Usage：RangersAPM.errorALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
- (void)errorALog:(NSString *)format
              tag:(nullable NSString *)tag
         fileName:(NSString *)fileName
         funcName:(NSString *)funcName
             line:(int)line;


@end

NS_ASSUME_NONNULL_END
