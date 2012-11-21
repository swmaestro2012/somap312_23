//
//  ViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 28..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"


@interface ViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate>{

    TabBarController *tabBarCont;
    NSTimer *timer;

    int characterNumber;
   
    int keywordNumber;
    NSString *keyword1;
    NSString *keyword2;
    NSString *keyword3;
}


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *introView0;
@property (strong, nonatomic) IBOutlet UIView *introView1;
@property (strong, nonatomic) IBOutlet UIView *introView2;
@property (strong, nonatomic) IBOutlet UIView *introView3;
@property (strong, nonatomic) IBOutlet UIView *introView4;
@property (strong, nonatomic) IBOutlet UIView *introView5;
@property (strong, nonatomic) IBOutlet UIView *introView6;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) IBOutlet UIView *keywordView;

//Character
@property (strong, nonatomic) IBOutlet UIView *characterView;
@property (strong, nonatomic) IBOutlet UIButton *car_1;
@property (strong, nonatomic) IBOutlet UIButton *car_2;
@property (strong, nonatomic) IBOutlet UIButton *car_3;
@property (strong, nonatomic) IBOutlet UIButton *car_4;
@property (strong, nonatomic) IBOutlet UIButton *car_5;
@property (strong, nonatomic) IBOutlet UIButton *car_6;


@property (strong, nonatomic) IBOutlet UILabel *keywordLabel_1;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel_2;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel_3;
- (IBAction)insertKeyword:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *keywordTextField;


-(void)showLockView;

@end
