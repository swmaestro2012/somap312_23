//
//  PlistClass.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistClass : NSObject

+(void) DocumentFileCopy;
+(void) writeIsLock:(NSString *)isLock;
+(NSString *) readIsLock;

+(void) writeUserInfo:(NSMutableDictionary *)UserInfo;
+(NSMutableDictionary *) readUserInfo;

@end
