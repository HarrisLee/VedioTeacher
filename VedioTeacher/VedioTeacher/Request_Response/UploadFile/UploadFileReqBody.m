//
//  UploadFileReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "UploadFileReqBody.h"

@implementation UploadFileReqBody
@synthesize fs;
@synthesize idSecondDirectory;
@synthesize addAccountId;
@synthesize describeImg;
@synthesize nameImg;

-(void) dealloc
{
    [fs release];
    [idSecondDirectory release];
    [addAccountId release];
    [describeImg release];
    [nameImg release];
    [super dealloc];
}

@end
