//
//  ProfileViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 19..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController{
    int characterNumber;
}

@property (strong, nonatomic) IBOutlet UIView *characterView;
@property (strong, nonatomic) IBOutlet UIButton *car_1;
@property (strong, nonatomic) IBOutlet UIButton *car_2;
@property (strong, nonatomic) IBOutlet UIButton *car_3;
@property (strong, nonatomic) IBOutlet UIButton *car_4;
@property (strong, nonatomic) IBOutlet UIButton *car_5;
@property (strong, nonatomic) IBOutlet UIButton *car_6;


@end
