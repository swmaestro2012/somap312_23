//
//  FriendListCell.h
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 31..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokeViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userGender;
@property (strong, nonatomic) IBOutlet UIButton *pokeBtn;

@end
