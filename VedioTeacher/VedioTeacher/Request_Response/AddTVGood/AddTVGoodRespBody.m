//
//  AddTVGoodRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddTVGoodRespBody.h"

@implementation AddTVGoodRespBody
@synthesize tVGoodResult;

-(void) setValue:(id)value
{
    self.tVGoodResult = value;
}

-(void) dealloc
{
    [tVGoodResult release];
    [super dealloc];
}

@end
