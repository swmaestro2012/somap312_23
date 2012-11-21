//
//  SettingViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"

#import "ProfileViewController.h"
#import "PlistClass.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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

    
    NSString *isLock = [PlistClass readIsLock];
    if([isLock isEqualToString:@"YES"]){
        [self.lockSwitch setOn:YES];
    }
    [self.lockSwitch setOnTintColor:[UIColor colorWithRed:1 green:155.0/255.0 blue:165.0/255.0 alpha:1.0]];
    [self.pushSwitch setOnTintColor:[UIColor colorWithRed:1 green:155.0/255.0 blue:165.0/255.0 alpha:1.0]];

    // Do any additional setup after loading the view from its nib.
}


-(void)initView{
    
     
}



- (IBAction)goProflieView:(id)sender {
    
    ProfileViewController *profileViewCont = [ProfileViewController new];
    [self.navigationController pushViewController:profileViewCont animated:YES];
}





//--------------------------------------------------------
// Switch 버튼
//--------------------------------------------------------
- (IBAction)switchValueChanged{
    
    if (self.lockSwitch.on){
        [PlistClass writeIsLock:@"YES"];
    }
    
	else {
        [PlistClass writeIsLock:@"NO"];
    }
}

- (IBAction)pushValueChanged:(id)sender {
    
    if (self.pushSwitch.on){
    }
	else {
    }
}
//--------------------------------------------------------










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLockSwitch:nil];
    [self setPushSwitch:nil];
    [super viewDidUnload];
}
@end
