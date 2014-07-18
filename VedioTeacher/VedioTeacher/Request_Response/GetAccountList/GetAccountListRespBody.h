//
//  GetAccountListRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "AccountModel.h"

@interface GetAccountListRespBody : RespBody
{
    NSMutableArray *accountListResult;
}
@property (nonatomic, retain) NSMutableArray *accountListResult;
@end
