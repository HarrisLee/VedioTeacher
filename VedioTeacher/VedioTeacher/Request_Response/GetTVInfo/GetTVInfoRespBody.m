//
//  GetTVInfoRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetTVInfoRespBody.h"

@implementation GetTVInfoRespBody
@synthesize info;

-(void) setValue:(id)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        self.info = nil;
        return ;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[value objectAtIndex:0]];
    self.info =  dic;
    [dic release];
}

-(void) dealloc
{
    [info release];
    [super dealloc];
}@end
