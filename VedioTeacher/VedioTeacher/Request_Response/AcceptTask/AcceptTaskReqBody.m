//
//  AcceptTaskReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AcceptTaskReqBody.h"

@implementation AcceptTaskReqBody
@synthesize taskId;
@synthesize accountid;

-(void) dealloc
{
    [taskId release];
    [accountid release];
    [super dealloc];
}
@end
