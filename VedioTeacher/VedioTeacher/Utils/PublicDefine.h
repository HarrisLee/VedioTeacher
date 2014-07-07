//
//  PublicDefine.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 13-12-2.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#ifndef HeyXuanWu_PublicDefine_h
#define HeyXuanWu_PublicDefine_h

#define mainScreenBounds        [UIScreen mainScreen].bounds

#define viewWithNavAndTabbar    mainScreenBounds.size.height- 20 - 44 - 48

#define viewWithNavNoTabbar     mainScreenBounds.size.height - 20 - 44

#define SCREEN_HEIGHT    mainScreenBounds.size.height

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define boundsWidth    mainScreenBounds.size.width

#define boundsHeight    mainScreenBounds.size.height

#define isIOS7	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define ISIOS7    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define kIOS7EdgeInsert  (ISIOS7 ? 64 : 0)

#define kNavigationHeight  (ISIOS7 ? 44 : 0)

#define kIOS7StatusInsert  (ISIOS7 ? 20 : 0)

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define rgbaColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define  normalTextColor [UIColor whiteColor]

#define cusColor  0xA2B5CD

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define GET_IMAGE(__NAME__,__TYPE__)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__NAME__ ofType:__TYPE__]]

#define kTextAlignmentCenter  (ISIOS7 ? NSTextAlignmentCenter : UITextAlignmentCenter)

#define kTextAlignmentRight   (ISIOS7 ? NSTextAlignmentRight : UITextAlignmentRight)


#define alertMessage(x) {UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:x delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];[alertView show];[alertView release];}

#define AddSize                @"10"

#define DEVEICE_VERSION [[UIDevice currentDevice] systemVersion]

#define  MainMenuGoup   3


#pragma indexView defineParamater

#define kShowTime 3.0

#endif





