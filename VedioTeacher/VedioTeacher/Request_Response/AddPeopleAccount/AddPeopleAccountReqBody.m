//
//  AddPeopleAccountReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddPeopleAccountReqBody.h"

@implementation AddPeopleAccountReqBody
@synthesize PeopleMobileNo;
@synthesize PeopleName;

-(void) dealloc
{
    [PeopleName release];
    [PeopleMobileNo release];
    [super dealloc];
}

@end
