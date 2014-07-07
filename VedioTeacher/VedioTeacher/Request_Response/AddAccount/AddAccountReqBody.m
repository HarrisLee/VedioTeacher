//
//  AddAccountReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddAccountReqBody.h"

@implementation AddAccountReqBody
@synthesize accountName;
@synthesize accountPassword;
@synthesize peopleJob;
@synthesize peopleMobileNo;
@synthesize peopleName;

-(void) dealloc
{
    [accountPassword release];
    [accountName release];
    [peopleName release];
    [peopleMobileNo release];
    [peopleJob release];
    [super dealloc];
}

@end
