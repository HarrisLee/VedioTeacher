//
//  EndTaskReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "EndTaskReqBody.h"

@implementation EndTaskReqBody
@synthesize taskId;
@synthesize accountid;

-(void) dealloc
{
    [taskId release];
    [accountid release];
    [super dealloc];
}
@end
