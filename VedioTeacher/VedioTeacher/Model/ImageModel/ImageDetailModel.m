//
//  ImageDetailModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ImageDetailModel.h"

@implementation ImageDetailModel
@synthesize idImg;
@synthesize nameImg;
@synthesize fileImgName;
@synthesize describeImg;
@synthesize addAccountId;
@synthesize addTime;
@synthesize accountName;
@synthesize goodCount;

-(void) dealloc
{
    [idImg release];
    [nameImg release];
    [fileImgName release];
    [describeImg release];
    [addAccountId release];
    [addTime release];
    [accountName release];
    [goodCount release];
    [super dealloc];
}

@end
