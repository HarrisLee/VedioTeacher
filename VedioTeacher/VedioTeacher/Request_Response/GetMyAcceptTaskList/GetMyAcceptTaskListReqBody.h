//
//  GetMyAcceptTaskListReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface GetMyAcceptTaskListReqBody : ReqBody
{
    NSString *startTime;
    NSString *endTime;
    NSString *accountId;
}
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *accountId;
@end
