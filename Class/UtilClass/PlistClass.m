//
//  PlistClass.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "PlistClass.h"

@implementation PlistClass

+(void) DocumentFileCopy{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPlistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"UserInfo.plist"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:myPlistPath])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:myPlistPath error:&error];
        SJ_DEBUG_LOG(@"파일복사됨");
    }else{
        SJ_DEBUG_LOG(@"파일이있음");
    }
}

+(void) writeIsLock:(NSString *)isLock{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPlistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"UserInfo"]];
    
    NSMutableDictionary *data  = [[NSMutableDictionary alloc]initWithContentsOfFile:myPlistPath];
    
    [data setObject:isLock forKey:@"isLock"];
    [data writeToFile:myPlistPath atomically:YES];
    
    SJ_DEBUG_LOG(@"writeIsLock:%@", isLock);
}

+(NSString *) readIsLock {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPlistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"UserInfo"]];
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:myPlistPath];
    NSString *isLock = [savedStock valueForKey:@"isLock"];
    
    SJ_DEBUG_LOG(@"readIsLock:%@", isLock);
    return isLock;
}

//------------------------------------------------------------------------------------
// new_user, update_user 할 때 쓸 parmeter
//------------------------------------------------------------------------------------
+(void) writeUserInfo:(NSMutableDictionary *)UserInfo{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPlistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"UserInfo"]];
    
    NSMutableDictionary *data  = [[NSMutableDictionary alloc]initWithContentsOfFile:myPlistPath];
    
    [data setObject:UserInfo forKey:@"UserInfo"];
    [data writeToFile:myPlistPath atomically:YES];
    
    SJ_DEBUG_LOG(@"writeUserInfo:%@", UserInfo);
}

+(NSMutableDictionary *) readUserInfo {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPlistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"UserInfo"]];
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:myPlistPath];
    NSMutableDictionary *UserInfo = [savedStock valueForKey:@"UserInfo"];
    
    SJ_DEBUG_LOG(@"readUserInfo:%@", UserInfo);
    return UserInfo;
}
//------------------------------------------------------------------------------------



@end
