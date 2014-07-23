//
//  UploadViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "FDirectoryModel.h"
#import "SDirectoryModel.h"
#import "GetSecondDirectoryReqBody.h"
#import "GetSecondDirectoryRespBody.h"
#import "GetMyExecuteTaskListReqBody.h"
#import "GetMyExecuteTaskListRespBody.h"
#import "QBImagePickerController.h"
#import "MBProgressHUD.h"
#import "UploadTVFileReqBody.h"
#import "UploadTVFileRespBody.h"


@interface UploadViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,QBImagePickerControllerDelegate,MBProgressHUDDelegate>
{
    UITextField *top1Field;
    UITextField *top2Field;
    UITextField *relevanceField;
    UITextField *vedioNameField;
    UIImageView *coverView;
    UITextView  *coverRemark;
    UITableView *dropView;
    NSInteger   selectType;   //1:一级目录  2:二级目录   3:关联任务
    NSMutableArray *secondArray;
    NSMutableArray *taskArray;
    NSMutableArray *uploadArray;
    NSInteger finishCount;
    NSInteger errorCount;
    MBProgressHUD *HUD;
    SDirectoryModel *selectModel;
    NSMutableArray *fileArray;
}
@end
