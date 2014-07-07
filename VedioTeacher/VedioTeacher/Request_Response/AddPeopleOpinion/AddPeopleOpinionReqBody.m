//
//  AddPeopleOpinionReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddPeopleOpinionReqBody.h"

@implementation AddPeopleOpinionReqBody
@synthesize opinionNote;
@synthesize addIpAddress;
@synthesize PeopleId;

-(void) dealloc
{
    [opinionNote release];
    [addIpAddress release];
    [PeopleId release];
    [super dealloc];
}

@end
