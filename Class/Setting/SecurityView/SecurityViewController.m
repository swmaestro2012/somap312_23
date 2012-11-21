//
//  SecurityViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "SecurityViewController.h"
#import "AppDelegate.h"

@interface SecurityViewController ()

@end

@implementation SecurityViewController

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

-(void)initView{
    
    passwordCount=0;
}


- (IBAction)numberPressed:(UIButton *)sender {
    
    passwordCount++;

    switch (passwordCount) {
        case 1:
            [self.first setImage:[UIImage imageNamed:@"security_on.png"]];
            break;
        case 2:
            [self.second setImage:[UIImage imageNamed:@"security_on.png"]];
            break;
        case 3:
            [self.third setImage:[UIImage imageNamed:@"security_on.png"]];
            break;
        case 4:
            [self.fourth setImage:[UIImage imageNamed:@"security_on.png"]];
            break;
        default:
            break;
    }
    
    
    if(passwordCount==4){
        [self dismissModalViewControllerAnimated:NO];
    }
    
}

- (IBAction)backPresesd:(id)sender {
    
    switch (passwordCount) {
        case 1:
            [self.first setImage:[UIImage imageNamed:@"security_off.png"]];
            break;
        case 2:
            [self.second setImage:[UIImage imageNamed:@"security_off.png"]];
            break;
        case 3:
            [self.third setImage:[UIImage imageNamed:@"security_off.png"]];
            break;
        case 4:
            [self.fourth setImage:[UIImage imageNamed:@"security_off.png"]];
            break;
        default:
            break;
    }
    
    if(passwordCount!=0){
        passwordCount--;
    }
}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFirst:nil];
    [self setSecond:nil];
    [self setThird:nil];
    [self setFourth:nil];
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
