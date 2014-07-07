//
//  GetPeopleOpinionReturnRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetPeopleOpinionReturnRespBody.h"

@implementation GetPeopleOpinionReturnRespBody
@synthesize optinReturnArray;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.optinReturnArray = array;
    [array release];
    
    if (![value isKindOfClass:[NSArray class]]) {
        return ;
    }
    
//    for (id obj in value) {
//        OptinReturnModel *model = [[OptinReturnModel alloc] init];
//        [Utils setProperty:model withDic:obj];
//        [optinReturnArray addObject:model];
//        [model release];
//    }
}

-(void) dealloc
{
    [optinReturnArray release];
    [super dealloc];
}
@end
