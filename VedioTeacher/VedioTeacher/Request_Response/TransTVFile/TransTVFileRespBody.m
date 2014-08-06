//
//  TransTVFileRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-8-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TransTVFileRespBody.h"

@implementation TransTVFileRespBody
@synthesize result;

-(void) setValue:(id)value
{
    self.result = value;
}

-(void) dealloc
{
    [result release];
    [super dealloc];
}
@end
