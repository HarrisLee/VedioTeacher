//
//  TaskModel.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel
@synthesize taskID;
@synthesize taskName;
@synthesize addTaskTime;
@synthesize isAccept;
@synthesize idSecondDirectory;
@synthesize addTaskAccountID;
@synthesize accountID;
@synthesize taskNote;
@synthesize isDel;

-(void) dealloc
{
    [taskID release];
    [taskName release];
    [addTaskTime release];
    [isAccept release];
    [idSecondDirectory release];
    [addTaskAccountID release];
    [accountID release];
    [taskNote release];
    [isDel release];
    [super dealloc];
}
@end
