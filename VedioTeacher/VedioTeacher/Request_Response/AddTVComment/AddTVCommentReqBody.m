//
//  AddTVCommentReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddTVCommentReqBody.h"

@implementation AddTVCommentReqBody
@synthesize TVId,commentNote,accountId;

-(void) dealloc
{
    [TVId release];
    [commentNote release];
    [accountId release];
    [super dealloc];
}

@end
