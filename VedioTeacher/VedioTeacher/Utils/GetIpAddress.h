//
//  GetIpAddress.h
//  Hey!XuanWu
//
//  Created by 曹建荣 on 14-3-9.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetIpAddress : NSObject

#define MAXADDRS    32

extern char *ip_names[MAXADDRS];

void InitAddresses();
+(void) GetIPAddresses;
+(void) GetHWAddresses;

@end
