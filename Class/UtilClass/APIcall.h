//
//  APIcall.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 6..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define API_URL @"http://www.sokmaum.com/api"
#define API_Authorization_Name @"dev"
#define API_Authorization_PassWord @"thrakdma"

/*
@protocol APIcallDelegate <NSObject>
@required
@optional
-(void)apiCallSucess:(id)result;
-(void)apiCallFail:(NSError *)error;
@end
 */

@interface APIcall : NSObject    

// User Field
+(void)new_user:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)update_user:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)get_info:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)choice:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)set_choice:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)check_matching:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;

//Message Field
+(void)get_message:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)get_message_history:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)send_message:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;

//Heart Field
+(void)history_heart:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)add_heart:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;
+(void)delete_heart:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;


// Sokmaum Field
+(void)sokmaum_get_info:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2;


@end
