//
//  GetMyAcceptTaskListReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetMyAcceptTaskListReqBody.h"

@implementation GetMyAcceptTaskListReqBody
@synthesize startTime;
@synthesize endTime;
@synthesize accountId;

-(void) dealloc
{
    [startTime release];
    [endTime release];
    [accountId release];
    [super dealloc];
}
@end
