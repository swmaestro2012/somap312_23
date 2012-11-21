//
//  APIcall.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 6..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "APIcall.h"
#import "AFNetworking.h"

@implementation APIcall
//@synthesize delegate;

# pragma USER FIELD

/*
Status 정리
 reject - 찍은 사람이 상태 포기
 giveup - 찍힌 사람이 거부
 waiting - 상대방이 확인을 안함
 conflict - 메세지는 오고 갔지만 아직 결정을 안했음
 matched - 둘이 연결 됨
*/

//------------------------------------------------------------------
//  new_user
//  신규 유저 가입
//  Field       : User
//  API         : /new_user
//  Parameter   : /name/email/info/facebook_id/facebook_photoUrl
//------------------------------------------------------------------
+(void)new_user:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API new_user ****************");

    NSString *path = @"http://www.sokmaum.com/api/user/new_user";
    NSURL *url = [NSURL URLWithString:path];

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];

    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        SJ_DEBUG_LOG(@"new_user API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        // code for failed request goes here
        // do something on failure
        SJ_DEBUG_LOG(@"new_user API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
    }];
    
    [operation start];
}

//------------------------------------------------------------------
//  update_user
//  유저 업데이트
//  Field       : User
//  API         : /update_user
//------------------------------------------------------------------
+(void)update_user:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API update_user ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/user/update_user";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        SJ_DEBUG_LOG(@"update_user API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        // code for failed request goes here
        // do something on failure
        SJ_DEBUG_LOG(@"update_user API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
    }];
    
    [operation start];
}



//------------------------------------------------------------------
//  get_info
//  유저 정보 
//  Field       : User
//  API         : /get_info
//  Parameter   : /userIdx
//------------------------------------------------------------------
+(void)get_info:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API get_info ****************");

    NSString *path = @"http://www.sokmaum.com/api/user/get_info";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"get_info API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];


    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"get_info API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];

    }];
    
    [operation start];
}

//------------------------------------------------------------------
//  choice
//  상대방 선택(호감 표시 하기)
//  Field       : User
//  API         : /choice
//  Parameter   : /userIdx/targetUserIdx
//------------------------------------------------------------------
+(void)choice:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{ 
    
    SJ_DEBUG_LOG(@"**************** Calling API choice ****************");

    NSString *path = @"http://www.sokmaum.com/api/user/choice";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"choice API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];

        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"choice API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
        
    }];

    [operation start];
}



//------------------------------------------------------------------
//  set_choice
//  선택한 상대방 상태 변경
//  Field       : User
//  API         : set_choice
//  Parameter   : /userIdx/targetUserIdx/state
//------------------------------------------------------------------
+(void)set_choice:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API set_choice ****************");

    NSString *path = @"http://www.sokmaum.com/api/user/set_choice";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"set_choice API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];

    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"set_choice API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];

    }];
    
    [operation start];
}



//------------------------------------------------------------------
//  check_matching
//  선택한 상대방 상태 변경
//  Field       : User
//  API         : check_matching
//  Parameter   : /userIdx/targetUserIdx
//------------------------------------------------------------------
+(void)check_matching:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API check_matching ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/user/check_matching";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"check_matching API CALL success with result : \n %@",JSON);
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"check_matching API CALL failed with result : \n %@",error);
        
    }];
    
    [operation start];
}

# pragma USER END


# pragma MESSAGE FIELD
//------------------------------------------------------------------
//  get_message
//  사용자가 받은 메시지를 알려준다.
//  Field       : message
//  API         : get_info
//  Parameter   : facebook_id 
//------------------------------------------------------------------
+(void)get_message:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{

    SJ_DEBUG_LOG(@"**************** Calling API get_message ****************");

    NSString *path = @"http://www.sokmaum.com/api/message/get_message";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"get_message API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"get_message API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
    }];
    
    [operation start];
}

