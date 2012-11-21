//
//  MessageHistoryCell.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 20..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageHistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photo_bg;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *messageBox;
@property (strong, nonatomic) IBOutlet UILabel *content;

@end
