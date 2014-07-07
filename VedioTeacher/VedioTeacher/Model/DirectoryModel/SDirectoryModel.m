//
//  SDirectoryModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SDirectoryModel.h"

@implementation SDirectoryModel
@synthesize idSecondDirectory;
@synthesize idTopDirectory;
@synthesize nameSecondDirectory;
@synthesize addTime;
@synthesize addAccountId;
@synthesize accountName;
@synthesize FolderName;
@synthesize isDel;

-(void) dealloc
{
    [idSecondDirectory release];
    [idTopDirectory release];
    [nameSecondDirectory release];
    [addTime release];
    [addAccountId release];
    [accountName release];
    [FolderName release];
    [isDel release];
    [super dealloc];
}
@end
