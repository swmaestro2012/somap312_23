//
//  MessageHistoryViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 20..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageHistoryViewController : UIViewController{
    
    NSString *target_facebook_id;
    NSMutableArray *messageHistoryArray;

}


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *gender;
@property (strong, nonatomic) IBOutlet UILabel *name;

-(void)init_SelectedBy:(NSDictionary *)parameter;
-(void)init_MyChoice:(NSDictionary *)parameter;

@end
