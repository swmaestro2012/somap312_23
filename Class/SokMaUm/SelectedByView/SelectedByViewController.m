//
//  SelectedByViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "SelectedByViewController.h"
#import "SelectedByViewCell.h"
#import "AppDelegate.h"

#import "PokeViewController.h"

@interface SelectedByViewController ()

@end

@implementation SelectedByViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView:(NSMutableArray *)tempSelectedByArray{
    
    selectedByArray = tempSelectedByArray;
    SJ_DEBUG_LOG(@"%@",selectedByArray);
    [self.tableView reloadData];
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
    
    return [selectedByArray count];
}

// 테이블 뷰 셀을 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    int index = [indexPath row];
    
    SelectedByViewCell *cell = (SelectedByViewCell *) [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SelectedByViewCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    // 1. Set Character
    UIImage *characterImg = [UtilClass characterImage:[[selectedByArray objectAtIndex:index]objectForKey:@"character"]];
    [cell.characterImage setImage:characterImg];
    
    // 2. Set Gender
    NSString *gender = [[selectedByArray objectAtIndex:index] objectForKey:@"gender"];
    if(![gender isEqual:[NSNull null]]){
        if([gender isEqualToString:@"male"]){
            [cell.genderImage setImage:[UIImage imageNamed:@"common_male.png"]];
        }
    }
    
    // 3. Set Keywords
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
    
    // 4. set rejectBtn
    [cell.rejectBtn addTarget:self action:@selector(goReject:) forControlEvents:UIControlEventTouchUpInside];
    cell.rejectBtn.tag = index;
    
    
    // 5. set msgBtn
    [cell.msgBtn addTarget:self action:@selector(goMsg:) forControlEvents:UIControlEventTouchUpInside];
    cell.msgBtn.tag = index;
    

    // 6. set guessBtn
    [cell.guessBtn addTarget:self action:@selector(goGuess:) forControlEvents:UIControlEventTouchUpInside];
    cell.guessBtn.tag = index;
    

    
    
    return cell;
}

//------------------------------------------------------------------------------
// 그만두기
- (void) goReject:(id)sender{
    UIButton* btn = (UIButton *)sender;
    currentIndex = btn.tag;
    
    [SOKMAUM_APP setPopupView:POPUP_REJECT withDelegate:self leftSelector:@selector(popup_end) rightSelector:@selector(popup_goReject) info:nil];
    [SOKMAUM_APP showPopUpView:YES];
}

-(void)popup_goReject{
    
    [SOKMAUM_APP showPopUpView:NO];
    
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [[selectedByArray objectAtIndex:currentIndex]objectForKey:@"from_facebook_id"] ,@"from_facebook_id",
                               [SOKMAUM_APP facebookID] ,@"to_facebook_id",
                               @"pause" ,@"state",
                               nil];
    [APIcall set_choice:self withParameter:parameter SuccessSelector:@selector(set_choice_SUCCESS:) failSelector:@selector(set_choice_FAIL:)];
}

-(void)set_choice_SUCCESS:(id)sender{
}

-(void)set_choice_FAIL:(id)sender{    
}
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// 메세지 보내기
- (void) goMsg:(id)sender{
    UIButton* btn = (UIButton *)sender;
    
}
//------------------------------------------------------------------------------



//------------------------------------------------------------------------------
// 맞춰보기
- (void) goGuess:(id)sender{
    
    [SOKMAUM_APP setPopupView:POPUP_GUESS withDelegate:self leftSelector:@selector(popup_end) rightSelector:@selector(popup_goGuess) info:nil];
    [SOKMAUM_APP showPopUpView:YES];
}


-(void)popup_goGuess{

    [SOKMAUM_APP showPopUpView:NO];
    
    PokeViewController *pokeView = [PokeViewController new];
    [self.navigationController pushViewController:pokeView animated:YES];
    [pokeView initView];
}

-(void)popup_end{
    
    [SOKMAUM_APP showPopUpView:NO];
}
//------------------------------------------------------------------------------


#pragma mark Table view END
// --------------------------------------------------------------------------------------------

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
