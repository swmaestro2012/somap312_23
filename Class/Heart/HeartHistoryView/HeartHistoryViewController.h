//
//  HeartHistoryViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeartHistoryViewController : UIViewController{
    NSMutableArray *historyHeartArray;
}
-(void)initView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
