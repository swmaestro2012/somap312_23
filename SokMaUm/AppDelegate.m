//
//  AppDelegate.m
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 28..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

#import "ViewController.h"
#import "PlistClass.h"
#import "SecurityViewController.h"

@implementation AppDelegate
@synthesize facebookAccessToken;
@synthesize facebookID;
@synthesize loadingView;
@synthesize popupview;

NSString *const FBSessionStateChangedNotification =@"SeiJin.SokMaUm.Login:FBSessionStateChangedNotification";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  
    viewCont = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.viewController = viewCont;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [FBProfilePictureView class];
    [FBFriendPickerViewController class];
    [PlistClass DocumentFileCopy];
    [self initLoadingView];
    [self initPopUpView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(endIntroView) userInfo:nil repeats:NO];
    
    //----------------------------------------------------------------------------
    // Custom NavigationBar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"naviBar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setFrame:CGRectMake(0, 0, 320, 44)];
    
    return YES;
}

-(void)endIntroView{

    //----------------------------------------------------------------------------
    // Facebook 로그인이 되어있으면 app 로그인을한다
    //----------------------------------------------------------------------------
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // To-do, show logged in view
        [self openSessionWithAllowLoginUI:NO];
    }
    //----------------------------------------------------------------------------
    // Facebook 로그인이 안되어 있으면 인트로뷰로 간다.
    //----------------------------------------------------------------------------
    else {
        [viewCont.introView0 removeFromSuperview];
    }
}




//------------------------------------------------------------------------------------
// Loading 창
//------------------------------------------------------------------------------------
-(void)initLoadingView{
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
    self.loadingView = (LoadingView *)[xibs objectAtIndex:0];
}

-(void)showLoadingView:(BOOL)flag{
    
    if (flag) {
    
        [self.window addSubview:self.loadingView];
            
        loadingSeconds=0;
        [loadingTimer invalidate];
        loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.25f target:self selector:@selector(stopLoadingView) userInfo:nil repeats:YES];

    }else{

        //Loading이 1초 이하로 보여졌으면 조금 뒤에 로딩 이미지를 없앤다.
        if(loadingSeconds<5){
            
            loadingSeconds = 36;
 
        }else{
            loadingSeconds=0;
            [loadingTimer invalidate];
            [self.loadingView removeFromSuperview];
        }
    }
}

// LoadingView가 10초이상 지속되면 그냥 없애버려라
-(void)stopLoadingView{

    int loadImg = loadingSeconds%8;
    [self.loadingView.loadingImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"loding_%d.png",loadImg]]];
    loadingSeconds++;
    
    if(loadingSeconds > 40){
        [self showLoadingView:NO];
    }
}


//------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------
// PopUp 창
//------------------------------------------------------------------------------------
-(void)initPopUpView{
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"PopUpView" owner:self options:nil];
    self.popupview = (popUpView *)[xibs objectAtIndex:0];
}

-(void)setPopupView:(PopUpView_Type)type withDelegate:(id)sender leftSelector:(SEL)sel1 rightSelector:(SEL)sel2 info:(NSString *)info{
    [self.popupview setPopupView:type withDelegate:sender leftSelector:sel1  rightSelector:sel2 info:nil];
}

-(void)showPopUpView:(BOOL)flag{
    if (flag) {
        
        [self.window addSubview:self.popupview];
   
    }else{
        [self.popupview removeFromSuperview];
    }
}
//------------------------------------------------------------------------------------




#pragma mark - Facebook Connect
//------------------------------------------------------------------------
// Facebook
//------------------------------------------------------------------------

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            
            if (!error) {
                // We have a valid session
                SJ_DEBUG_LOG(@"User session found: %@", session.accessToken);
                facebookAccessToken = session.accessToken;
        }
            break;
        case FBSessionStateClosed:
            
        case FBSessionStateClosedLoginFailed:
            
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
   
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            @"friends_relationships",
                            nil];
    return [FBSession openActiveSessionWithReadPermissions:permissions
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}



- (void)setUserFacebookID:(NSString *)user_facebookID{
    
    facebookID = user_facebookID;
}

#pragma mark - Facebook Connect END




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    //--------------------------------------------------------------------------------
    // 잠금을 걸어놨으면 잠금화면
    //--------------------------------------------------------------------------------
    NSString *isLock = [PlistClass readIsLock];
    if([isLock isEqualToString:@"YES"]){
    
        [viewCont showLockView];
    }
    //--------------------------------------------------------------------------------
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to SSO
    // (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //You should also take care of closing the session if the app is about to terminate. Do this by adding the following code to the user applicationWillTerminate: app delegate method:
    [FBSession.activeSession close];

}

@end
