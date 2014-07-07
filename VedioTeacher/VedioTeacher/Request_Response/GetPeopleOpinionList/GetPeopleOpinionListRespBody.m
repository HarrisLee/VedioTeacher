//
//  GetPeopleOpinionListRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetPeopleOpinionListRespBody.h"

@implementation GetPeopleOpinionListRespBody
@synthesize peopleOptinArray;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.peopleOptinArray = array;
    [array release];
    
//    for (id obj in value) {
//        PeopleOptinModel *model = [[PeopleOptinModel alloc] init];
//        [Utils setProperty:model withDic:obj];
//        [peopleOptinArray addObject:model];
//        [model release];
//    }
}

-(void) dealloc
{
    [peopleOptinArray release];
    [super dealloc];
}
@end
