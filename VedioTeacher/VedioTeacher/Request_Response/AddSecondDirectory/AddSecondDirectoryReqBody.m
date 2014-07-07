//
//  AddSecondDirectoryReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddSecondDirectoryReqBody.h"

@implementation AddSecondDirectoryReqBody
@synthesize idTopDirectory;
@synthesize nameSecondDirectory;
@synthesize addAccountId;

-(void) dealloc
{
    [idTopDirectory release];
    [nameSecondDirectory release];
    [addAccountId release];
    [super dealloc];
}

@end
