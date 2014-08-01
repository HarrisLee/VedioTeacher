//
//  VedioModel.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "VedioModel.h"

@implementation VedioModel
@synthesize idTV;
@synthesize nameTV;
@synthesize tvVirtualPath;
@synthesize tvPicVirtualPath;
@synthesize fileTVName;
@synthesize goodCount;
@synthesize accountName;
@synthesize addAccountId;
@synthesize addTime;
@synthesize describeTV;
@synthesize tvPicName;

-(void) dealloc
{
    [idTV release];
    [nameTV release];
    [tvVirtualPath release];
    [tvPicVirtualPath release];
    [fileTVName  release];
    [goodCount release];
    [accountName release];
    [addTime release];
    [addAccountId release];
    [describeTV release];
    [tvPicName release];
    [super dealloc];
}

@end
