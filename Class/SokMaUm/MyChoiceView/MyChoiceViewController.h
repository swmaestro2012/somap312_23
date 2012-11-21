//
//  MyChoiceViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyChoiceViewController : UIViewController{
    
    int currentChoice;
    NSMutableArray *myChoiceArray;
}
@property (strong, nonatomic) IBOutlet UIImageView *selectedBy_BG;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UIImageView *gender;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;

-(void)initView:(NSMutableArray *)tempMyChoiceArray currentChoice:(int)tempCurrentChoice;
@end
