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
@synthesize virtualPath;
@synthesize tvPicVirtualPath;
@synthesize fileImgName;
@synthesize goodCount;
@synthesize accountName;
@synthesize addAccountId;
@synthesize addTime;
@synthesize describeTV;

-(void) dealloc
{
    [idTV release];
    [nameTV release];
    [virtualPath release];
    [tvPicVirtualPath release];
    [fileImgName  release];
    [goodCount release];
    [accountName release];
    [addTime release];
    [addAccountId release];
    [describeTV release];
    [super dealloc];
}

@end
