//
//  MessageViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"

#import "MessageHistoryViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MessageViewController ()

@end

@implementation MessageViewController

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


-(void)initView{

    [SOKMAUM_APP showLoadingView:YES];
    
    //--------------------------------------------------------------------------------------------
    // 현재 회원 정보 불러오기
    //--------------------------------------------------------------------------------------------
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [SOKMAUM_APP facebookID] ,@"facebook_id", nil];
    
    [APIcall get_info:self withParameter:parameter SuccessSelector:@selector(get_info_SUCCESS:) failSelector:@selector(get_info_FAIL:)];
    //--------------------------------------------------------------------------------------------
}

#pragma APICALL RESULTS

-(void)get_info_SUCCESS:(id)sender{
    
    NSDictionary *get_info_dic = sender;
    
    //----------------------------------------------------------------------------------------------------
    // 내가 선택한 사람들
    myChoiceArray = [get_info_dic objectForKey:@"my_choice"];
    
    //----------------------------------------------------------------------------------------------------
    // 나를 선택한 사람들
    selectedByArray = [get_info_dic objectForKey:@"selected_by"];
 
    [self.tableView reloadData];
    [SOKMAUM_APP showLoadingView:NO];
}

-(void)get_info_FAIL:(id)sender{     [SOKMAUM_APP showLoadingView:NO]; }

#pragma APICALL RESULTS END

// --------------------------------------------------------------------------------------------
//   TableView
// --------------------------------------------------------------------------------------------
#pragma mark - TableView
#pragma mark Table view methods

// 테이블 뷰의 Section수를 반환
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 18;
}

// 테이블 뷰의 Section을 정의 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray* m_headers = [[NSArray alloc]initWithObjects:@"  나에게 속마음을 보인 사람",@"  내가 속마음을 전달한 사람", nil];
    
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 315.0, 15.0)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 290.0, 18.0)];
    UIImage *image = [UIImage imageNamed:@"search_bar_diggin.png"];
    [imageView setImage:image];
    [customView addSubview:imageView];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:10];
    headerLabel.frame = CGRectMake(20.0, 0.0, 280.0, 18.0);
    [headerLabel setText:[m_headers objectAtIndex:section]];
    [customView addSubview:headerLabel];
    
    return customView;
}

// 테이블 뷰 셀의 개수를 반환
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section==0){
        return [selectedByArray count];
    }else{
        return [myChoiceArray count];
    }
}

