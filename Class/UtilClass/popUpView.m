//
//  popUpView.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 18..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "popUpView.h"

@implementation popUpView
@synthesize successSel;
@synthesize failSel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)leftClick:(id)sender{
    [delegate performSelector:successSel];
}

-(IBAction)rightClick:(id)sender{
    [delegate performSelector:failSel];
}


-(void)setPopupView:(PopUpView_Type)type withDelegate:(id)sender leftSelector:(SEL)sel1 rightSelector:(SEL)sel2 info:(NSString *)info{
    
    if(type == POPUP_POKE)
    {
        [self.popupBG setImage:[UIImage imageNamed:@"poke_popup_bg.png"]];
        [self.popupLeftBtn setImage:[UIImage imageNamed:@"poke_popup_left.png"] forState:UIControlStateNormal];
        [self.popupRightBtn setImage:[UIImage imageNamed:@"poke_popup_right.png"] forState:UIControlStateNormal];

    }else if(type == POPUP_GUESS){
        
        [self.popupBG setImage:[UIImage imageNamed:@"guess_popup_bg.png"]];
        [self.popupLeftBtn setImage:[UIImage imageNamed:@"guess_popup_left.png"] forState:UIControlStateNormal];
        [self.popupRightBtn setImage:[UIImage imageNamed:@"guess_popup_right.png"] forState:UIControlStateNormal];

    }else if(type == POPUP_MESSAGE) {
        
        [self.popupBG setImage:[UIImage imageNamed:@"message_popup_bg.png"]];
        [self.popupLeftBtn setImage:[UIImage imageNamed:@"message_popup_left.png"] forState:UIControlStateNormal];
        [self.popupRightBtn setImage:[UIImage imageNamed:@"message_popup_right.png"] forState:UIControlStateNormal];

    }else if(type == POPUP_REJECT) {
    
        [self.popupBG setImage:[UIImage imageNamed:@"reject_popup_bg.png"]];
        [self.popupLeftBtn setImage:[UIImage imageNamed:@"reject_popup_left.png"] forState:UIControlStateNormal];
        [self.popupRightBtn setImage:[UIImage imageNamed:@"reject_popup_right.png"] forState:UIControlStateNormal];

    }
    
    
    delegate = sender;
    self.successSel = sel1;
    self.failSel = sel2;
}


@end
