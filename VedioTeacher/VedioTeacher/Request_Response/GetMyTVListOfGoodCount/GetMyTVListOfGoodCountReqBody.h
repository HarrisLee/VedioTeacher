//
//  GetMyTVListOfGoodCountReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface GetMyTVListOfGoodCountReqBody : ReqBody
{
    NSString *accountId;
}
@property (nonatomic, retain) NSString *accountId;
@end
