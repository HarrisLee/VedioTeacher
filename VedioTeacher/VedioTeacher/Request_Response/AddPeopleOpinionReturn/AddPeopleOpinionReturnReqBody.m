//
//  AddPeopleOpinionReturnReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddPeopleOpinionReturnReqBody.h"

@implementation AddPeopleOpinionReturnReqBody
@synthesize peopleOpinionId;
@synthesize returnOpinion;
@synthesize accountId;

-(void) dealloc
{
    [peopleOpinionId release];
    [returnOpinion release];
    [accountId release];
    [super dealloc];
}

@end
