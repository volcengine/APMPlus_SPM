//
//  RangersAPMALogUtil.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2021/8/5.
//

#ifndef RangersAPMALogUtil_h
#define RangersAPMALogUtil_h

#ifdef __FILE_NAME__
#define __RANGERSAPM_ALOG_FILE_NAME__ __FILE_NAME__
#else
#define __RANGERSAPM_ALOG_FILE_NAME__ __FILE__
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define RANGERSAPM_ALOG(_level, _tag, _format, ...)\
do{\
rangers_apm_log_write(__RANGERSAPM_ALOG_FILE_NAME__, __FUNCTION__, _tag, _level, __LINE__, _format);\
}while(0);\

#define RANGERSAPM_ALOG_C(_level, _tag, _format, ...)\
do{\
rangers_apm_log_write_var(__RANGERSAPM_ALOG_FILE_NAME__, __FUNCTION__, _tag, _level, __LINE__, _format, ##__VA_ARGS__);\
}while(0);\

typedef enum {
    kLogLevelDebug = 0,    // Detailed information on the flow through the system.
    kLogLevelInfo = 1,     // Interesting runtime events (startup/shutdown), should be cautious and keep to a minimum.
    kLogLevelWarn = 2,     // Other runtime situations that are undesirable or unexpected, but not necessarily "wrong".
    kLogLevelError = 3,    // Other runtime errors or unexpected conditions.
} kRangersAPMALogLevel;

void rangers_apm_log_write_var(const char *_filename, const char *_func_name, const char *_tag, kRangersAPMALogLevel _level, int _line, const char * _format, ...);

void rangers_apm_log_write(const char *_filename, const char *_func_name, const char *_tag, kRangersAPMALogLevel _level, int _line, const char * _format);


#define RANGERSAPM_FORSDK_ALOG(_SDKID, _level, _tag, _format, ...)\
do{\
rangers_apm_for_SDK_log_write(_SDKID, __RANGERSAPM_ALOG_FILE_NAME__, __FUNCTION__, _tag, _level, __LINE__, _format);\
}while(0);\

#define RANGERSAPM_FORSDK_ALOG_C(_SDKID, _level, _tag, _format, ...)\
do{\
rangers_apm_for_SDK_log_write_var(_SDKID, __RANGERSAPM_ALOG_FILE_NAME__, __FUNCTION__, _tag, _level, __LINE__, _format, ##__VA_ARGS__);\
}while(0);\

void rangers_apm_for_SDK_log_write_var(const char *SDKID, const char *_filename, const char *_func_name, const char *_tag, kRangersAPMALogLevel _level, int _line, const char * _format, ...);

void rangers_apm_for_SDK_log_write(const char *SDKID, const char *_filename, const char *_func_name, const char *_tag, kRangersAPMALogLevel _level, int _line, const char * _format);

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* RangersAPMALogUtil_h */

#ifdef __OBJC__
@interface RangersAPMALogParams : NSObject

/**
 自定义日志可以占用的最大磁盘空间，单位 byte，默认值 50 * 1024 * 1024
 模块启动时会按照配置的空间的 2/3 清理最早文件，以默认值为例，逐个删除最早文件直至剩余文件总大小低于 50 * 1024 * 1024 * 2/3
 */
@property (nonatomic, assign) NSUInteger maxDiskUsage;

/**
 自定义文件有效时长，单位 s，默认值 7 * 24 * 60 * 60
 模块启动时，会根据有效时长清理所有过期文件
 */
@property (nonatomic, assign) NSUInteger validityPeriod;

@end
#endif //__OBJC__
