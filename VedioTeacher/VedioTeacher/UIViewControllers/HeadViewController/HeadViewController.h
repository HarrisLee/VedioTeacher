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

@interface HeadViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    NSString *topId;
    NSMutableArray *secArray;
    NSMutableArray *serviceArray;
}
@property (nonatomic, retain) NSString *topId;

@end
