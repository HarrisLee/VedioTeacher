//
//  GetTopDirectoryRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTopDirectoryRespBody.h"

@implementation GetTopDirectoryRespBody
@synthesize topDirectoryArray;

-(void) setValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return ;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.topDirectoryArray = array;
    [array release];
    
    for (id obj in value) {
        FDirectoryModel *model = [[FDirectoryModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [topDirectoryArray addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [topDirectoryArray release];
    [super dealloc];
}

@end
