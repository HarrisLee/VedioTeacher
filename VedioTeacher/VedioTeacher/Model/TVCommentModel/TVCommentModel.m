//
//  TVCommentModel.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TVCommentModel.h"

@implementation TVCommentModel
@synthesize Id;
@synthesize idTV;
@synthesize comment;
@synthesize commentAccountId;
@synthesize accountName;
@synthesize addTime;

-(void) dealloc
{
    [idTV release];
    [Id release];
    [comment release];
    [commentAccountId release];
    [accountName release];
    [addTime release];
    [super dealloc];
}
@end
