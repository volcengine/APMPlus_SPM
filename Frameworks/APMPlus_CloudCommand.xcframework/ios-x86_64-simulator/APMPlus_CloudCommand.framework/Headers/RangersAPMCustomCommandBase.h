//
//  RangersAPMCustomBaseHandler.h
//  HeimdallrFinder
//
//  Created by ByteDance on 2023/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMCustomCommandResult : NSObject

/// File name to be uploaded
@property (nonatomic, copy, nullable) NSString *fileName;

/// File data to be uploaded
@property (nonatomic, strong, nullable) NSData *data;

/// Memory data to be uploaded
@property (nonatomic, strong) NSDictionary *specificParams;

/// If an error occurs while processing the data. You can assign error messages to this variable.
/// We will pass this information back to the platform.
/// NOTE: If you set this value, we won't care data's value.
@property (nonatomic, strong, nullable) NSError *error;

@end

typedef void(^RangersAPMCustomCommandCompletion)(RangersAPMCustomCommandResult *result);

/**
 RangersAPMCustomBaseHandler is an abstract class. Therefore, none of its methods will do anything.
 */
@interface RangersAPMCustomCommandBase : NSObject

/**
 Custom commandID.
 NOTE: Subclasses must implement.
*/
+ (NSString *)cloudCommandIdentifier;

/**
 Create instance variables for executing instructions.
 NOTE: Subclasses must implement.
*/
+ (instancetype)createInstance;

/**
 Execute custom commands.
 NOTE: Subclasses must implement.
@param params The information you configure on the platform.
@param completion Call it for uploading.
*/
- (void)executeCustomCommandWithParams:(NSDictionary *)params completion:(RangersAPMCustomCommandCompletion)completion;


/**
 Upload the result to the server successfully.
 NOTE: Subclass optional implementation.
@param params The information you configure on the platform.
*/
- (void)uploadCustomCommandResultSucceededWithParams:(NSDictionary *)params;

/**
 Failed to upload results to server.
 NOTE: Subclass optional implementation.
@param params The information you configure on the platform.
@param error An error that occurred in the network.
*/
- (void)uploadCustomCommandResultFailedWithParams:(NSDictionary *)params error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
