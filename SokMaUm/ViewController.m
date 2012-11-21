//
//  ViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 28..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "PlistClass.h"

#import "ViewController.h"
#import "SecurityViewController.h"


@interface ViewController ()

@end

@implementation ViewController

//----------------------------------------------------------------------------
//Background 갔다가 들어왔을 때 잠금되었으면 잠금화면을 보여준다.
//----------------------------------------------------------------------------
-(void)showLockView{
    SecurityViewController *securityViewCont = [SecurityViewController new];
    [securityViewCont initView];
    [tabBarCont presentViewController:securityViewCont animated:NO completion:nil];
}
//----------------------------------------------------------------------------



- (void)viewDidLoad
{
    [super viewDidLoad];
    [UtilClass changeFont:self.view];
	// Do any additional setup after loading the view, typically from a nib.
    
    characterNumber=1;

    
    //----------------------------------------------------------------------------
    //Facebook Notificiation
    //----------------------------------------------------------------------------
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    //----------------------------------------------------------------------------
    
      
    //------------------------------------------------------------------
    //Intro ScrollView
    //
    // 처음에는 facebook 로그인(2단계 까지만 보여주고
    // New User -> 7단계 모두 오픈
    // Old User -> 7번 단계로 바로 이동)
    //------------------------------------------------------------------

    self.scrollView.pagingEnabled = YES;

    for (int i = 0; i < 2; i++) {
        
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        switch (i) {
            case 0:
                [subview addSubview:self.introView1];
                break;
            case 1:
                [subview addSubview:self.introView2];
                break;
            default:
                break;
        }
        
        [self.scrollView addSubview:subview];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(autoSlideImage) userInfo:nil repeats:NO];

}

