//
//  RangersAPM+OOMCrashConfig.h
//  HeimdallrFinder
//
//  Created by Jerry on 2024/9/6.
//

#import <APMPlus_Public/RangersAPM.h>
#import <APMPlus_OOM/RangersAPMOOMRecord.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPM (OOMCrashConfig)

/**
 声明程序运行在自动化测试中。若 isAutoTest 传递为 YES，会屏蔽掉所有的 OOM 问题。默认是NO。
 注意：
    1. 请不要在生产环境中调用此函数，否则会造成 OOM 数据不会上报。
    2. 请在初始化 APM 之前，即 +[RangersAPM startWithConfig:] 函数执行之前，调用该函数。
 
 Declare that the program is running in automated testing. If isAutoTest is passed as YES, all OOM problems will be blocked. Default is NO.
 Notice: 
    1. Please do not call this function in a production environment, otherwise OOM data will not be reported.
    2. Call this function before initializing APM, that is, before the +[RangersAPM startWithConfig:] function executes.
 */
+ (void)OOMCrashMarkAutoTest:(BOOL)isAutoTest;

/**
 定义疑似 OOM 崩溃回调类型。参数 record 表示一次疑似 OOM 的上下文记录，可能为 nil。
 记录包含：时间戳、在 App 中的时长、系统/应用版本、内存/磁盘指标、最后场景、操作轨迹、自定义参数、过滤标签以及日志信息。
 
 Defines the callback type for suspected OOM crash. The parameter record carries context for a suspected OOM and may be nil.
 The record includes: timestamp, in-app duration, OS/app versions, memory/disk metrics, last scene, operation trace, custom params, filter tags, and log info.
 */
typedef void (^RangersAPMOOMCrashCallback)(RangersAPMOOMRecord* _Nullable record);
/**
 设置疑似 OOM 崩溃回调。当 SDK 排除 watchdog、普通 crash 等原因后判断为可能的 OOM 时触发。
 注意：
    1. 请在初始化 APM 之前（即 +[RangersAPM startWithConfig:] 调用之前）设置，以保证首启即可生效。
    2. 回调可能在非主线程触发，请避免在其中执行耗时或需主线程的操作。
    3. 若仅上报“确定的 OOM”（APMPlus 控制台配置），疑似 OOM 将仅通过该回调返回而不进行上传。
 
 Set the callback for suspected OOM crash. It fires when the SDK considers a possible OOM after excluding watchdog and regular crashes.
 Notice:
    1. Set this before initializing APM (before calling +[RangersAPM startWithConfig:]) to take effect from the first launch.
    2. The callback may be invoked off the main thread; avoid heavy work or main-thread-dependent operations inside it.
    3. If only “certain OOMs” are uploaded (APMPlus console configuration), non-certain OOMs will be returned via this callback without uploading.
 */
+ (void)setMaybeOOMCrashCallback:(RangersAPMOOMCrashCallback)callback;

@end

NS_ASSUME_NONNULL_END
