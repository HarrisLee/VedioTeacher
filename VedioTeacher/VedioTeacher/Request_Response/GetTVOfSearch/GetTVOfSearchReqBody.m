//
//  GetTVOfSearchReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTVOfSearchReqBody.h"

@implementation GetTVOfSearchReqBody
@synthesize startTime;
@synthesize endTime;
@synthesize TVGJZ;
@synthesize jobId;
@synthesize accountId;

-(void) dealloc
{
    [startTime release];
    [endTime release];
    [TVGJZ release];
    [jobId release];
    [accountId release];
    [super dealloc];
}

@end
