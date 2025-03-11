//
//  RangersAPM+PerformanceAPI.h
//  Pods
//
//  Created by xuminghao.eric on 2020/8/4.
//

#import <APMPlus_Public/RangersAPM.h>
#import <APMPlus_Monitors/RangersAPMPerformanceErrorType.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMConfig (PerformanceAPI)

/**
 如果需要手动控制启动trace的终点，设置此属性为YES。在调用[RangersAPM finishLaunchTrace]之前，我们不会记录启动trace日志。
 If you want finish start-trace manually, set this property to YES. And we will not record the start-trace log until [RangersAPM finishLaunchTrace] is called.
 */
@property (nonatomic, assign) BOOL customFinishStartTrace;

@end

@interface RangersAPM (PerformanceAPI)

/**
 记录一个自定义启动阶段的起点，在某些情况下，接口会返回一个error，可以在头文件 RangersPerformanceErrorType.h 中了解错误原因。
 
 Begin a span with spanName.
 
 @param spanName Name of the span you will add.
 @discussion An error may be returned in some cases, and you can understand the error through the header file named "RangersPerformanceErrorType.h".
 */
+ (void)beginLaunchSpan:(NSString *)spanName callback:(RangersAPMStartDetectorCallback _Nullable)callback;

/**
 记录一个已经添加过的启动阶段的终点，在某些情况下，接口会返回一个error，可以在头文件 RangersPerformanceErrorType.h 中了解错误原因。
 
 End a span with spanName.
 
 @param spanName Name of the span you have added.
 @discussion An error may be returned in some cases, and you can understand the error through the header file named "RangersPerformanceErrorType.h".
 */
+ (void)endLaunchSpan:(NSString *)spanName callback:(RangersAPMStartDetectorCallback _Nullable)callback;

/**
 添加一个自定义启动阶段，在某些情况下，接口会返回一个error，可以在头文件 RangersPerformanceErrorType.h 中了解错误原因。 请传入以 毫秒 为单位的时间戳
 
 Add a span with spanName, startTime and EndTime.
 
 @param spanName Name of the span you will add.
 @param startTime Time in milliseconds when the span you will add started.
 @param endTime Time in milliseconds when the span you will add ended.
 @discussion An error may be returned in some cases, and you can understand the error through the header file named "RangersPerformanceErrorType.h".
 */
+ (void)addSpan:(NSString *)spanName startTimeMs:(NSTimeInterval)startTime endTimeMs:(NSTimeInterval)endTime callback:(RangersAPMStartDetectorCallback _Nullable)callback;

/**
 手动结束启动trace并记录日志，如果需要使用此方法来手动控制启动trace的结束，请在SDK初始化时配置 RangersAPMConfig.customFinishStartTrace 属性，否则，该方法调用不会生效
 
 Finish start-trace and record the log manually. If you want to control the end of start-trace manually by this method, please set the property RangersAPMConfig.customFinishStartTrace to YES before the SDK is started.
 */
+ (void)finishLaunchTrace;

/**
 自主检测 Prewarm，根据 prewarmCheckEnd - prewarmCheckStart 的值判断是否发生 Prewarm，并校准启动时间。详见官网文档 https://www.volcengine.com/docs/6431/69526
 
 Detect prewarm autonomously, judge whether prewarm occurs according to the value of "prewarmCheckEnd - prewarmCheckStart", and calibrate the launch time. See the official website documentation for details https://www.volcengine.com/docs/6431/69526
 */
+ (void)prewarmCheckStart;
+ (void)prewarmCheckEnd;

/**
 如果需要手动控制启动trace的终点，请调用此方法。在调用[RangersAPM finishLaunchTrace]之前，我们不会记录启动trace日志。
 
 If you want finish start-trace manually, call this method. And we will not record the start-trace log until [RangersAPM finishLaunchTrace] is called.
 */
+ (void)setFinishStartTraceManually;

/**
 如果不能在 application:didFinishLaunchingWithOptions: 一开始初始化 SDK，请先调用此方法，避免启动时长产生较大误差
 ⚠️ 调用此方法后可能会提前结束启动链路，如果需要手动控制启动链路的终点，请提前调用[RangersAPM setFinishStartTraceManually]

 If the SDK cannot be initialized at the beginning of application:didFinishLaunchingWithOptions:, please call this method first to avoid large errors in the launch time.
 ⚠️ Calling this method may end the start-trace early. If you need to manually control the end point of the start-trace, please call [RangersAPM setCustomFinishStartTrace] in advance.
 */
+ (void)applicationDidFinishLaunching;

+ (void)beginLaunchSpan:(NSString *)spanName __attribute__((deprecated("Please use beginLaunchSpan:callback:")));

+ (void)endLaunchSpan:(NSString *)spanName __attribute__((deprecated("Please use endLaunchSpan:callback:")));

@end

NS_ASSUME_NONNULL_END
