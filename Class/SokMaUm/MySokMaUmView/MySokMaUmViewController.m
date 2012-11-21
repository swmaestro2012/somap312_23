//
//  MySokMaUmViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 4..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "MySokMaUmViewController.h"
#import "AppDelegate.h"

#import "MySelectionButtonView.h"
#import "PokeViewController.h"
#import "SelectedByViewController.h"
#import "MyChoiceViewController.h"

@interface MySokMaUmViewController ()

@end

@implementation MySokMaUmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [self.view addSubview:self.SokMaUmInfoView];
        [self setPanGestuer];
        [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(tabbarUp) userInfo:nil repeats:NO];
     }
    
    return self;
}

-(void)initView{
    
    [SOKMAUM_APP showLoadingView:YES];
    
    //--------------------------------------------------------------------------------------------
    // 속마음 전체 정보 (전체 회원수, 총 매칭수 등 불러오기
    //--------------------------------------------------------------------------------------------
    [APIcall sokmaum_get_info:self withParameter:nil SuccessSelector:@selector(sokmaum_get_info_SUCCESS:) failSelector:@selector(sokmaum_get_info_FAIL:)];
    //--------------------------------------------------------------------------------------------
 
    //--------------------------------------------------------------------------------------------
    // 현재 회원 정보 불러오기
    //--------------------------------------------------------------------------------------------
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SOKMAUM_APP facebookID] ,@"facebook_id", nil];

    [APIcall get_info:self withParameter:parameter SuccessSelector:@selector(get_info_SUCCESS:) failSelector:@selector(get_info_FAIL:)];
    //--------------------------------------------------------------------------------------------

}

- (IBAction)endSokMaUmInfoView:(id)sender {
    [self.SokMaUmInfoView removeFromSuperview];
}

//------------------------------------------------------------------------------------
// tabbar 구성하기
- (void)viewDidLoad
{
    [super viewDidLoad];
    [UtilClass changeFont:self.view];
    
   
    
    // Do any additional setup after loading the view from its nib.

    
    //[[[self tabBarController] tabBar] setBackgroundImage:[UIImage imageNamed:@"tabbar_background.png"]];
}
//------------------------------------------------------------------------------------





//------------------------------------------------------------------------------
// 추가적으로 상대 Poke 하기
- (IBAction)poke:(id)sender {
    
    PokeViewController *pokeView = [PokeViewController new];
    [self.navigationController pushViewController:pokeView animated:YES];
    [pokeView initView];
}
//------------------------------------------------------------------------------





//------------------------------------------------------------------------------------
// 나를 Poke한 사람들 확인하기
- (IBAction)check:(id)sender {
    
    SelectedByViewController *selectedByViewCont = [SelectedByViewController new];
    [self.navigationController pushViewController:selectedByViewCont animated:YES];
    [selectedByViewCont initView:selectedByArray];
}
//------------------------------------------------------------------------------




#pragma PanGestuerAction FUNCTIONS


/*

// ---------------- Tabbar UP&DOWN ---------------- //
//-------------------------------------------------------------------
// 탭바 up & down 스크롤, 하단버튼을 클릭할경우
//-------------------------------------------------------------------
-(void)tabbarUpDown{
    if (nowUpDown) {
        [self tabbarUp];
    }else{
        nowUpDown = true;
        [self moveView:self.SokMaUmInfoView duration:0.3 curve:UIViewAnimationCurveLinear y:90];
    }
}
*/

// ---------------- tabbarUp ---------------- //
//-------------------------------------------------------------------
// 탭바를 위로 스크롤
//-------------------------------------------------------------------
-(void)tabbarUp{
    nowUpDown = false;
    [self moveView:self.SokMaUmInfoView duration:0.5 curve:UIViewAnimationCurveLinear y:-340];
}


// -------------- setPanGestuer -------------- //
//-------------------------------------------------------------------
// TabbarView 에 해당 제스터를 설정
//-------------------------------------------------------------------
-(void)setPanGestuer{
    
    UIPanGestureRecognizer* _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    _panGestureRecognizer.minimumNumberOfTouches = 1;
    _panGestureRecognizer.maximumNumberOfTouches = 1;
    
    [_panGestureRecognizer setDelegate:self];
    [self.SokMaUmInfoView addGestureRecognizer:_panGestureRecognizer];
    
}

// ------------- panGestureAction ------------ //
//-------------------------------------------------------------------
// PanGestuerAction 이벤트
//-------------------------------------------------------------------
- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer
{
    float _y = 0;
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:self.SokMaUmInfoView];
        CGRect newFrame = self.SokMaUmInfoView.frame;
        
        if (newFrame.origin.y + translation.y >= -362 && newFrame.origin.y + translation.y <= 0) {
            newFrame.origin.y = newFrame.origin.y + translation.y;
            _y = newFrame.origin.y;
        }

        self.SokMaUmInfoView.frame = newFrame;
        [recognizer setTranslation:CGPointZero inView:self.SokMaUmInfoView];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        
        CGPoint translation = [recognizer translationInView:self.SokMaUmInfoView];
        CGRect newFrame = self.SokMaUmInfoView.frame;
        
        if (newFrame.origin.y + translation.y <= -100) {
            
            [self moveView:self.SokMaUmInfoView duration:0.3 curve:UIViewAnimationCurveLinear y:-340];
        
        }else{
        
            [self moveView:self.SokMaUmInfoView duration:0.3 curve:UIViewAnimationCurveLinear y:0];
        }
    }
}


