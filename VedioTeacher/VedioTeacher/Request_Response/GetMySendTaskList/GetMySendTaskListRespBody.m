//
//  GetMySendTaskListRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetMySendTaskListRespBody.h"

@implementation GetMySendTaskListRespBody
@synthesize taskList;

-(void) setValue:(id)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        return ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.taskList = array;
    [array release];
    
    for (id obj in value) {
        TaskModel *model = [[TaskModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [taskList addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [taskList release];
    [super dealloc];
}
@end
