//
//  SettingViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch *lockSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *pushSwitch;



-(void)initView;
@end
