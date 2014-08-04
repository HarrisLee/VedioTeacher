//
//  GetTVInfoRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetTVInfoRespBody : RespBody
{
    NSMutableDictionary *info;
}
@property (nonatomic, retain) NSMutableDictionary *info;
@end
