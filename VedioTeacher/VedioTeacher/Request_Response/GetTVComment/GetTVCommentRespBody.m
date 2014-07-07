//
//  GetTVCommentRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTVCommentRespBody.h"

@implementation GetTVCommentRespBody
@synthesize commentResult;

-(void) setValue:(id)value
{
    self.commentResult = value;
}

-(void) dealloc
{
    [commentResult release];
    [super dealloc];
}

@end