// 테이블 뷰 셀을 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    int index = [indexPath row];
    
    MessageCell *cell = (MessageCell *) [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    //--------------------------------------------------------------------------------
    // 나에게 속마음을 보인 사람
    if(indexPath.section==0){
                
        // 1. 캐릭터 설정
        UIImage *characterImg = [UtilClass characterImage:[[selectedByArray objectAtIndex:index]objectForKey:@"character"]];
        [cell.characater setImage:characterImg];

        // 2. 키워드 설정
        NSString *keywordString = [[selectedByArray objectAtIndex:index]objectForKey:@"keyword"];
        if( keywordString == (NSString *) [NSNull null]){
            
            cell.keywordLabel.text = @"Keyword가 없습니다";
            
        }else{
            
            // 구문 문자 @"|"가 있으면 나누어서 표시하고
            // 업으면 keyword가 한개 이므로 그냥 출력한다.
            NSRange range = [keywordString rangeOfString:@"|"];
            if (range.location == NSNotFound)
                cell.keywordLabel.text = keywordString;
            else{
                
                NSArray *seperateKeywordArray = [keywordString componentsSeparatedByString:@"|"];
                
                NSString *keywordSeperatedString;
                for(int i=0; i < [seperateKeywordArray count]; i++){
                    
                    if(i == 0)
                        keywordSeperatedString = [NSString stringWithFormat:@"%@", [seperateKeywordArray objectAtIndex:i]];
                    else
                        keywordSeperatedString = [NSString stringWithFormat:@"%@  %@", keywordSeperatedString, [seperateKeywordArray objectAtIndex:i]];
                }
                cell.keywordLabel.text = keywordSeperatedString;
            }
        }
        
        
        // 3. Gender 설정
        NSString *gender = [[selectedByArray objectAtIndex:index] objectForKey:@"gender"];
        if(![gender isEqual:[NSNull null]]){
            if([gender isEqualToString:@"male"]){
                [cell.gender setImage:[UIImage imageNamed:@"common_male.png"]];
            }else{
                [cell.gender setImage:[UIImage imageNamed:@"common_female.png"]];
            }
        }else [cell.gender setImage:[UIImage imageNamed:@"common_female.png"]];

        
        // 4. 메세지 박스 설정 & 메세지 내용 설정
        NSMutableArray *array = [[selectedByArray objectAtIndex:index]objectForKey:@"last_message"];
        
        if([array count]==0){
            
            cell.contentsLabel.text = @"아직 메세지가 없습니다.\n먼저 메세지를 보내보세요!";
        }else{
            
            NSDictionary *dic = [array objectAtIndex:0];
            
            //메세지 설정
            cell.contentsLabel.text = [dic objectForKey:@"context"];
            
            // 내가 보낸 메세지이면
            if([[dic objectForKey:@"from_facebook_id"] isEqualToString:[SOKMAUM_APP facebookID]]){
                [cell.messagebox setImage:[UIImage imageNamed:@"message_mebox.png"]];
                // 남이 보낸 메세지이면
            }else{
                [cell.messagebox setImage:[UIImage imageNamed:@"message_youbox.png"]];
            }
        }
        
        // 5. 메세지 history가기 버튼
        [cell.messageHistoryBtn addTarget:self action:@selector(goMessageHistory_SelectedBy:) forControlEvents:UIControlEventTouchUpInside];
        cell.messageHistoryBtn.tag = index;
        
        
        
        
    //--------------------------------------------------------------------------------
    // 내가 속마음을 전달한 사람
    }else{
        
        NSString *to_facebook_id = [[myChoiceArray objectAtIndex:index] objectForKey:@"to_facebook_id"];
        
        // 1. 프로필 사진 설정
        NSString *profilePictureURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", to_facebook_id];
        NSURL *profilePictureURL = [NSURL URLWithString:[profilePictureURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [cell.characater setImageWithURL:profilePictureURL];

   
        // 2. 이름 & Gender 설정
        [FBRequestConnection startWithGraphPath:to_facebook_id
                                     parameters:[NSDictionary dictionaryWithObject:@"name,gender" forKey:@"fields"]
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                                                    
                                  if (!error) {
                                      
                                      NSDictionary *currentChoiceDic = result;
                                      
                                      // 이름 설정
                                      cell.keywordLabel.text = [currentChoiceDic objectForKey:@"name"];
                                      
                                      // Gender 설정
                                      NSString *gender = [currentChoiceDic objectForKey:@"gender"];
                                      if([gender isEqualToString:@"male"]){
                                          [cell.gender setImage:[UIImage imageNamed:@"common_male.png"]];
                                      }else{
                                          [cell.gender setImage:[UIImage imageNamed:@"common_female.png"]];
                                      }
                                  }
                              }];
        

        
        // 4. 메세지 박스 설정 & 메세지 내용 설정
        NSMutableArray *array = [[myChoiceArray objectAtIndex:index]objectForKey:@"last_message"];
        
        if([array count]==0){
            
            cell.contentsLabel.text = @"아직 메세지가 없습니다.\n먼저 메세지를 보내보세요!";
        }else{
            
            NSDictionary *dic = [array objectAtIndex:0];
            
            //메세지 설정
            cell.contentsLabel.text = [dic objectForKey:@"context"];

            // 내가 보낸 메세지이면
            if([[dic objectForKey:@"from_facebook_id"] isEqualToString:[SOKMAUM_APP facebookID]]){
                [cell.messagebox setImage:[UIImage imageNamed:@"message_mebox.png"]];
                // 남이 보낸 메세지이면
            }else{
                [cell.messagebox setImage:[UIImage imageNamed:@"message_youbox.png"]];
            }
        }
        
        // 5. 메세지 history가기 버튼
        [cell.messageHistoryBtn addTarget:self action:@selector(goMessageHistory_MyChoice:) forControlEvents:UIControlEventTouchUpInside];
        cell.messageHistoryBtn.tag = index;
    }
    
    
   
    
    return cell;
}

//--------------------------------------------------------------------------------------------
// goMessageHistory_SelectedBy 하기
//--------------------------------------------------------------------------------------------
- (void) goMessageHistory_SelectedBy:(id)sender{
    
    UIButton* btn = (UIButton *)sender;
    int index = btn.tag;
    
    MessageHistoryViewController *mychoiceViewCont = [MessageHistoryViewController new];
    [self.navigationController pushViewController:mychoiceViewCont animated:YES];
    
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [[selectedByArray objectAtIndex:index] objectForKey:@"character"] ,@"character",
                               [[selectedByArray objectAtIndex:index] objectForKey:@"keyword"] ,@"keyword",
                               [[selectedByArray objectAtIndex:index] objectForKey:@"facebook_id"] ,@"facebook_id",
                               nil];
    
    [mychoiceViewCont init_SelectedBy:parameter];

}


//--------------------------------------------------------------------------------------------
// goMessageHistory_MyChoice 하기
//--------------------------------------------------------------------------------------------

- (void) goMessageHistory_MyChoice:(id)sender{
    
    UIButton* btn = (UIButton *)sender;
    int index = btn.tag;
    
    MessageHistoryViewController *mychoiceViewCont = [MessageHistoryViewController new];
    [self.navigationController pushViewController:mychoiceViewCont animated:YES];
    
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[myChoiceArray objectAtIndex:index] objectForKey:@"to_facebook_id"] ,@"to_facebook_id",
                               nil];
    [mychoiceViewCont init_MyChoice:parameter];
}



#pragma mark Table view methods END
// --------------------------------------------------------------------------------------------














- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
