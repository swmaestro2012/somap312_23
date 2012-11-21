//
//  BuyHeartViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "BuyHeartViewController.h"
#import "AppDelegate.h"

@interface BuyHeartViewController ()

@end

@implementation BuyHeartViewController

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
    
}

- (IBAction)goBuyHeart:(UIButton *)sender {
    
    NSString *heartCount;
    
    switch (sender.tag) {
        case 1:
            heartCount = @"20";
            break;
        case 2:
            heartCount = @"50";
            break;
        default:
            break;
    }
    
    
    NSDictionary* parameter = [NSDictionary dictionaryWithObjectsAndKeys:
                               [SOKMAUM_APP facebookID] ,@"facebook_id",
                               heartCount ,@"count",
                               @"buy" ,@"type",
                               nil];
    
    [APIcall add_heart:self withParameter:parameter SuccessSelector:@selector(add_heart_SUCCESS:) failSelector:@selector(add_heart_FAIL:)];
}



#pragma APICALL RESULTS

-(void)add_heart_SUCCESS:(id)sender{
    
    [UtilClass showAlertWithNoDelegate:@"하트가 구매되었습니다"];
    SJ_DEBUG_LOG(@"%@",sender);
}

-(void)add_heart_FAIL:(id)sender{
    
    [UtilClass showAlertWithNoDelegate:@"하트 구매에 실패하였습니다"];
    SJ_DEBUG_LOG(@"%@",sender);
    
}

#pragma APICALL RESULTS END






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
