//
//  RangersAPM+OOMCrashConfig.h
//  HeimdallrFinder
//
//  Created by Jerry on 2024/9/6.
//

#import <APMPlus_Public/RangersAPM.h>

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

@end

NS_ASSUME_NONNULL_END
