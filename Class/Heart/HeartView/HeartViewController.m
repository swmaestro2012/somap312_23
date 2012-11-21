//
//  HeartViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "HeartViewController.h"
#import "AppDelegate.h"

#import "BuyHeartViewController.h"
#import "HeartHistoryViewController.h"

@interface HeartViewController ()

@end

@implementation HeartViewController

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
    
    //--------------------------------------------------------------------------------------------
    // 현재 회원 정보 불러오기
    //--------------------------------------------------------------------------------------------
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [SOKMAUM_APP facebookID] ,@"facebook_id", nil];
    
    [APIcall get_info:self withParameter:parameter SuccessSelector:@selector(get_info_SUCCESS:) failSelector:@selector(get_info_FAIL:)];
    //--------------------------------------------------------------------------------------------
}

-(void)get_info_SUCCESS:(id)sender{
    
    self.heartCountLabel.text = [NSString stringWithFormat:@"%@",[[sender objectForKey:@"my_info"] objectForKey:@"balance"] ];
}

-(void)get_info_FAIL:(id)sender{}



- (IBAction)goBuyHeartView:(id)sender {
    
    BuyHeartViewController *buyHeartViewCont = [BuyHeartViewController new];
    [self.navigationController pushViewController:buyHeartViewCont animated:YES];
    [buyHeartViewCont initView];
    
}


- (IBAction)goHeartHistoryView:(id)sender {
    
    HeartHistoryViewController *heartHistoryViewCont = [HeartHistoryViewController new];
    [self.navigationController pushViewController:heartHistoryViewCont animated:YES];
    [heartHistoryViewCont initView];
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHeartCountLabel:nil];
    [super viewDidUnload];
}
@end
