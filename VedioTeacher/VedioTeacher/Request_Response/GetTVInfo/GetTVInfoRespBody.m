//
//  GetTVInfoRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTVInfoRespBody.h"

@implementation GetTVInfoRespBody
@synthesize info;

-(void) setValue:(id)value
{
    self.info = value;
}

-(void) dealloc
{
    [info release];
    [super dealloc];
}@end
