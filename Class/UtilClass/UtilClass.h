//
//  UtilClass.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilClass : NSObject
+(void)changeFont:(UIView *)targetView;
+(void)showAlertWithNoDelegate:(NSString *)message;
+(UIImage *)characterImage:(NSString *)characterNumber;


@end
