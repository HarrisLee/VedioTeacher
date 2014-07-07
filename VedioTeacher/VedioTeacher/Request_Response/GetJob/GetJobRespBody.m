//
//  GetJobRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetJobRespBody.h"

@implementation GetJobRespBody
@synthesize jobArray;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.jobArray = array;
    [array release];
    
    if (![value isKindOfClass:[NSArray class]]) {
        return ;
    }
    
//    for (id obj in value) {
//        JobModel *model = [[JobModel alloc] init];
//        [Utils setProperty:model withDic:obj];
//        [jobArray addObject:model];
//        [model release];
//    }
}

-(void) dealloc
{
    [jobArray release];
    [super dealloc];
}

@end
