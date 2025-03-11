//
//  RangersAPM+CloudCommand.h
//  HeimdallrFinder
//
//  Created by ByteDance on 2023/5/8.
//

#import <APMPlus_Public/RangersAPM.h>
#import <APMPlus_CloudCommand/RangersAPMCustomCommandBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPM (CloudCommand)

/**
 Enable cloud command fetching actively.
 @discussion After calling this, a request will be executed to fetch cloud commands immediately.
 */
+ (void)enableCloudCommand;

/**
 Disable cloud command fetching.
 @discussion After calling this, cloud commands could not be fetched actively.
 */
+ (void)disableCloudCommand;

/**
 Register your custom class.
 @param handlerCls Custom classes must inherit from RangersAPMCustomBaseHandler.
 @discussion Your commands could not be executed until [RangersAPM enableCloudCommand] is called.
*/
+ (void)addCustomCommandHandlerCls:(Class)handlerCls;

@end

NS_ASSUME_NONNULL_END