//-------------------------------------------------------------------
// View Move Animation
//-------------------------------------------------------------------
- (void)moveView:(UIView *)view duration:(NSTimeInterval)duration
           curve:(int)curve y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    view.frame = CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height);
    
    // Commit the changes
    [UIView commitAnimations];
}
//-------------------------------------------------------------------

#pragma PanGestuerAction END
















- (NSString*)add_space:(NSString*)string_original
{
    NSMutableString *string_added = [[NSMutableString alloc] initWithCapacity:[string_original length]*2];
    for (int i = 0; i < [string_original length]; i++)
    {
        [string_added appendFormat:@"%c ",[string_original characterAtIndex:i]];
    }
    return string_added;
}

#pragma APICALL RESULTS

-(void)sokmaum_get_info_SUCCESS:(id)sender{
    
    NSDictionary *sokMaUm_getInfo_dic = sender;
    
    self.totalUserLabel.text = [self add_space:[NSString stringWithFormat:@"%@",[sokMaUm_getInfo_dic objectForKey:@"user_count"]]];
    self.totalMatchedLabel.text = [self add_space:[NSString stringWithFormat:@"%@",[sokMaUm_getInfo_dic objectForKey:@"matched_count"]]];
    self.totalPokeLabel.text = [self add_space:[NSString stringWithFormat:@"%@",[sokMaUm_getInfo_dic objectForKey:@"one-way_count"]]];
    
    [SOKMAUM_APP showLoadingView:NO];
}

-(void)sokmaum_get_info_FAIL:(id)sender{
    
    [SOKMAUM_APP showLoadingView:NO];
}

-(void)get_info_SUCCESS:(id)sender{
    
    NSDictionary *get_info_dic = sender;
    
    //----------------------------------------------------------------------------------------------------
    // 내가 선택한 사람들
    myChoiceArray = [get_info_dic objectForKey:@"my_choice"];
    if([myChoiceArray count]!=0){
        self.noPokeImg.hidden=YES;
    }
    
    int contentSizeWidth = 70*[myChoiceArray count];
    self.mySelectionScrollView.contentSize = CGSizeMake(contentSizeWidth, 70);
  
    // 320보다 가로가 적으면 가운데 정렬
    if(self.mySelectionScrollView.contentSize.width<320){
    
        self.mySelectionScrollView.contentOffset = CGPointMake( -(self.mySelectionScrollView.frame.size.width - contentSizeWidth)/2  , 0);
    }
    
    for (int i = 0; i < [myChoiceArray count]; i++) {

        // 버튼 xib
        NSArray *xibs4 = [[NSBundle mainBundle] loadNibNamed:@"MySelectionButtonView" owner:self options:nil];
        MySelectionButtonView* buttonView = (MySelectionButtonView *)[xibs4 objectAtIndex:0];
        [buttonView setFrame:CGRectMake(70*i, 0, 60, 60)];

        // 프로필 사진 불러오기
        NSString *profilePictureURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", [[myChoiceArray objectAtIndex:i]objectForKey:@"to_facebook_id"]];
        NSURL *profilePictureURL = [NSURL URLWithString:[profilePictureURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [buttonView.profilePicture setImageWithURL:profilePictureURL];
        
        // 프로필 사진 위 버튼 생성
        buttonView.btn.tag = i;
        [buttonView.btn addTarget:self action:@selector(mySelectionPersonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mySelectionScrollView addSubview:buttonView];
    }

    //----------------------------------------------------------------------------------------------------
    // 나를 선택한 사람들
    selectedByArray = [get_info_dic objectForKey:@"selected_by"];
    self.gotPokedNumberLabel.text = [NSString stringWithFormat:@"%d", [selectedByArray count]];
    
    // 나를 선택한 사람 없으면 확인하기 버튼 비활성화
    if([selectedByArray count]!=0){

        UIImage *checkbtn_on_img = [UIImage imageNamed:@"mySokMaUm_check_on.png"];
        [self.checkbtn setImage:checkbtn_on_img forState:UIControlStateNormal];
        
        // 나를 선택한 사람이 2명 이상이면 사람 여러명인 이미지로 바꾼다(gotPokedPeopleImage).
        if( [selectedByArray count] > 1){
            [self.gotPokedPeopleImage setImage:[UIImage imageNamed:@"mySokMaUm_multi_people"]];
        }
    }

}

-(void)get_info_FAIL:(id)sender{

}


-(IBAction)mySelectionPersonClick:(id)sender{
    
    //SJ_DEBUG_LOG(@"\n\nfriend목록:%@\n\n", friendInfoArr);
    UIButton *b = sender;
    SJ_DEBUG_LOG(@"%d", b.tag);
    
    MyChoiceViewController *mychoiceViewCont = [MyChoiceViewController new];
    [self.navigationController pushViewController:mychoiceViewCont animated:YES];
    [mychoiceViewCont initView:myChoiceArray currentChoice:b.tag];
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewDidUnload {
    [self setCheckbtn:nil];
    [self setGotPokedPeopleImage:nil];
    [self setNoPokeImg:nil];
    [super viewDidUnload];
}
@end