//------------------------------------------------------------------
//  get_message_history
//  사용자가 다른 사용자에게 보낸 메시지를 알려준다.
//  Field       : message
//  API         : get_message_history
//  Parameter   : from_facebook_id / to_facebook_id
//------------------------------------------------------------------
+(void)get_message_history:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API get_message_history ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/message/get_message_history";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"get_message_history API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"get_message_history API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
    }];
    
    [operation start];

}

//------------------------------------------------------------------
//  send_message
//  사용자가 다른 사용자에게 보낸 메시지를 알려준다.
//  Field       : message
//  API         : send_message
//  Parameter   : from_facebook_id / to_facebook_id / message
//------------------------------------------------------------------
+(void)send_message:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API send_message_history ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/message/send_message";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"get_message_history API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"get_message_history API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
    }];
    
    [operation start];
}


# pragma MESSAGE END







# pragma HEART FIELD
//------------------------------------------------------------------
//  history_heart
//  하트 적립/사용 내역 출력.
//  Field       : heart
//  API         : history_heart
//  Parameter   : facebook_id
//------------------------------------------------------------------
+(void)history_heart:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API history_heart ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/heart/history_heart";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"history_heart API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"history_heart API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
        
        
    }];
    
    [operation start];
}


//------------------------------------------------------------------
//  add_heart
//  하트 적립
//  Field       : heart
//  API         : add_heart
//  Parameter   : facebook_id / count / type
//------------------------------------------------------------------
+(void)add_heart:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API add_heart ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/heart/add_heart";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"add_heart API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"add_heart API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
        
        
    }];
    
    [operation start];

}



//------------------------------------------------------------------
//  delete_heart
//  하트 적립
//  Field       : heart
//  API         : delete_heart
//  Parameter   : facebook_id / count / type
//------------------------------------------------------------------
+(void)delete_heart:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API delete_heart ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/heart/delete_heart";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"add_heart API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"add_heart API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];
        
        
    }];
    
    [operation start];
    
}



# pragma HEART END









# pragma Sokmaum FIELD
//------------------------------------------------------------------
//  get_info
//  선택한 상대방 상태 변경
//  Field       : sokmaum
//  API         : get_info
//  Parameter   : 없음
//------------------------------------------------------------------
+(void)sokmaum_get_info:(id)delegateOwner withParameter:(NSDictionary *)parameter SuccessSelector:(SEL)sel1 failSelector:(SEL)sel2{
    
    SJ_DEBUG_LOG(@"**************** Calling API sokmaum_get_info ****************");
    
    NSString *path = @"http://www.sokmaum.com/api/sokmaum/get_info";
    NSURL *url = [NSURL URLWithString:path];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient clearAuthorizationHeader];
    [httpClient setAuthorizationHeaderWithUsername:API_Authorization_Name password:API_Authorization_PassWord];
    
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:parameter];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // code for successful return goes here
        // do something with return data
        
        SJ_DEBUG_LOG(@"sokmaum_get_info API CALL success with result : \n %@",JSON);
        [delegateOwner performSelector:sel1 withObject:JSON];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        // do something on failure
        
        SJ_DEBUG_LOG(@"sokmaum_get_info API CALL failed with result : \n %@",error);
        [delegateOwner performSelector:sel2 withObject:error];

        
    }];
    
    [operation start];
}

# pragma Sokmaum END





/*
 AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
 [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 SJ_DEBUG_LOG(@"choice API CALL success with result : \n %@",operation.responseString);
 NSDictionary *information = [[NSDictionary alloc]initWithObjectsAndKeys: responseObject , @"info", nil];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"new_user_SUCCESS" object:nil userInfo:information];
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 SJ_DEBUG_LOG(@"choice API CALL success with result : \n %@",error);
 NSDictionary *information = [[NSDictionary alloc]initWithObjectsAndKeys: error , @"info", nil];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"new_user_FAIL" object:nil userInfo:information];
 
 }];
 */


@end
