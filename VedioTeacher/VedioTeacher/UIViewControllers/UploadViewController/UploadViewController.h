//
//  UploadViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"

@interface UploadViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
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
}
@end
