//
//  RangersAPM+UserException.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2020/10/22.
//

#import <APMPlus_Public/RangersAPM.h>
#import <mach/mach_types.h>
#import <APMPlus_UserException/RangersAPMUserExceptionErrorType.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPM (UserException)

/**
 当同一种自定义异常记录间隔小于 interval 时，接口会返回 RangersAPMUserExceptionFailTypeExceedsLimiting 错误
 
 @param interval 允许重复记录同一种自定义异常的最小间隔，默认值 60s
 @discussion 相同的 exceptionType 认为是同一种自定义异常
 */
+ (void)setRepeatTrackInterval:(NSTimeInterval)interval;

/**
 记录一条自定义异常事件，不抓取调用栈
 
 @param exceptionType 异常类型，不可为空
 @param title 自定义异常标题（用于聚合），不可为空
 @param subTitle 自定义异常子标题（用于聚合），不可为空
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 */
+ (void)trackUserExceptionWithExceptionType:(NSString *)exceptionType
                                      title:(NSString *)title
                                   subTitle:(NSString *)subTitle
                               customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                                    filters:(NSDictionary<NSString *, id> *_Nullable)filters
                                   callback:(RangersAPMUserExceptionCallback)callback;

/**
 记录一条自定义异常事件并且上报所有线程的调用栈，指定当前线程作为关键线程

 @param exceptionType 异常类型，不可为空
 @param skippedDepth 忽略的frame数量，取决你想忽略掉多少个你调用链顶部的frame
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 */
+ (void)trackAllThreadsLogExceptionType:(NSString *)exceptionType
                           skippedDepth:(NSUInteger)skippedDepth
                           customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                                filters:(NSDictionary<NSString *, id> *_Nullable)filters
                               callback:(RangersAPMUserExceptionCallback)callback;

/**
 记录一条自定义异常事件并且上报所有线程的调用栈，可以指定某个线程作为关键线程

 @param exceptionType 异常类型，不可为空
 @param keyThread 关键线程
 @param skippedDepth 忽略的frame数量，取决你想忽略掉多少个你调用链顶部的frame
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 */
+ (void)trackAllThreadsLogExceptionType:(NSString *)exceptionType
                              keyThread:(thread_t)keyThread
                           skippedDepth:(NSUInteger)skippedDepth
                           customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                                filters:(NSDictionary<NSString *, id> *_Nullable)filters
                               callback:(RangersAPMUserExceptionCallback)callback;

/**
 记录一条自定义异常事件并且上报当前线程的调用栈

 @param exceptionType 异常类型，不可为空
 @param skippedDepth 忽略的frame数量，取决你想忽略掉多少个你调用链顶部的frame
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 */
+ (void)trackCurrentThreadLogExceptionType:(NSString *)exceptionType
                              skippedDepth:(NSUInteger)skippedDepth
                              customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                                   filters:(NSDictionary<NSString *, id> *_Nullable)filters
                                  callback:(RangersAPMUserExceptionCallback)callback;

/**
 记录一条自定义异常事件并且上报主线程的调用栈

 @param exceptionType 异常类型，不可为空
 @param skippedDepth 忽略的frame数量，取决你想忽略掉多少个你调用链顶部的frame
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 */
+ (void)trackMainThreadLogExceptionType:(NSString *)exceptionType
                           skippedDepth:(NSUInteger)skippedDepth
                           customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                                filters:(NSDictionary<NSString *, id> *_Nullable)filters
                               callback:(RangersAPMUserExceptionCallback)callback;

/**
 记录一条自定义异常事件并且上报指定线程的调用栈

 @param exceptionType 异常类型，不可为空
 @param thread 指定线程
 @param skippedDepth 忽略的frame数量，取决你想忽略掉多少个你调用链顶部的frame
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 */
+ (void)trackThreadLogExceptionType:(NSString *)exceptionType
                             thread:(thread_t)thread
                       skippedDepth:(NSUInteger)skippedDepth
                       customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                            filters:(NSDictionary<NSString *, id> *_Nullable)filters
                           callback:(RangersAPMUserExceptionCallback)callback;

/**
 记录一条自定义异常事件，使用 exception 捕获的调用栈

 @param exception 用户自行捕获的异常，不可为空
 @param customParams 自定义的现场信息，可在平台详情页中展示
 @param filters 自定义的筛选项，可在平台列表页中筛选
 @param callback 日志是否记录成功的回调，如果失败的话NSError非空，errcode的定义见RangersAPMUserExceptionFailType枚举
 @discussion 以 NSException.name 作为 exceptionType
 */
+ (void)trackExceptionWithException:(NSException *)exception
                       customParams:(NSDictionary<NSString *, id> *_Nullable)customParams
                            filters:(NSDictionary<NSString *, id> *_Nullable)filters
                           callback:(RangersAPMUserExceptionCallback)callback;

@end

NS_ASSUME_NONNULL_END
