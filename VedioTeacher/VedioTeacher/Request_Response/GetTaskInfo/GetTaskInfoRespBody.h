//
//  GetTaskInfoRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "TaskModel.h"

@interface GetTaskInfoRespBody : RespBody
{
    NSMutableArray *taskResult;
}
@property (nonatomic, retain) NSMutableArray *taskResult;
@end
