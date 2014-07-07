//
//  GetTaskInfoRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTaskInfoRespBody.h"

@implementation GetTaskInfoRespBody
@synthesize taskResult;

-(void) setValue:(id)value
{
    self.taskResult = value;
}

-(void) dealloc
{
    [taskResult release];
    [super dealloc];
}

@end
