//
//  GetAccountListRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetAccountListRespBody.h"

@implementation GetAccountListRespBody
@synthesize accountListResult;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.accountListResult = array;
    [array release];
    
    for (id obj in value) {
        AccountModel *model = [[AccountModel alloc] init];
        [Utils setProperty:model withDic:obj];
        [accountListResult addObject:model];
        [model release];
    }
}

-(void) dealloc
{
    [accountListResult release];
    [super dealloc];
}

@end
