//
//  MessageHistoryViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 20..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "MessageHistoryViewController.h"
#import "MessageHistoryCell.h"

#import "AppDelegate.h"
#import "UtilClass.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MessageHistoryViewController ()

@end

@implementation MessageHistoryViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(void)init_SelectedBy:(NSDictionary *)parameter{

    target_facebook_id = [parameter objectForKey:@"facebook_id"];
    
    // 1. 캐릭터 설정
    UIImage *characterImg = [UtilClass characterImage: [parameter objectForKey:@"character"]];
    [self.profileImage setImage:characterImg];
    
    
    // 2. 키워드 설정
    NSString *keywordString = [parameter objectForKey:@"keyword"];
    if( keywordString == (NSString *) [NSNull null]){
        
        self.name.text = @"Keyword가 없습니다";
        
    }else{
        
        // 구문 문자 @"|"가 있으면 나누어서 표시하고
        // 업으면 keyword가 한개 이므로 그냥 출력한다.
        NSRange range = [keywordString rangeOfString:@"|"];
        if (range.location == NSNotFound)
            self.name.text = keywordString;
        else{
            
            NSArray *seperateKeywordArray = [keywordString componentsSeparatedByString:@"|"];
            
            NSString *keywordSeperatedString;
            for(int i=0; i < [seperateKeywordArray count]; i++){
                
                if(i == 0)
                    keywordSeperatedString = [NSString stringWithFormat:@"%@", [seperateKeywordArray objectAtIndex:i]];
                else
                    keywordSeperatedString = [NSString stringWithFormat:@"%@  %@", keywordSeperatedString, [seperateKeywordArray objectAtIndex:i]];
            }
            self.name.text = keywordSeperatedString;
        }
    }
    
    
    // 3. Gender 설정
    NSString *gender = [parameter objectForKey:@"gender"];
    if(![gender isEqual:[NSNull null]]){
        if([gender isEqualToString:@"male"]){
            [self.gender setImage:[UIImage imageNamed:@"common_male.png"]];
        }else{
            [self.gender setImage:[UIImage imageNamed:@"common_female.png"]];
        }
    }else [self.gender setImage:[UIImage imageNamed:@"common_female.png"]];
 
    
    [self goMessageHistory];
}


-(void)init_MyChoice:(NSDictionary *)parameter{
    
    target_facebook_id = [parameter objectForKey:@"to_facebook_id"];

    NSString *to_facebook_id = target_facebook_id;

    // 1. 프로필 사진 설정
    NSString *profilePictureURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", to_facebook_id];
    NSURL *profilePictureURL = [NSURL URLWithString:[profilePictureURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.profileImage setImageWithURL:profilePictureURL];
    
    
    // 2. 이름 & Gender 설정
    [FBRequestConnection startWithGraphPath:to_facebook_id
                                 parameters:[NSDictionary dictionaryWithObject:@"name,gender" forKey:@"fields"]
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              
                              if (!error) {
                                  
                                  NSDictionary *currentChoiceDic = result;
                                  
                                  // 이름 설정
                                  self.name.text = [currentChoiceDic objectForKey:@"name"];
                                  
                                  // Gender 설정
                                  NSString *gender = [currentChoiceDic objectForKey:@"gender"];
                                  if([gender isEqualToString:@"male"]){
                                      [self.gender setImage:[UIImage imageNamed:@"common_male.png"]];
                                  }else{
                                      [self.gender setImage:[UIImage imageNamed:@"common_female.png"]];
                                  }
                              }
                          }];
    
    [self goMessageHistory];
}


-(void) goMessageHistory{
    
    [SOKMAUM_APP showLoadingView:YES];
    
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [SOKMAUM_APP facebookID] ,@"from_facebook_id",
                               target_facebook_id,@"to_facebook_id",
                               nil];

    [APIcall get_message_history:self withParameter:parameter SuccessSelector:@selector(get_message_SUCCESS:) failSelector:@selector(get_message_FAIL:)];
}

-(void)get_message_SUCCESS:(id)sender{
        
    if([sender isKindOfClass:[NSDictionary class]]){
    }else{
        messageHistoryArray = sender;
        [self.tableView reloadData];
    }
    
    [SOKMAUM_APP showLoadingView:NO];

}

-(void)get_message_FAIL:(id)sender{
    [SOKMAUM_APP showLoadingView:NO];
}



// --------------------------------------------------------------------------------------------
//   TableView
// --------------------------------------------------------------------------------------------
#pragma mark - TableView
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// 테이블 뷰 셀의 개수를 반환
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [messageHistoryArray count];
}

// 테이블 뷰 셀을 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    int index = [indexPath row];
    
    MessageHistoryCell *cell = (MessageHistoryCell *) [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"MessageHistoryCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    // 1. 내가 보낸건지 남이 보낸건지 확인 (메세지 박스 설정)
    
    // 내가 보낸 메세지이면
    if([[[messageHistoryArray objectAtIndex:index]objectForKey:@"from_facebook_id"] isEqualToString:[SOKMAUM_APP facebookID]]){
        [cell.messageBox setImage:[UIImage imageNamed:@"message_mebox.png"]];
        [cell.photo_bg removeFromSuperview];
    }
    // 남이 보낸 메세지이면 얼굴도 설정
    else{
        [cell.messageBox setImage:[UIImage imageNamed:@"message_youbox.png"]];
        [cell.profileImage setImage:self.profileImage.image];
    }
    
    // 2. 메세지 내용 출력
    cell.content.text = [[messageHistoryArray objectAtIndex:index]objectForKey:@"context"];
    
    
    return cell;
}
#pragma mark Table view END




















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setProfileImage:nil];
    [self setName:nil];
    [self setGender:nil];
    [self setTableView:nil];
    [super viewDidUnload];
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

@end
