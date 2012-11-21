//
//  popUpView.h
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 18..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum PopUpView_Type{
    POPUP_POKE,
    POPUP_GUESS,
    POPUP_REJECT,
    POPUP_MESSAGE
}PopUpView_Type;

@interface popUpView : UIView {
    id delegate;
    SEL successSel;
    SEL failSel;
}

@property (strong, nonatomic) IBOutlet UIImageView *popupBG;
@property (strong, nonatomic) IBOutlet UIButton *popupLeftBtn;
@property (strong, nonatomic) IBOutlet UIButton *popupRightBtn;
@property (nonatomic, assign) SEL successSel;
@property (nonatomic, assign) SEL failSel;

-(IBAction)leftClick:(id)sender;
-(IBAction)rightClick:(id)sender;
-(void)setPopupView:(PopUpView_Type)type withDelegate:(id)sender leftSelector:(SEL)sel1 rightSelector:(SEL)sel2 info:(NSString *)info;

@end
