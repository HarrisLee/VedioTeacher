//
//  GetPeopleOpinionListReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetPeopleOpinionListReqBody.h"

@implementation GetPeopleOpinionListReqBody
@synthesize startTime;
@synthesize endTime;

-(void) dealloc
{
    [startTime release];
    [endTime release];
    [super dealloc];
}

@end
