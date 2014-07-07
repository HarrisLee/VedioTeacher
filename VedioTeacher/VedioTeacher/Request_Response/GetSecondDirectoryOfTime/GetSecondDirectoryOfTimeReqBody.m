//
//  GetSecondDirectoryOfTimeReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetSecondDirectoryOfTimeReqBody.h"

@implementation GetSecondDirectoryOfTimeReqBody
@synthesize startTime;
@synthesize endTime;
@synthesize jobId;

-(void) dealloc
{
    [startTime release];
    [endTime release];
    [jobId release];
    [super dealloc];
}

@end