-(void)autoSlideImage{
    
    [self.scrollView setContentOffset:CGPointMake(320,0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
}

- (IBAction)goLogin:(id)sender {
    [SOKMAUM_APP openSessionWithAllowLoginUI:YES];
}

- (IBAction)goToApp:(id)sender {
 
    tabBarCont = [TabBarController new];
    [self presentViewController:tabBarCont animated:NO completion:nil];
    
    //--------------------------------------------------------------------------------
    // 잠금을 걸어놨으면 잠금화면
    //--------------------------------------------------------------------------------
    NSString *isLock = [PlistClass readIsLock];
    if([isLock isEqualToString:@"YES"]){
        [self showLockView];
    }
    //--------------------------------------------------------------------------------

}

//------------------------------------------------------------------------
// Profile(Keyword 작성) 관련 함수
//------------------------------------------------------------------------
- (IBAction)goMakeProfile:(id)sender {
    
    [self.view addSubview:self.profileView];    
}

- (IBAction)insertKeyword:(UIButton *)sender {
    
    keywordNumber = sender.tag;
    [self.view addSubview:self.keywordView];
    [self.keywordTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    SJ_DEBUG_LOG(@"%@", textField.text);
    switch (keywordNumber) {
        case 1:
            keyword1 = textField.text;
            self.keywordLabel_1.text = keyword1;
            break;
        case 2:
            keyword2 = textField.text;
            self.keywordLabel_2.text = keyword2;
            break;
        case 3:
            keyword3 = textField.text;
            self.keywordLabel_3.text = keyword3;
            break;
        default:
            break;
    }
    
    
    self.keywordTextField.text = @"";
    [self.keywordTextField resignFirstResponder];
    [self.keywordView removeFromSuperview];
    return YES;
}

- (IBAction)endProfileView:(id)sender {
    
    // 캐릭터랑 키워드 서버에 전달
    NSMutableDictionary *userInfoDic = [PlistClass readUserInfo];
    
    // 캐릭터
    [userInfoDic setObject:[NSString stringWithFormat:@"%d",characterNumber] forKey:@"character"];
    
    // 키워드
    NSString *keyword = [NSString stringWithFormat:@"%@|%@|%@",keyword1,keyword2,keyword3];
    [userInfoDic setObject:keyword forKey:@"keyword"];
    
    [PlistClass writeUserInfo:userInfoDic];
    [APIcall update_user:self withParameter:userInfoDic SuccessSelector:@selector(update_user_SUCCESS:) failSelector:@selector(update_user_FAIL:)];
    
    [self.profileView removeFromSuperview];
    [self.scrollView setContentOffset:CGPointMake(320,0) animated:NO];
    [self.scrollView setScrollEnabled:YES];
}

-(void)update_user_SUCCESS:(id)sender{
}

-(void)update_user_FAIL:(id)sender{
}





//------------------------------------------------------------------------


//------------------------------------------------------------------------
// Profile(Character 작성) 관련 함수
//------------------------------------------------------------------------

//캐릭터 설정 화면 생성
- (IBAction)choiceCharacter:(id)sender {
    
    [self.view addSubview:self.characterView];
}

// 캐릭터 선택 버튼 이미지 설정
- (IBAction)character_decided:(UIButton *)sender {
    
    characterNumber = sender.tag;
    
    
    for(int index=1; index<7; index++){
        
        UIImage *image_on = [UIImage imageNamed:[NSString stringWithFormat:@"intro_car_%d_on.png", index]];
        UIImage *image_off = [UIImage imageNamed:[NSString stringWithFormat:@"intro_car_%d_off.png", index]];

        if(index == characterNumber){
            
            switch (index) {
                case 1:
                    [self.car_1 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.car_2 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.car_3 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 4:
                    [self.car_4 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 5:
                    [self.car_5 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 6:
                    [self.car_6 setImage:image_off forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            
        }else{
        
            switch (index) {
                case 1:
                    [self.car_1 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.car_2 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.car_3 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 4:
                    [self.car_4 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 5:
                    [self.car_5 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 6:
                    [self.car_6 setImage:image_on forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }
    }
}

- (IBAction)endCharacterView:(id)sender {
    
    // Todo
    //어떤 캐릭터인지 전달하는 과정 필요
    
    [self.characterView removeFromSuperview];
}

//------------------------------------------------------------------------



#pragma Facebook START
//---------------------------------------------------------------------
// Facebook 관련
//---------------------------------------------------------------------

- (void)sessionStateChanged:(NSNotification*)notification {
    
    if (FBSession.activeSession.isOpen) {
        SJ_DEBUG_LOG(@"Session is Active");
        
        [FBRequestConnection startWithGraphPath:@"me"
                                     parameters:[NSDictionary dictionaryWithObject:@"picture,id,email,name,gender, username" forKey:@"fields"]
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      SJ_DEBUG_LOG(@"%@",result);
                                      [SOKMAUM_APP setFacebookID:[result objectForKey:@"id"]];
                             
                                      NSMutableDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                  [result objectForKey:@"name"],@"name",
                                                                  [NSString stringWithFormat:@"%@@facebook.com",[result objectForKey:@"username"]],@"email",
                                                                  [result objectForKey:@"id"],@"facebook_id",
                                                                  [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"],@"facebook_photoUrl",
                                                                   @"",@"keyword",
                                                                  [result objectForKey:@"gender"],@"gender",
                                                                  [SOKMAUM_APP facebookAccessToken], @"facebook_token",
                                                                  @"", @"character",
                                                                  nil];
                                      
                                      [PlistClass writeUserInfo:bodyObject];
                                      [APIcall new_user:self withParameter:bodyObject SuccessSelector:@selector(new_user_SUCCESS:) failSelector:@selector(new_user_FAIL:)];
                                      
                                  }else{
                                      
                                      SJ_DEBUG_LOG(@"%@",error);
                                  }
                              }];

    } else {
        SJ_DEBUG_LOG(@"Session is NOT Active");
    }
}
//---------------------------------------------------------------------
#pragma Facebook END







#pragma APICALL RESULTS

-(void)new_user_SUCCESS:(id)sender{
    
    // loadingView를 지운다.
    [self.introView0 removeFromSuperview];

    NSDictionary *new_user_resultDic = sender;

    //--------------------
    // 기존 유저라면
    if([new_user_resultDic objectForKey:@"update"]){
    
        [self.scrollView removeFromSuperview];
        [self.view addSubview:self.introView6];
        
    }
    //--------------------
    // 새 유저라면
    else if([new_user_resultDic objectForKey:@"ok"]){
    
        [self.introView1 removeFromSuperview];
        [self.introView2 removeFromSuperview];
        
        for (int i = 0; i < 4; i++) {
            
            CGRect frame;
            frame.origin.x = self.scrollView.frame.size.width * i;
            frame.origin.y = 0;
            frame.size = self.scrollView.frame.size;
            
            UIView *subview = [[UIView alloc] initWithFrame:frame];
            
            switch (i) {
                case 0:
                    [subview addSubview:self.introView3];
                    break;
                case 1:
                    [subview addSubview:self.introView4];
                case 2:
                    [subview addSubview:self.introView5];
                case 3:
                    [subview addSubview:self.introView6];
                    break;
                default:
                    break;
            }
            
            [self.scrollView addSubview:subview];
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height);
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:NO];
        [self.scrollView setScrollEnabled:NO];
    }
    
    //--------------------
    // 에러가 나면
    else{
        [self.introView0 removeFromSuperview];
        [UtilClass showAlertWithNoDelegate:@"로그인을 실패하였습니다. 다시 시도해주세요."];
    }
}



-(void)new_user_FAIL:(id)sender{

    // loadingView를 지운다.
    [self.introView0 removeFromSuperview];
    
    [UtilClass showAlertWithNoDelegate:@"로그인을 실패하였습니다. 다시 시도해주세요."];
}














- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setIntroView4:nil];
    [self setIntroView5:nil];
    [self setIntroView6:nil];
    [self setProfileView:nil];
    [self setCharacterView:nil];
    [self setCar_1:nil];
    [self setCar_2:nil];
    [self setCar_3:nil];
    [self setCar_4:nil];
    [self setCar_5:nil];
    [self setCar_6:nil];
    [self setKeywordTextField:nil];
    [self setKeywordView:nil];
    [self setKeywordLabel_1:nil];
    [self setKeywordLabel_2:nil];
    [self setKeywordLabel_3:nil];
    [super viewDidUnload];
}

@end
