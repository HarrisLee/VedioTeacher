//
//  AddSecondDirectoryRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddSecondDirectoryRespBody.h"

@implementation AddSecondDirectoryRespBody
@synthesize accountId;

-(void) setValue:(id)value
{
    self.accountId = value;
}

-(void) dealloc
{
    [accountId release];
    [super dealloc];
}
@end
