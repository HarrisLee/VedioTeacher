//
//  AccountModel.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
@synthesize userId,userName,passowrd,loginname;

-(void) dealloc
{
    [userName release];
    [userId release];
    [passowrd release];
    [loginname release];
    [super dealloc];
}

@end
