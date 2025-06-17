//
//  RangersAPM+UITracker.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2021/7/8.
//

#import <APMPlus_Public/RangersAPM.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPM (UITracker)

+ (void)switchToMethodExchange __attribute__((deprecated("Obsolete API, use 'disableMethodClassSwizzle' instead.")));

/** 
 Disable the SDK's hook to the '- class' method of the original class.
 
 @discussion By default, the SDK will hook the '- class' method of the original class and return the original class (not the new class after isa swizzle). If some hooks are made to the '- class' method in the host before, it may fail. After calling this method, it may invalidate the judgment similar to self.class == xxx.class in the host code, so it is recommended to call this method only after a problem occurs.
 */
+ (void)disableMethodClassSwizzle;

/**
 Disable all the SDK's isa swizzle to UIViewController.
 
 @discussion By default, the SDK will hook the methods of UIViewController with isa swizzling. In some cases, isa swizzling may conflict with other SDKs. When the conflict cannot be resolved, you can call this method to disable isa swizzling. Instead, you can call the methods of RangersAPMSceneTrace to manually track page loading.
 */
+ (void)disableAllIsaSwizzle;

/**
 Add exempt controller array.
 
 @Note You must call `disableMethodClassSwizzle`, this function will effect.
 @discussion It can solve problems in some special scenarios.
 */
+ (void)addExemptMonitorViewControllerArr:(NSArray<NSString *> *)arr;

@end

NS_ASSUME_NONNULL_END
