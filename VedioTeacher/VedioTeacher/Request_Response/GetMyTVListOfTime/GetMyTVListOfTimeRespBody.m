//
//  GetMyTVListOfTimeRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetMyTVListOfTimeRespBody.h"

@implementation GetMyTVListOfTimeRespBody
@synthesize tvList;

-(void) setValue:(id)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.tvList = array;
    [array release];
    
    for (id obj in value) {
        //        SDirectoryModel *model = [[SDirectoryModel alloc] init];
        //        [Utils setProperty:model withDic:obj];
        //        [tvList addObject:model];
        //        [model release];
    }
}

-(void) dealloc
{
    [tvList release];
    [super dealloc];
}
@end
