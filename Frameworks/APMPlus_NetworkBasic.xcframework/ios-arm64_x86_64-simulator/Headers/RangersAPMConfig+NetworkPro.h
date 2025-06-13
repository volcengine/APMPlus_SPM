//
//  RangersAPMConfig+NetworkPro.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2022/7/11.
//

#import <APMPlus_Public/RangersAPMConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMConfig (NetworkPro)

/**
 是否开启全链路Tracing，默认否。开启后，如果客户端命中网络监控采样，则会在发起的网络请求中注入 Http Headers，用来和服务端监控链路打通
 
 Enable full link tracing, the default value is NO. After enabled, if the client hits the network monitoring sampling, Http Headers will be injected into the network request initiated to connect with the server tracing
 */
@property (nonatomic, assign) BOOL enableTracing;

@end

NS_ASSUME_NONNULL_END
