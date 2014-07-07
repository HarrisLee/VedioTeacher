//
//  RespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@implementation RespBody
@synthesize message;
@synthesize errorCode;

-(void) setValue:(id)value
{
    
}

-(void) dealloc
{
    [message release];
    [errorCode release];
    [super dealloc];
}

@end
