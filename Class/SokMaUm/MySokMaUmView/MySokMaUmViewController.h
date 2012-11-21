//
//  MySokMaUmViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 4..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySokMaUmViewController : UIViewController <UIGestureRecognizerDelegate>{
    
    NSMutableArray *selectedByArray;
    NSMutableArray *myChoiceArray;
    Boolean nowUpDown;

}

//SokMaUmInfoView
@property (strong, nonatomic) IBOutlet UIView *SokMaUmInfoView;
@property (strong, nonatomic) IBOutlet UILabel *totalUserLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalMatchedLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPokeLabel;


//속마음뷰

@property (strong, nonatomic) IBOutlet UIButton *checkbtn;
@property (strong, nonatomic) IBOutlet UILabel *gotPokedNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *gotPokedPeopleImage;
@property (strong, nonatomic) IBOutlet UIImageView *noPokeImg;


@property (strong, nonatomic) IBOutlet UIScrollView *mySelectionScrollView;
-(void)initView;
@end
