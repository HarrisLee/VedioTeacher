//
//  TransTVFileReqBody.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-8-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TransTVFileReqBody.h"

@implementation TransTVFileReqBody
@synthesize fs;
@synthesize idSecondDirectory;
@synthesize idTask;
@synthesize addAccountId;
@synthesize describeTV;
@synthesize nameTV;
@synthesize ifCreate;
@synthesize TVfileName;
@synthesize tvPicfileName;

-(void) dealloc
{
    [fs release];
    [idTask release];
    [idSecondDirectory release];
    [addAccountId release];
    [describeTV release];
    [nameTV release];
    [ifCreate release];
    [TVfileName release];
    [tvPicfileName release];
    [super dealloc];
}

@end
