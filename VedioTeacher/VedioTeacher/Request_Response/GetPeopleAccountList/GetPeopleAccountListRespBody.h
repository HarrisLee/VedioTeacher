//
//  GetPeopleAccountListRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetPeopleAccountListRespBody : RespBody
{
    NSMutableArray *peopleList;
}
@property (nonatomic, retain) NSMutableArray *peopleList;
@end
