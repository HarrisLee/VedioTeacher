//
//  AddSecondDirectoryRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddSecondDirectoryRespBody.h"

@implementation AddSecondDirectoryRespBody
@synthesize secondDir;

-(void) setValue:(id)value
{
    self.secondDir = value;
}

-(void) dealloc
{
    [secondDir release];
    [super dealloc];
}
@end
