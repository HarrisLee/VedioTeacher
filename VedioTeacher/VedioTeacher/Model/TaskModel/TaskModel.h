//
//  TaskModel.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject
{
    NSString *taskID;
    NSString *taskName;
    NSString *addTaskTime;
    NSString *isAccept;   //是否已经接受任务0为未接受  1为已经接受 2已经结束
    NSString *idSecondDirectory;
    NSString *addTaskAccountID;
    NSString *accountID;
    NSString *taskNote;
    NSString *isDel;
}
@property (nonatomic, retain) NSString *taskID;
@property (nonatomic, retain) NSString *taskName;
@property (nonatomic, retain) NSString *addTaskTime;
@property (nonatomic, retain) NSString *isAccept;
@property (nonatomic, retain) NSString *idSecondDirectory;
@property (nonatomic, retain) NSString *addTaskAccountID;
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *taskNote;
@property (nonatomic, retain) NSString *isDel;
@end