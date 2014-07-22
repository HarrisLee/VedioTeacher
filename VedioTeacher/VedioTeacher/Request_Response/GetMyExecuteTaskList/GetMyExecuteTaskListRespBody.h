//
//  GetMyExecuteTaskListRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "TaskModel.h"

@interface GetMyExecuteTaskListRespBody : RespBody
{
    NSMutableArray *taskArray;
}
@property (nonatomic, retain) NSMutableArray *taskArray;
@end
