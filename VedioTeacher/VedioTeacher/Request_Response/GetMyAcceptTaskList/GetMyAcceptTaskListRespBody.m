//
//  GetMyAcceptTaskListRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetMyAcceptTaskListRespBody.h"

@implementation GetMyAcceptTaskListRespBody
@synthesize taskAcceptList;

-(void) setValue:(id)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        return ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.taskAcceptList = array;
    [array release];
    
    for (id obj in value) {
        TaskModel *model = [[TaskModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [taskAcceptList addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [taskAcceptList release];
    [super dealloc];
}
@end
