//
//  UtilClass.m
//  SokMaUm
//
//  Created by SeiJin on 12. 11. 14..
//  Copyright (c) 2012년 SeiJin. All rights reserved.
//

#import "UtilClass.h"

@implementation UtilClass

/*
 1. plist에 <UIAppFonts>항목에 파일이름을 등록합니다. (확장자도 포함해서)
 물론 글꼴도 리소스에 포함해야겠죠.
 
 2. Finder의 Inspector를 보고 글꼴의 패밀리 이름을 알아둡니다.
 또는 Font Book으로 열어서 얻을 수 있습니다.
 참고로 나눔글꼴(OTF)은 "NanumGothicOTF", 맑은 고딕(TTF)은 "Malgun Gothic"이 됩니다.
 
 NSLog(@"FONTS: %@", [UIFont familyNames]);
 해서 패임리 이름이 보이면 글꼴이 등록된 것입니다.
 
 3. 글꼴을 사용하기 위해서 이름을 알아야하는데,
 NSLog(@"FONTS: %@", [UIFont fontNamesForFamilyName:@"NanumGothicOTF"]);
 NSLog(@"FONTS: %@", [UIFont fontNamesForFamilyName:@"Malgun Gothic"]);
 이런 식으로 패밀리 이름으로 글꼴의 이름을 알아냅니다.
 
 참고로 나눔고딕 Regular와 Bold를 추가했다면 "NanumGothicOTF", "NanumGothicOTFBold" 이 나오고,
 맑은고딕은 "MalgunGothicRegular", "MalgunGothicBold" 이렇게 나올 겁니다.
 
 4. 사용할 때는,
 [UIFont fontWithName:@"NanumGothicOTFBold" size:10];
 이런 식으로 위에서 얻은 이름으로 사용합니다.
 통상적으로 볼드체가  "NanumGothicOTF-Bold" 것이라 생각하면 안된다는 겁니다...
 
 NanumGothic
 */

//------------------------------------------------------------
// 나눔고딕으로 다 폰트 바꾸기
//------------------------------------------------------------
+(void)changeFont:(UIView *)targetView
{
    for (UIView* subView in targetView.subviews) {
        if ([subView isKindOfClass:[UIView class]]){
            [self changeFont:subView];
        }
        if ([subView respondsToSelector:@selector(font)] == NO) continue;
        if ([subView respondsToSelector:@selector(setFont:)] == NO) continue;
        if ([[(id)subView font] isKindOfClass:[UIFont class]] == NO) continue;
        
        CGFloat fontSize = ((UIFont*)[(id)subView font]).pointSize;
        [(id)subView setFont:[UIFont fontWithName:@"NanumGothic" size:fontSize]];
    }
}

//------------------------------------------------------------
// 단순 알럿창 띄우기
//------------------------------------------------------------
+(void)showAlertWithNoDelegate:(NSString *)message{
    
    
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: nil
                              message: message
                              delegate: nil
                              cancelButtonTitle: @"확인"
                              otherButtonTitles: nil];
        [alert show];
}


//------------------------------------------------------------
// 캐릭터 이미지 골라주기
//------------------------------------------------------------
+(UIImage *)characterImage:(NSString *)characterNumber{
    
    UIImage *characterImage;
    int characterNum = [characterNumber intValue];
    
    switch (characterNum) {
        case 1:
            characterImage = [UIImage imageNamed:@"common_character_1.png"];
            break;
        case 2:
            characterImage = [UIImage imageNamed:@"common_character_2.png"];
            break;
        case 3:
            characterImage = [UIImage imageNamed:@"common_character_3.png"];
            break;
        case 4:
            characterImage = [UIImage imageNamed:@"common_character_4.png"];
            break;
        case 5:
            characterImage = [UIImage imageNamed:@"common_character_5.png"];
            break;
        case 6:
            characterImage = [UIImage imageNamed:@"common_character_6.png"];
            break;
        default:
            characterImage = [UIImage imageNamed:@"common_character_1.png"];
            break;
    }
    
    return characterImage;
}


@end
