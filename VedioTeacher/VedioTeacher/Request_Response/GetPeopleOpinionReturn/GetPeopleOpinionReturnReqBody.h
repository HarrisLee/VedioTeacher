//
//  GetPeopleOpinionReturnReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface GetPeopleOpinionReturnReqBody : ReqBody
{
    NSString *peopleOpinionId;//意见id
}
@property (nonatomic, retain) NSString *peopleOpinionId;
@end
