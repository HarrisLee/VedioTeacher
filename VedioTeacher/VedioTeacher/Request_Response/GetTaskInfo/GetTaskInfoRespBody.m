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
    if (![value isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    
    if (![[value objectForKey:@"tab2"] isKindOfClass:[NSArray class]]) {
        return ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.taskResult = array;
    [array release];
    
    for (id obj in [value objectForKey:@"tab2"]) {
        TaskModel *model = [[TaskModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [taskResult addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [taskResult release];
    [super dealloc];
}

@end
