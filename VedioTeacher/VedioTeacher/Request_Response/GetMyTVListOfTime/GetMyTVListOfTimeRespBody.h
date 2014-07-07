//
//  GetMyTVListOfTimeRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetMyTVListOfTimeRespBody : RespBody
{
    NSMutableArray *tvList;
}
@property (nonatomic, retain) NSMutableArray *tvList;
@end
