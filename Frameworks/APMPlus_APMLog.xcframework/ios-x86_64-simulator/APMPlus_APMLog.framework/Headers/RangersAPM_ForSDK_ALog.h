//
//  RangersAPM_ForSDK_ALog.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2023/5/11.
//

#ifndef RangersAPM_ForSDK_ALog_h
#define RangersAPM_ForSDK_ALog_h

#include <APMPlus_APMLog/RangersAPMALogUtil.h>

/**
 C、C++ 日志记录方法
 */
#pragma mark - C & C++
/**
 记录一条 DEBUG 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_DEBUG_C("100000", "Business", "version : %s", version())
 */
#define RANGERSAPM_FORSDK_ALOG_DEBUG_C(SDKID,tag,format, ...) RANGERSAPM_FORSDK_ALOG_C(SDKID,kLogLevelDebug, tag, format, ##__VA_ARGS__);

/**
 记录一条 Info 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_INFO_C("100000", "Business", "version : %s", version())
 */
#define RANGERSAPM_FORSDK_ALOG_INFO_C(SDKID,tag,format, ...) RANGERSAPM_FORSDK_ALOG_C(SDKID,kLogLevelInfo, tag, format, ##__VA_ARGS__);

/**
 记录一条 Warn 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_WARN_C("100000", "Business", "version : %s", version())
 */
#define RANGERSAPM_FORSDK_ALOG_WARN_C(SDKID,tag,format, ...) RANGERSAPM_FORSDK_ALOG_C(SDKID,kLogLevelWarn, tag, format, ##__VA_ARGS__);

/**
 记录一条 Error 类型的日志，使用方式参考：
 ...
 RANGERSAPM_FORSDK_ALOG_ERROR_C("100000", "Business", "version : %s", version())
 */
#define RANGERSAPM_FORSDK_ALOG_ERROR_C(SDKID,tag,format, ...) RANGERSAPM_FORSDK_ALOG_C(SDKID,kLogLevelError, tag, format, ##__VA_ARGS__);


#endif /* RangersAPM_ForSDK_ALog_h */
