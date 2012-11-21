//
//  MessageCell.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 20..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *characater;
@property (strong, nonatomic) IBOutlet UIImageView *gender;
@property (strong, nonatomic) IBOutlet UIImageView *messagebox;
@property (strong, nonatomic) IBOutlet UILabel *keywordLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentsLabel;
@property (strong, nonatomic) IBOutlet UIButton *messageHistoryBtn;

@end
