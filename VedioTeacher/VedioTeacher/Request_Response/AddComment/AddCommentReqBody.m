//
//  AddCommentReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddCommentReqBody.h"

@implementation AddCommentReqBody
@synthesize imgId;
@synthesize accountId;
@synthesize commentNote;

-(void) dealloc
{
    [imgId release];
    [accountId release];
    [commentNote release];
    [super dealloc];
}
@end
