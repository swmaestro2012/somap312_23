//
//  MessageViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController{
    
    NSMutableArray *myChoiceArray;
    NSMutableArray *selectedByArray;    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)initView;

@end
