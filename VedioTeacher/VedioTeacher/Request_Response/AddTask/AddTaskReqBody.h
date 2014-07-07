//
//  AddTaskReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddTaskReqBody : ReqBody
{
    NSString *taskName;
    NSString *taskNote;
    NSString *idSecondDirectory;
    NSString *addTaskAccountID;
    NSString *AcceptAccountList;
}
@property (nonatomic, retain) NSString *taskName;
@property (nonatomic, retain) NSString *taskNote;
@property (nonatomic, retain) NSString *idSecondDirectory;
@property (nonatomic, retain) NSString *addTaskAccountID;
@property (nonatomic, retain) NSString *AcceptAccountList;
@end
