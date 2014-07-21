//
//  AcceptTaskReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AcceptTaskReqBody : ReqBody
{
    NSString *taskId;
    NSString *accountid;
}
@property (nonatomic, retain) NSString *taskId;
@property (nonatomic, retain) NSString *accountid;
@end
