//
//  AddTVGoodReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddTVGoodReqBody.h"

@implementation AddTVGoodReqBody
@synthesize TVId;
@synthesize AccountId;

-(void) dealloc
{
    [TVId release];
    [AccountId release];
    [super dealloc];
}

@end
