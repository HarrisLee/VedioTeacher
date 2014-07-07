//
//  GetMainInfoRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "GetMainInfoRespBody.h"

@implementation GetMainInfoRespBody
@synthesize workInfo;
@synthesize addAccountId;
@synthesize addTime;
@synthesize iosDownLoadAddress;
@synthesize androidDownLoadAddress;
@synthesize winceDownLoadAddress;
@synthesize isDel;
@synthesize webSite;

-(void) setValue:(id)value
{
    self.workInfo = [[value objectAtIndex:0] objectForKey:@"workInfo"];
    self.addAccountId = [[value objectAtIndex:0] objectForKey:@"addAccountId"];
    self.addTime = [[value objectAtIndex:0] objectForKey:@"addTime"];
    self.iosDownLoadAddress = [[value objectAtIndex:0] objectForKey:@"iosDownLoadAddress"];
    self.androidDownLoadAddress = [[value objectAtIndex:0] objectForKey:@"androidDownLoadAddress"];
    self.winceDownLoadAddress = [[value objectAtIndex:0] objectForKey:@"winceDownLoadAddress"];
    self.isDel = [[value objectAtIndex:0] objectForKey:@"isDel"];
    self.webSite = [[value objectAtIndex:0] objectForKey:@"webSite"];
}

-(void) dealloc
{
    [workInfo release];
    [addAccountId release];
    [addTime release];
    [iosDownLoadAddress release];
    [androidDownLoadAddress release];
    [winceDownLoadAddress release];
    [isDel release];
    [webSite release];
    [super dealloc];
}

@end
