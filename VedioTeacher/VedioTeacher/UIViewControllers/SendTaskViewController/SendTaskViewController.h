//
//  SendTaskViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "DateShowCell.h"
#import "TaskCell.h"

@interface SendTaskViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,DateShowCellDelegate>
{
    UIView *headerView;
    UIImageView *userIcon;
    UILabel *nameLabel;
    UIButton *submit;    //立即发布

    //已经发布的任务、详细信息
    UIView *sendedView;
    NSInteger didSection;
    NSMutableArray *taskArray;
    NSMutableArray *acceptArray;
    NSMutableArray *dateArray;
    UITableView *sendTable;
    NSString *showTask;
    NSString *startTime;
    NSString *endTime;
    
    UITextField *taskTitleField;
    UILabel *taskAccount;
    UILabel *taskAccountName;
    UILabel *taskInfo;
    UITextView *taskInfoView;
    
    UIScrollView *userScroll;
    
}
@end
