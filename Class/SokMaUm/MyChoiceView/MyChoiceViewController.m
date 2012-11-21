//
//  MyChoiceViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "MyChoiceViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

#import "MessageViewController.h"


@interface MyChoiceViewController ()

@end

@implementation MyChoiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UtilClass changeFont:self.view];
    

    // Do any additional setup after loading the view from its nib.
}


-(void)initView:(NSMutableArray *)tempMyChoiceArray currentChoice:(int)tempCurrentChoice{

    myChoiceArray = tempMyChoiceArray;
    currentChoice = tempCurrentChoice;
    
    if([myChoiceArray count]==1){
        self.leftBtn.hidden =YES;
        self.rightBtn.hidden=YES;
    }
    
    [self choiceChanged:currentChoice];
}

-(void)choiceChanged:(int)tempCurrentChoice{
    
    [SOKMAUM_APP showLoadingView:YES];
    
    currentChoice = tempCurrentChoice;
    
    // 처음이거나 마지막일때 각각 왼쪽 오른쪽 버튼 비활성화
    if(currentChoice==0){
        self.leftBtn.hidden=YES;
        self.rightBtn.hidden=NO;
    }else if(currentChoice == [myChoiceArray count]-1){
        self.leftBtn.hidden=NO;
        self.rightBtn.hidden=YES;
    }else{
        self.leftBtn.hidden=NO;
        self.rightBtn.hidden=NO;
    }
    
    
    //---------------------------------------------------------------------------
    // 내가 선택한 사람(현재 뷰의) facebook ID로 정보 요청
    //---------------------------------------------------------------------------
    NSString *to_facebook_id = [[myChoiceArray objectAtIndex:currentChoice]objectForKey:@"to_facebook_id"];
    
    [FBRequestConnection startWithGraphPath:to_facebook_id
                                 parameters:[NSDictionary dictionaryWithObject:@"picture,id,email,name,gender, username" forKey:@"fields"]
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              
                              [SOKMAUM_APP showLoadingView:NO];
                              
                              if (!error) {
                                  
                                  NSDictionary *currentChoiceDic = result;
                                  
                                  // 0. BG 설정
                                  NSString *state = [[myChoiceArray objectAtIndex:currentChoice]objectForKey:@"state"];
                                  if([state isEqualToString:@"reject"]){
                                      [self.selectedBy_BG setImage:[UIImage imageNamed:@"myChoice_reject.png"]];
                                  }else if([state isEqualToString:@"conflict"]){
                                      [self.selectedBy_BG setImage:[UIImage imageNamed:@"myChoice_conflict.png"]];
                                  }else if([state isEqualToString:@"matched"]){
                                      [self.selectedBy_BG setImage:[UIImage imageNamed:@"myChoice_matched.png"]];
                                  }else{
                                      [self.selectedBy_BG setImage:[UIImage imageNamed:@"myChoice_waiting.png"]];
                                  }
                                  
                                  // 1. 프로필 사진 설정
                                  NSString *profilePictureURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", [currentChoiceDic objectForKey:@"id"]];
                                  NSURL *profilePictureURL = [NSURL URLWithString:[profilePictureURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                                  [self.profilePicture setImageWithURL:profilePictureURL];
                                  
                                  // 2. Gender 설정
                                  NSString *gender = [currentChoiceDic objectForKey:@"gender"];
                                  if([gender isEqualToString:@"male"]){
                                      [self.gender setImage:[UIImage imageNamed:@"common_male.png"]];
                                  }else{
                                      [self.gender setImage:[UIImage imageNamed:@"common_female.png"]];
                                  }
                                  
                                  // 3. 이름 설정
                                  self.nameLabel.text = [currentChoiceDic objectForKey:@"name"];
                              }
                          }];

    
}

- (IBAction)quitPoke:(id)sender {
    
    // Poke 끊어버리기
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)goMessage:(id)sender {
    
    
}





- (IBAction)goPreviousChoice:(id)sender {
    
    currentChoice--;
    [self choiceChanged:currentChoice];

}

- (IBAction)goNextChoice:(id)sender {
    
    currentChoice++;
    [self choiceChanged:currentChoice];

}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([self.navigationController.viewControllers objectAtIndex:0] != self)
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 31)];
        [backButton setImage:[UIImage imageNamed:@"common_back.png"] forState:UIControlStateNormal];
        [backButton setShowsTouchWhenHighlighted:TRUE];
        [backButton addTarget:self action:@selector(popViewControllerWithAnimation) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem *barBackItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.hidesBackButton = TRUE;
        self.navigationItem.leftBarButtonItem = barBackItem;
    }
}
-(void)popViewControllerWithAnimation {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setLeftBtn:nil];
    [self setRightBtn:nil];
    [self setGender:nil];
    [self setSelectedBy_BG:nil];
    [super viewDidUnload];
}
@end
