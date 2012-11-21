//
//  SelectedByViewCell.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedByViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *characterImage;
@property (strong, nonatomic) IBOutlet UIImageView *genderImage;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel;
@property (strong, nonatomic) IBOutlet UIButton *rejectBtn;
@property (strong, nonatomic) IBOutlet UIButton *msgBtn;
@property (strong, nonatomic) IBOutlet UIButton *guessBtn;
@end
