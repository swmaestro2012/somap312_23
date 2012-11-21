//
//  SelectedByViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 11..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedByViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *selectedByArray;
    int currentIndex;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)initView:(NSMutableArray *)tempSelectedByArray;

@end
