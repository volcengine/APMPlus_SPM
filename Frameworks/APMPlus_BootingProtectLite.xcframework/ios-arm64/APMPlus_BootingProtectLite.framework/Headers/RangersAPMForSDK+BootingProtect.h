//
//  RangersAPMForSDK+BootingProtect.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2022/5/25.
//

#import <APMPlus_Public/RangersAPMForSDK.h>
#import <APMPlus_BootingProtectLite/RangersAPMBootingInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMForSDK (BootingProtect)

/**
 @abstract start booting protect
 开始"启动崩溃"保护逻辑
 @param bootingThreshold booting crash threshold, only when app crashed before threshold, we will execute handler. If the threshold is 0 or less, whether app crashed before threshold, the handler will be executed.
 "启动崩溃"阈值，只有APP在阈值触达之前发生崩溃，才会认为是一次启动崩溃，如果阈值小于或等于0，无论APP何时崩溃，保护逻辑都会被执行
 @param handler consecutive crash handler, read <APMPlus_BootingProtectLite/RangersAPMBootingInfo.h> for more information. ⚠️The handler will be synchronized to the main thread.
 "启动崩溃"保护逻辑，当APP连续发生了启动崩溃之后，会执行此回调。⚠️回调会被同步到主线程执行
 */
- (void)startProtectWithBootingThreshold:(NSTimeInterval)bootingThreshold bootingCrashHandler:(nonnull RangersAPMBootingCrashHandler)handler;

@end

NS_ASSUME_NONNULL_END
