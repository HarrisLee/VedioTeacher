//
//  PeopleOptinModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "PeopleOptinModel.h"

@implementation PeopleOptinModel
@synthesize id = _id;
@synthesize opinionNote,PeopleId,PeopleName,addIpAddress,addTime,isDel;

-(void) dealloc
{
    [_id release];
    [opinionNote release];
    [PeopleName release];
    [PeopleId release];
    [addTime release];
    [addIpAddress release];
    [isDel release];
    [super dealloc];
}

@end
