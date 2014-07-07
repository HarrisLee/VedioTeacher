//
//  UploadTVFileReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "UploadTVFileReqBody.h"

@implementation UploadTVFileReqBody
@synthesize fs;
@synthesize idSecondDirectory;
@synthesize idTask;
@synthesize addAccountId;
@synthesize describeTV;
@synthesize nameTV;

-(void) dealloc
{
    [fs release];
    [idTask release];
    [idSecondDirectory release];
    [addAccountId release];
    [describeTV release];
    [nameTV release];
    [super dealloc];
}

@end
