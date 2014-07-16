//
//  GetMyExecuteTaskListRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetMyExecuteTaskListRespBody.h"

@implementation GetMyExecuteTaskListRespBody
@synthesize taskArray;

-(void) setValue:(id)value
{
    
}

-(void) dealloc
{
    [taskArray release];
    [super dealloc];
}

@end
