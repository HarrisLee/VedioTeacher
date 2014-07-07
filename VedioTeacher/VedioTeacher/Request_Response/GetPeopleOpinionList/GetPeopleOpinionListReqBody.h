//
//  GetPeopleOpinionListReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface GetPeopleOpinionListReqBody : ReqBody
{
    NSString *startTime;//开始时间
    NSString *endTime;//结束时间
}
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@end
