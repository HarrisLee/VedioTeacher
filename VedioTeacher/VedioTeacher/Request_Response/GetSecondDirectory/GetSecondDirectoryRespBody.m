//
//  GetSecondDirectoryRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetSecondDirectoryRespBody.h"

@implementation GetSecondDirectoryRespBody
@synthesize sDirectoryArray;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.sDirectoryArray = array;
    [array release];
    
    for (id obj in value) {
        SDirectoryModel *model = [[SDirectoryModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [sDirectoryArray addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [sDirectoryArray release];
    [super dealloc];
}

@end
