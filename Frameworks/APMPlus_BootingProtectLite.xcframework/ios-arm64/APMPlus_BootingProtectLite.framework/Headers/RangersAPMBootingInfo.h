//
//  RangersAPMBootingInfo.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2022/5/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    RangersAPMExitReasonOther = 0,
    RangersAPMExitReasonCrash = 1,
    RangersAPMExitReasonWatchdog = 2,
    RangersAPMExitReasonOOM = 3
} RangersAPMExitReason;


@interface RangersAPMBootingInfo : NSObject

/**
 Exceptions occurred in your app consecutively over the past few launches.
 */
@property (nonatomic, assign, readonly) NSUInteger consecutiveExceptionTimes;

/**
 The count of crashes over the past few launches.
 */
@property (nonatomic, assign, readonly) NSUInteger crashTimes;

/**
 The count of watchdogs over the past few launches.
 */
@property (nonatomic, assign, readonly) NSUInteger watchdogTimes;

/**
 The count of OOMs over the past few launches.
 */
@property (nonatomic, assign, readonly) NSUInteger OOMTimes;

@end


typedef void (^RangersAPMBootingCrashHandler)(RangersAPMBootingInfo *info);

NS_ASSUME_NONNULL_END
