//
//  LoginsViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-15.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyLoginReqBody.h"
#import "VerifyLoginRespBody.h"
#import "AddAccountReqBody.h"
#import "AddAccountRespBody.h"

@interface LoginsViewController : UIViewController
{
    UIView *loginView;
    UIView *registerView;
    UITextField *nameField;
    UITextField *passwordField;
}
@end
