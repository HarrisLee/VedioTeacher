//
//  GetImgCommentRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetImgCommentRespBody.h"

@implementation GetImgCommentRespBody
@synthesize imageCommentArray;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.imageCommentArray = array;
    [array release];
    
//    for (id obj in value) {
//        ImageCommentModel *model = [[ImageCommentModel alloc] init];
//        [Utils setProperty:model withDic:obj];
//        [imageCommentArray addObject:model];
//        [model release];
//    }
}

-(void) dealloc
{
    [imageCommentArray release];
    [super dealloc];
}
@end
