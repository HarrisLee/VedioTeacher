//
//  JobModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "JobModel.h"

@implementation JobModel
@synthesize id = _id;
@synthesize jobName,isDel;

-(void) dealloc
{
    [_id release];
    [jobName release];
    [isDel release];
    [super dealloc];
}
@end
