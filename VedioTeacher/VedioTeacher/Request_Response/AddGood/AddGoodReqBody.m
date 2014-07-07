//
//  AddGoodReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddGoodReqBody.h"

@implementation AddGoodReqBody
@synthesize imgId;
@synthesize AccountId;

-(void) dealloc
{
    [imgId release];
    [AccountId release];
    [super dealloc];
}

@end
