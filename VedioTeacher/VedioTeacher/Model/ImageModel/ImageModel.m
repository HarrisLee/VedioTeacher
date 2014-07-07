//
//  ImageModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
@synthesize idImg;
@synthesize nameImg;
@synthesize virtualPath;
@synthesize fileImgName;
@synthesize goodCount;

-(void) dealloc
{
    [idImg release];
    [nameImg release];
    [virtualPath release];
    [fileImgName release];
    [goodCount release];
    [super dealloc];
}

@end
