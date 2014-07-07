//
//  AddTaskReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddTaskReqBody.h"

@implementation AddTaskReqBody
@synthesize taskName;
@synthesize taskNote;
@synthesize idSecondDirectory;
@synthesize addTaskAccountID;
@synthesize AcceptAccountList;

-(void) dealloc
{
    [taskNote release];
    [taskName release];
    [idSecondDirectory release];
    [addTaskAccountID release];
    [AcceptAccountList release];
    [super dealloc];
}

@end
