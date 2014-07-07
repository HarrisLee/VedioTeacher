//
//  UploadTVFileRespBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "UploadTVFileRespBody.h"

@implementation UploadTVFileRespBody
@synthesize result;

-(void) setValue:(id)value
{
    self.result = value;
}

-(void) dealloc
{
    [result release];
    [super dealloc];
}
@end
