//
//  SecurityViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityViewController : UIViewController{
    
    int passwordCount;
}


@property (strong, nonatomic) IBOutlet UIImageView *first;
@property (strong, nonatomic) IBOutlet UIImageView *second;
@property (strong, nonatomic) IBOutlet UIImageView *third;
@property (strong, nonatomic) IBOutlet UIImageView *fourth;
-(void)initView;

@end
