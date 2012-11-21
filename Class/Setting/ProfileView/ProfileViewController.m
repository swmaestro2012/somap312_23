//
//  ProfileViewController.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 19..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "PlistClass.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    characterNumber=1;

    // Do any additional setup after loading the view from its nib.
}


- (IBAction)saveProfile:(id)sender {

    // TODO
    // 프로파일 저장하기
    
    NSMutableDictionary *userInfoDic = [PlistClass readUserInfo];
    [userInfoDic setObject:[NSString stringWithFormat:@"%d",characterNumber] forKey:@"character"];
    
    [PlistClass writeUserInfo:userInfoDic];
    [APIcall update_user:self withParameter:userInfoDic SuccessSelector:@selector(update_user_SUCCESS:) failSelector:@selector(update_user_FAIL:)];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)update_user_SUCCESS:(id)sender{
}

-(void)update_user_FAIL:(id)sender{
}









//------------------------------------------------------------------
//캐릭터 설정 화면 생성
- (IBAction)choiceCharacter:(id)sender {
    [self.view addSubview:self.characterView];
}


- (IBAction)character_decided:(UIButton *)sender {
    
    characterNumber = sender.tag;
    
    for(int index=1; index<7; index++){
        
        UIImage *image_on = [UIImage imageNamed:[NSString stringWithFormat:@"intro_car_%d_on.png", index]];
        UIImage *image_off = [UIImage imageNamed:[NSString stringWithFormat:@"intro_car_%d_off.png", index]];
        
        if(index == characterNumber){
            
            switch (index) {
                case 1:
                    [self.car_1 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.car_2 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.car_3 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 4:
                    [self.car_4 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 5:
                    [self.car_5 setImage:image_off forState:UIControlStateNormal];
                    break;
                case 6:
                    [self.car_6 setImage:image_off forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            
        }else{
            
            switch (index) {
                case 1:
                    [self.car_1 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.car_2 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.car_3 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 4:
                    [self.car_4 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 5:
                    [self.car_5 setImage:image_on forState:UIControlStateNormal];
                    break;
                case 6:
                    [self.car_6 setImage:image_on forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }
    }
}


- (IBAction)endCharacterView:(id)sender {
    
    // Todo
    //어떤 캐릭터인지 전달하는 과정 필요    
    [self.characterView removeFromSuperview];
}

















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCharacterView:nil];
    [self setCar_1:nil];
    [self setCar_2:nil];
    [self setCar_3:nil];
    [self setCar_4:nil];
    [self setCar_5:nil];
    [self setCar_6:nil];
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
