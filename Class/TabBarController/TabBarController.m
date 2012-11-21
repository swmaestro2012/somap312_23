//
//  TabBarController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 4..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        UIImage *tabbar_image_1 = [UIImage imageNamed:@"tabBar_1.png"];
        UIImage *unselected_tabbar_image_1 = [UIImage imageNamed:@"tabBar_1_off.png"];
        
        UIImage *tabbar_image_2 = [UIImage imageNamed:@"tabBar_2.png"];
        UIImage *unselected_tabbar_image_2 = [UIImage imageNamed:@"tabBar_2_off.png"];
        
        UIImage *tabbar_image_3 = [UIImage imageNamed:@"tabBar_3.png"];
        UIImage *unselected_tabbar_image_3 = [UIImage imageNamed:@"tabBar_3_off.png"];
        
        UIImage *tabbar_image_4 = [UIImage imageNamed:@"tabBar_4.png"];
        UIImage *unselected_tabbar_image_4 = [UIImage imageNamed:@"tabBar_4_off.png"];

        
    	mySokMaUmViewCont = [MySokMaUmViewController new];
        UINavigationController *mySokMaUmNaviCont = [[UINavigationController alloc] initWithRootViewController:mySokMaUmViewCont];
        [mySokMaUmViewCont initView];
        [mySokMaUmViewCont.tabBarItem setFinishedSelectedImage:tabbar_image_1 withFinishedUnselectedImage:unselected_tabbar_image_1];
        mySokMaUmViewCont.tabBarItem.tag=0;
//        mySokMaUmViewCont.tabBarItem.title = @"Tab 1";
//        mySokMaUmViewCont.tabBarItem.image = [UIImage imageNamed:@"tabBar_1.png"];
        
        messageViewCont = [MessageViewController new];
        UINavigationController *messageNaviCont = [[UINavigationController alloc] initWithRootViewController:messageViewCont];
        [messageViewCont.tabBarItem setFinishedSelectedImage:tabbar_image_2 withFinishedUnselectedImage:unselected_tabbar_image_2];
        messageViewCont.tabBarItem.tag=1;
        
        heartViewCont = [HeartViewController new];
        UINavigationController *heartNavCont = [[UINavigationController alloc] initWithRootViewController:heartViewCont];
        [heartViewCont.tabBarItem setFinishedSelectedImage:tabbar_image_3 withFinishedUnselectedImage:unselected_tabbar_image_3];
        heartViewCont.tabBarItem.tag=2;
       
        settingViewCont = [SettingViewController new];
        UINavigationController *settingNavCont = [[UINavigationController alloc] initWithRootViewController:settingViewCont];
        [settingViewCont.tabBarItem setFinishedSelectedImage:tabbar_image_4 withFinishedUnselectedImage:unselected_tabbar_image_4];
        settingViewCont.tabBarItem.tag=3;
        settingViewCont.tabBarItem.image = [UIImage imageNamed:@"tabBar_4.png"];
        
        self.viewControllers = [NSArray arrayWithObjects: mySokMaUmNaviCont,
                                            messageNaviCont, heartNavCont, settingNavCont, nil];
        
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    switch (item.tag) {
        case 0:
            [mySokMaUmViewCont initView];
            break;
        case 1:
            [messageViewCont initView];
            break;
        case 2:
            [heartViewCont initView];
            break;
        case 3:
            [settingViewCont initView];
        default:
            break;
    }
    SJ_DEBUG_LOG(@"holahola %d",item.tag);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
