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
    if (![value isKindOfClass:[NSArray class]]) {
        return ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.taskArray = array;
    [array release];
    
    for (id obj in value) {
        TaskModel *model = [[TaskModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [taskArray addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [taskArray release];
    [super dealloc];
}

@end
