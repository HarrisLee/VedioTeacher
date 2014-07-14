//
//  HeadViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "GetSecondDirectoryReqBody.h"
#import "GetSecondDirectoryRespBody.h"
#import "AddSecondDirectoryReqBody.h"
#import "AddSecondDirectoryRespBody.h"
#import "AddSecondDirView.h"
#import "SDirectoryModel.h"
#import "AddAccountReqBody.h"
#import "AddAccountRespBody.h"
#import "VerifyLoginReqBody.h"
#import "VerifyLoginRespBody.h"

@interface HeadViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    NSString *topId;
    NSMutableArray *secArray;
}
@property (nonatomic, retain) NSString *topId;

@end
