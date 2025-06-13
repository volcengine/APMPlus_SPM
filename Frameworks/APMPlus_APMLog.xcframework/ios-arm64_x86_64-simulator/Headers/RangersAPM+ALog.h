//
//  RangersAPM+ALog.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2021/7/29.
//

#import <APMPlus_APMLog/RangersAPMALogUtil.h>
#import <APMPlus_Public/RangersAPM.h>

/**
 Objective-C 日志记录方法，使用方法和 'NSLog' 相似
  
 OC method
 */
#pragma mark - Objective-C

/**
 记录一条 Debug 类型的日志，使用方式参考：
 ...
 RANGERSAPM_ALOG_DEBUG(@"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_ALOG_DEBUG(tag, format, ...)\
@autoreleasepool {RANGERSAPM_ALOG(kLogLevelDebug, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

/**
 记录一条 Info 类型的日志，使用方式参考：
 ...
 RANGERSAPM_ALOG_INFO(@"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_ALOG_INFO(tag, format, ...)\
@autoreleasepool {RANGERSAPM_ALOG(kLogLevelInfo, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

/**
 记录一条 Warn 类型的日志，使用方式参考：
 ...
 RANGERSAPM_ALOG_WARN(@"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_ALOG_WARN(tag, format, ...)\
@autoreleasepool {RANGERSAPM_ALOG(kLogLevelWarn, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

/**
 记录一条 Error 类型的日志，使用方式参考：
 ...
 RANGERSAPM_ALOG_ERROR(@"Business", @"version : %@", [self version])
 ...
 */
#define RANGERSAPM_ALOG_ERROR(tag, format, ...)\
@autoreleasepool {RANGERSAPM_ALOG(kLogLevelError, [tag UTF8String], NSCHAR_LOG(format, ##__VA_ARGS__))};

#define NSCHAR_LOG(format, ...) ([[NSString stringWithFormat:format, ##__VA_ARGS__, nil] UTF8String])

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, RangersAPMALogType) {
    RangersAPMALogTypeCustom = 1<<0,  //用户主动打点
    RangersAPMALogTypeMonitor = 1<<1  //SDK 内置打点
};

@interface RangersAPMConfig (ALog)

/**
 自定义日志配置
 */
@property (nonatomic, strong) RangersAPMALogParams *alogParams;

@end

@interface RangersAPM (ALog)

/**
 开启自定义日志功能，必须在 [RangersAPM startWithConfig:] 之后调用
 */
+ (void)setALogEnabled;

/**
 关闭自定义日志功能
 */
+ (void)setALogDisabled;

/**
 自定义日志功能是否开启
 */
+ (BOOL)isALogEnabled;

/**
 写自定义日志时同时输出到控制台
 */
+ (void)enableConsoleLog;

/**
 手动上报用户主动打点产生的自定义日志
 @param fetchStartTime 需要上报的自定义日志的起始时间
 @param fetchEndTime 需要上报的自定义日志的结束时间
 @param callback 上传状态回调，isSuccess == YES 代表上传成功，fileCount 表示本次上报文件个数
 */
+ (void)reportALogWithFetchStartTime:(NSTimeInterval)fetchStartTime
                        fetchEndTime:(NSTimeInterval)fetchEndTime
                            callback:(void(^)(BOOL isSuccess, NSInteger fileCount))callback;

/**
 手动上报多类型自定义日志
 @param logType 需要上报的日志类型，同时上报多种类型示例：RangersAPMALogTypeCustom | RangersAPMALogTypeMonitor
 @param fetchStartTime 需要上报的自定义日志的起始时间
 @param fetchEndTime 需要上报的自定义日志的结束时间
 @param callback 上传状态回调，isSuccess == YES 代表上传成功，fileCount 表示本次上报文件个数
 */
+ (void)reportALogOfType:(RangersAPMALogType)logType 
          fetchStartTime:(NSTimeInterval)fetchStartTime
            fetchEndTime:(NSTimeInterval)fetchEndTime
                callback:(void(^)(BOOL isSuccess, NSInteger fileCount))callback;

/**
 手动上报多类型自定义日志
 @param logType 需要上报的日志类型，同时上报多种类型示例：RangersAPMALogTypeCustom | RangersAPMALogTypeMonitor
 @param fetchStartTime 需要上报的自定义日志的起始时间
 @param fetchEndTime 需要上报的自定义日志的结束时间
 @param detailCallback 上传状态回调，如果同时上报多种类型，回调可能执行多次，logType 标识本次回调上报的类型，isSuccess == YES 代表本次回调上传成功，fileCount 表示本次回调上报文件个数
 */
+ (void)reportALogOfType:(RangersAPMALogType)logType
          fetchStartTime:(NSTimeInterval)fetchStartTime
            fetchEndTime:(NSTimeInterval)fetchEndTime
          detailCallback:(void(^)(RangersAPMALogType logType, BOOL isSuccess, NSInteger fileCount))detailCallback;

/**
 Swift 日志记录方法
 */
#pragma mark - Swift

/**
* 写入Debug Log
* Recommended Usage：RangersAPM.debugALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
+ (void)debugALog:(NSString *)format
              tag:(nullable NSString *)tag
         fileName:(NSString *)fileName
         funcName:(NSString *)funcName
             line:(int)line;

/**
* 写入Info Log
* Recommended Usage：RangersAPM.infoALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
+ (void)infoALog:(NSString *)format
             tag:(nullable NSString *)tag
        fileName:(NSString *)fileName
        funcName:(NSString *)funcName
            line:(int)line;

/**
* 写入Warn Log
* Recommended Usage：RangersAPM.warnALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
+ (void)warnALog:(NSString *)format
             tag:(nullable NSString *)tag
        fileName:(NSString *)fileName
        funcName:(NSString *)funcName
            line:(int)line;

/**
* 写入Error Log
* Recommended Usage：RangersAPM.errorALog("alogtest", tag: "hmd", fileName: #file, funcName: #function, line: #line)
*/
+ (void)errorALog:(NSString *)format
              tag:(nullable NSString *)tag
         fileName:(NSString *)fileName
         funcName:(NSString *)funcName
             line:(int)line;

@end

NS_ASSUME_NONNULL_END
