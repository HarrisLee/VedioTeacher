//
//  GetTVOfSearchRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "VedioModel.h"

@interface GetTVOfSearchRespBody : RespBody
{
    NSMutableArray *tvList;
}
@property (nonatomic, retain) NSMutableArray *tvList;
@end
