//
//  GetImgListRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetImgListRespBody.h"

@implementation GetImgListRespBody
@synthesize imageList;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.imageList = array;
    [array release];
    
//    for (id obj in value) {
//        ImageModel *model = [[ImageModel alloc] init];
//        [Utils setProperty:model withDic:obj];
//        [imageList addObject:model];
//        [model release];
//    }
}

-(void) dealloc
{
    [imageList release];
    [super dealloc];
}

@end
