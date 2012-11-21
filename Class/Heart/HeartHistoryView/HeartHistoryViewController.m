//
//  HeartHistoryViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "HeartHistoryViewController.h"
#import"HeartHistoryCell.h"
#import "AppDelegate.h"


@interface HeartHistoryViewController ()

@end

@implementation HeartHistoryViewController

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
    // 하트 History 불러오기
    //--------------------------------------------------------------------------------------------
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [SOKMAUM_APP facebookID] ,@"facebook_id", nil];
    
    [APIcall history_heart:self withParameter:parameter SuccessSelector:@selector(history_heart_SUCCESS:) failSelector:@selector(history_heart_FAIL:)];
    //--------------------------------------------------------------------------------------------

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
    
    return [historyHeartArray count];
}

// 테이블 뷰 셀을 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    int index = [indexPath row];
    
    HeartHistoryCell *cell = (HeartHistoryCell *) [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"HeartHistoryCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    
    // 1. 하트 적립/사용 내역 정의
    NSString *type = [[historyHeartArray objectAtIndex:index]objectForKey:@"type"];
    NSString *count = [NSString stringWithFormat:@"%@",[[historyHeartArray objectAtIndex:index]objectForKey:@"count"]];

    if([type isEqualToString:@"join"]){
        
        [cell.whatKindImg setImage:[UIImage imageNamed:@"hearthistory_event.png"]];
        cell.contentLabel.text = [NSString stringWithFormat:@"+%@ (가입 축하 이벤트)", count];
        
    }else if([type isEqualToString:@"buy"]){
    
        [cell.whatKindImg setImage:[UIImage imageNamed:@"hearthistory_buy.png"]];
        cell.contentLabel.text = [NSString stringWithFormat:@"+%@ (하트 구매)", count];
        
    }else if([type isEqualToString:@"daily"]){
    
        [cell.whatKindImg setImage:[UIImage imageNamed:@"hearthistory_event.png"]];
        cell.contentLabel.text = [NSString stringWithFormat:@"+%@ (오늘의 하트)", count];

    }else if([type isEqualToString:@"event"]){
        
        [cell.whatKindImg setImage:[UIImage imageNamed:@"hearthistory_event.png"]];
        cell.contentLabel.text = [NSString stringWithFormat:@"+%@ (이벤트)", count];

    }else if([type isEqualToString:@"message"]){
        
        [cell.whatKindImg setImage:[UIImage imageNamed:@"hearthistory_use.png"]];
        cell.contentLabel.text = [NSString stringWithFormat:@"-%@ (메세지 전달)", count];
        
    }else if([type isEqualToString:@"choice"]){
        
        [cell.whatKindImg setImage:[UIImage imageNamed:@"hearthistory_use.png"]];
        cell.contentLabel.text = [NSString stringWithFormat:@"-%@ (속마음 전달)", count];
        
    }

    
    return cell;
}

#pragma mark Table view END
// --------------------------------------------------------------------------------------------








#pragma APICALL RESULTS

-(void)history_heart_SUCCESS:(id)sender{
    
    historyHeartArray = sender;
    [self.tableView reloadData];
    [SOKMAUM_APP showLoadingView:NO];

}

-(void)history_heart_FAIL:(id)sender{
    [SOKMAUM_APP showLoadingView:NO];    
}

#pragma APICALL RESULTS END



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
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
