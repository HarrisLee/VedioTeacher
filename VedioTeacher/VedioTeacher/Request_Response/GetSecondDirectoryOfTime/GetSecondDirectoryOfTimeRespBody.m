//
//  GetSecondDirectoryOfTimeRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetSecondDirectoryOfTimeRespBody.h"

@implementation GetSecondDirectoryOfTimeRespBody
@synthesize searchArray;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.searchArray = array;
    [array release];
    
//    for (id obj in value) {
//        SDirectoryModel *model = [[SDirectoryModel alloc] init];
//        [Utils setProperty:model withDic:obj];
//        [searchArray addObject:model];
//        [model release];
//    }
}

-(void) dealloc
{
    [searchArray release];
    [super dealloc];
}

@end
