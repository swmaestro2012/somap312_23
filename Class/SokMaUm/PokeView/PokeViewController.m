//
//  PokeViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 30..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "PokeViewController.h"
#import "PokeViewCell.h"

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface PokeViewController ()

@end

@implementation PokeViewController

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

- (IBAction)closeView:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)initView{
  
/*
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                       id<FBGraphUser> user,
                                       NSError *error) {
         if (!error) {
           
            SJ_DEBUG_LOG(@"%@",user);
             
         }
     }];

    [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection,
                                                                  id<FBGraphUser> user,
                                                                  NSError *error) {
        if (!error) {
            
            SJ_DEBUG_LOG(@"%@",user);
            
        }
    }];

 
    [FBRequestConnection startWithGraphPath:@"me"
                                 parameters:[NSDictionary dictionaryWithObject:@"picture,id,email,name,gender, username" forKey:@"fields"]
                                 HTTPMethod:@"GET"
                                 completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              
                                     if (!error) {
                                         
                                         SJ_DEBUG_LOG(@"%@",result);
                                         
                                         myProfileInfo = result;
                                         [self.profilePic setImageURLString:[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];
                                         self.userNameLabel.text=[result objectForKey:@"name"];
                                         self.userIdLabel.text=[result objectForKey:@"id"];
                                         self.userEmailLabel.text=[result objectForKey:@"email"];
                                         self.userGenderLabel.text=[result objectForKey:@"gender"];

                                     
                                     }
                          }];
    
    */
    
    [SOKMAUM_APP showLoadingView:YES];

    
    [FBRequestConnection startWithGraphPath:@"me/friends"
                                 parameters:[NSDictionary dictionaryWithObject:@"picture,id,name,gender,username, relationship_status" forKey:@"fields"]
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              
                              
                              [SOKMAUM_APP showLoadingView:NO];

                              if (!error) {
                                  
                                  SJ_DEBUG_LOG(@"%@",result);
                                  
                                  //--------------------------
                                  // 전체 친구
                                  NSArray *tempfacebookFriendArray = [result objectForKey:@"data"];
                              
                                  //--------------------------
                                  // 이름순으로 정렬
                                  NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                                                      sortDescriptorWithKey:@"name"
                                                                      ascending:YES];
                                  NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
                                  facebookFriendArray = [tempfacebookFriendArray sortedArrayUsingDescriptors:sortDescriptors];
                                 
                                  /*
                                  //--------------------------	
                                  // 이성 친구
                                  facebookOppositeGenderFriendArray = [[NSMutableArray alloc]init];
                                  for(NSDictionary *dic in facebookFriendArray){
                                      
                                      if(![[dic objectForKey:@"gender"] isEqualToString:[myProfileInfo objectForKey:@"gender"]]){
                                          [facebookOppositeGenderFriendArray addObject:dic];
                                      }
                                  }
                                  */
                                   
                                  sort_method = SORT_ALL;
                                  currentTableViewDataArray = facebookFriendArray;
                                  [self.tableView reloadData];
                              }
                          }];
}

/*
- (IBAction)showAllFriend:(id)sender {

    sort_method = SORT_ALL;
    currentTableViewDataArray = facebookFriendArray;
    [self.tableView reloadData];
}

- (IBAction)showOppositeGender:(id)sender {
    
    sort_method = SORT_OPPOSITE_GENDER;
    currentTableViewDataArray = facebookOppositeGenderFriendArray;
    [self.tableView reloadData];
}
*/


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
    
    return [currentTableViewDataArray count];
}

// 테이블 뷰 셀을 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    int index = [indexPath row];
    
    PokeViewCell *cell = (PokeViewCell *) [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PokeViewCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
    }

    // 1. 프로필 이미지 설정
    NSString *profilePictureURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", [[currentTableViewDataArray objectAtIndex:index] objectForKey:@"id"]];
    NSURL *profilePictureURL = [NSURL URLWithString:[profilePictureURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cell.profilePic setImageWithURL:profilePictureURL];

    // 2. Gender 설정
    if([[[currentTableViewDataArray objectAtIndex:index] objectForKey:@"gender"] isEqualToString:@"male"]){
        [cell.userGender setImage:[UIImage imageNamed:@"common_male.png"]];
    }
       
    // 3. 이름 설정
    cell.userNameLabel.text = [[currentTableViewDataArray objectAtIndex:index] objectForKey:@"name"];
    
    // 4. 속마음 전달 버튼 설정
    [cell.pokeBtn addTarget:self action:@selector(goPoke:) forControlEvents:UIControlEventTouchUpInside];
    cell.pokeBtn.tag = index;
    
//    cell.userIdLabel.text = [[currentTableViewDataArray objectAtIndex:index] objectForKey:@"id"];
//    cell.userIdLabel.text = [[currentTableViewDataArray objectAtIndex:index] objectForKey:@"relationship_status"];
//    cell.userEmailLabel.text = [NSString stringWithFormat:@"%@@facebook.com",[[currentTableViewDataArray objectAtIndex:index] objectForKey:@"username"]];
//    cell.userGenderLabel.text = [[currentTableViewDataArray objectAtIndex:index] objectForKey:@"gender"];

    return cell;
}







//--------------------------------------------------------------------------------------------
// Poke 하기
//--------------------------------------------------------------------------------------------
- (void) goPoke:(id)sender{
    
    UIButton* btn = (UIButton *)sender;
    currentIndex = btn.tag;
    
    [SOKMAUM_APP setPopupView:POPUP_POKE withDelegate:self leftSelector:@selector(popup_end) rightSelector:@selector(popup_goPoke) info:nil];
    [SOKMAUM_APP showPopUpView:YES];
  
}

-(void)popup_goPoke{

    [SOKMAUM_APP showPopUpView:NO];
    
    NSString *to_facebook_id = [[currentTableViewDataArray objectAtIndex:currentIndex]objectForKey:@"id"];
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [SOKMAUM_APP facebookID] ,@"from_facebook_id",
                               to_facebook_id ,@"to_facebook_id", nil];
    
    [APIcall choice:self withParameter:parameter SuccessSelector:@selector(choice_SUCCESS:) failSelector:@selector(choice_FAIL:)];
}

-(void)popup_end{
    
    [SOKMAUM_APP showPopUpView:NO];
}


-(void)choice_SUCCESS:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)choice_FAIL:(id)sender{}
//--------------------------------------------------------------------------------------------










#pragma mark Table view END
// --------------------------------------------------------------------------------------------
    

#pragma mark Text Field
#pragma mark Text Field

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    NSArray *tempFriendArray;
    //if(sort_method == SORT_ALL)
        tempFriendArray = facebookFriendArray;
    //else
    //    tempFriendArray = facebookOppositeGenderFriendArray;
    
    NSString *wildcard = [NSString stringWithFormat:@"*%@*", textField.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", wildcard];
    currentTableViewDataArray = [tempFriendArray filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
    
    return YES;
}

#pragma mark Text END

















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
