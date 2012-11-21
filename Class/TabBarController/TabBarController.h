//
//  TabBarController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 4..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySokMaUmViewController.h"
#import "MessageViewController.h"
#import "HeartViewController.h"
#import "SettingViewController.h"

@interface TabBarController : UITabBarController {
    
    MySokMaUmViewController *mySokMaUmViewCont;
    MessageViewController *messageViewCont;
    HeartViewController *heartViewCont;
    SettingViewController *settingViewCont;
    
}

@end
