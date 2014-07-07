//
//  FDirectoryModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "FDirectoryModel.h"

@implementation FDirectoryModel
@synthesize idTopDirectory;
@synthesize nameTopDirectory;
@synthesize addTime;
@synthesize addAccountId;
@synthesize isDel;

-(void) dealloc
{
    [idTopDirectory release];
    [nameTopDirectory release];
    [addTime release];
    [addAccountId release];
    [isDel release];
    [super dealloc];
}

@end
