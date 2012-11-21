//
//  PokeViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 10. 30..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SORT_ALL,
    SORT_OPPOSITE_GENDER,
}SORT_METHOD;

@interface PokeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>{
    
    NSDictionary *myProfileInfo;

    NSArray *facebookFriendArray;
    //NSMutableArray *facebookOppositeGenderFriendArray;
    NSArray *currentTableViewDataArray;

    SORT_METHOD sort_method;
    int currentIndex;
}

-(void)initView;


@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
