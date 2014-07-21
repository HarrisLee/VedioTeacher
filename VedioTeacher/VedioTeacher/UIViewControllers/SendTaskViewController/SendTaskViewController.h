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
#import "GetAccountListReqBody.h"
#import "GetAccountListRespBody.h"
#import "GetTaskInfoReqBody.h"
#import "GetTaskInfoRespBody.h"
#import "GetMyAcceptTaskListReqBody.h"
#import "GetMyAcceptTaskListRespBody.h"
#import "GetMySendTaskListReqBody.h"
#import "GetMySendTaskListRespBody.h"
#import "GetMyTVListOfTimeReqBody.h"
#import "GetMyTVListOfTimeRespBody.h"
#import "GetMyTVListOfGoodCountReqBody.h"
#import "GetMyTVListOfGoodCountRespBody.h"
#import "AddTaskReqBody.h"
#import "AddTaskRespBody.h"
#import "AcceptTaskReqBody.h"
#import "AcceptTaskRespBody.h"
#import "EndTaskReqBody.h"
#import "EndTaskRespBody.h"


@interface SendTaskViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,DateShowCellDelegate>
{
    UIView *headerView;
    UIImageView *userIcon;
    UILabel *nameLabel;
    UIButton *submit;    //立即发布

    //已经发布的任务、详细信息
    UIView *sendedView;
    NSInteger didSection;  //选择的Section 用于确定年份
    NSMutableArray *accountArray; //所有用户数组
    NSMutableArray *taskArray;  //发布的任务数组
    NSMutableArray *acceptArray; //接受的任务数组
    NSMutableArray *dateArray; //年份数组
    UITableView *sendTable;  //左侧列表
    NSString *showTask;   //展示标识 1：我发布的 2：我接受的
    NSString *startTime;
    NSString *endTime;
    
    UIImageView *titleRect;
    
    UITextField *taskTitleField;
    UILabel *taskAccount;
    UILabel *taskAccountName;
    UILabel *taskInfo;
    UITextView *taskInfoView;
    
    UIScrollView *userScroll;
    
}
@end
