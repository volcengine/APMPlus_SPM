//
//  RangersAPMOOMRecord.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2025/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMOOMRecord : NSObject

/// OOM 时间戳（秒级）
/// Timestamp of the OOM event
@property (nonatomic, assign) CFTimeInterval timestamp;

/// 使用时长（秒）
/// Duration of app usage (seconds)
@property (nonatomic, assign) CFTimeInterval inAppTime;

/// 操作系统版本号
/// Operating system version
@property (nonatomic, copy) NSString *osVersion;

/// 应用版本号
/// Application version 
@property (nonatomic, copy) NSString *appVersion;

/// 构建版本号
/// Build version
@property (nonatomic, copy) NSString *buildVersion;

/// RangersAPM SDK 版本号
/// RangersAPM SDK version
@property (nonatomic, copy) NSString *sdkVersion;

/// OOM 发生时应用占用内存（MB）
/// App used memory (MB) at the time of OOM
@property(nonatomic, assign) double appUsedMemory;

/// OOM 发生时系统可用内存（MB）
/// Device free memory (MB) at the time of OOM
@property(nonatomic, assign) double deviceFreeMemory;

/// OOM 发生时可用磁盘空间（字节）
/// Free disk space (bytes) at the time of OOM
@property(nonatomic, assign) double freeDiskSpace;

/// OOM 发生时的页面名称
/// Page name at the time of OOM
@property(nonatomic, strong) NSString *lastScene;

/// 额外自定义参数，通过 [RangersAPM setCustomContextValue:forKey:] 设置
/// Custom parameters set via [RangersAPM setCustomContextValue:forKey:]
@property(nonatomic, strong) NSDictionary<NSString*, id> *customContexts;

/// 自定义过滤标签，通过 [RangersAPM setCustomFilterValue:forKey:] 设置
/// Filter tags set via [RangersAPM setCustomFilterValue:forKey:]
@property(nonatomic, strong) NSDictionary<NSString*, id> *customFilters;

/// 用户访问页面记录 {
///      "recent_access_scenes": [
///       {
///          "scene": "page_name",
///          "timestamp": 1763600000000
///        }
///      ]
///    }
/// User visit page records
@property(nonatomic, strong) NSDictionary *operationTrace;

/// 日志信息（SDK 采集的关键日志）
/// Log information (key logs collected by the SDK)
@property(nonatomic, copy) NSString *loginfo; 

@end

NS_ASSUME_NONNULL_END
