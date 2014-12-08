//
//  IndexViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "HeadViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "MoreViewController.h"
#import "SendTaskViewController.h"
#import "GetTopDirectoryReqBody.h"
#import "GetTopDirectoryRespBody.h"

@interface IndexViewController : BaseViewController<UITabBarControllerDelegate>
{
    UIView *ipView;
    UITextView *ipField;
}
@end
