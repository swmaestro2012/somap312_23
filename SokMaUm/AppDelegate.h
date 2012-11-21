//
//  AppDelegate.h
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 28..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilClass.h"
#import "APIcall.h"
#import "popUpView.h"
#import "LoadingView.h"

@class ViewController;
@class TabBarController;
#define SOKMAUM_APP (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define FACEBOOK_APP_ID @"162654023878492"
#define FACEBOOK_SECRET_ID @"920c2a72211d9add98e8f464d559c221"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    ViewController *viewCont;
    TabBarController *rootViewCont;
    
    NSTimer *loadingTimer;
    int loadingSeconds;
}

extern NSString *const FBSessionStateChangedNotification;


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) NSString *facebookAccessToken;
@property (strong, nonatomic) NSString *facebookID;
@property (strong, nonatomic) LoadingView* loadingView;
@property (strong, nonatomic) popUpView* popupview;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)setUserFacebookID:(NSString *)user_facebookID;
- (void)endIntroView;

-(void)initLoadingView;
-(void)showLoadingView:(BOOL)flag;

-(void)initPopUpView;
-(void)setPopupView:(PopUpView_Type)type withDelegate:(id)sender leftSelector:(SEL)sel1 rightSelector:(SEL)sel2 info:(NSString *)info;
-(void)showPopUpView:(BOOL)flag;

@end
