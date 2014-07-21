//
//  AccountModel.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
@synthesize idAccoun,accountName,accountPassword,peopleName;

-(void) dealloc
{
    [idAccoun release];
    [accountName release];
    [accountPassword release];
    [peopleName release];
    [super dealloc];
}

@end
