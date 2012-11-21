//
//  HeartViewController.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeartViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *heartCountLabel;

-(void)initView;

@end
