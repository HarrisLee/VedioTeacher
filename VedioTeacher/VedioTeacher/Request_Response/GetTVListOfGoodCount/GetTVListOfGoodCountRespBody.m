//
//  GetTVListOfGoodCountRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTVListOfGoodCountRespBody.h"

@implementation GetTVListOfGoodCountRespBody
@synthesize count;

-(void) setValue:(id)value
{
    self.count = value;
}

-(void) dealloc
{
    [count release];
    [super dealloc];
}

@end
