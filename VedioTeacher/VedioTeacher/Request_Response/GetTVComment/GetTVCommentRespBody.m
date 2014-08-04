//
//  GetTVCommentRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTVCommentRespBody.h"

@implementation GetTVCommentRespBody
@synthesize commentList;

-(void) setValue:(id)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        return ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.commentList = array;
    [array release];
    
    for (id obj in value) {
        TVCommentModel *model = [[TVCommentModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [commentList addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [commentList release];
    [super dealloc];
}

@end
