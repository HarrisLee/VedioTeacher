//
//  ImageCommentModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ImageCommentModel.h"

@implementation ImageCommentModel
@synthesize Id = _Id;
@synthesize idImg,comment,commentAccountId,addtime,accountName;

-(void) dealloc
{
    [_Id release];
    [idImg release];
    [comment release];
    [commentAccountId release];
    [addtime release];
    [accountName release];
    [super dealloc];
}

@end
