//
//  AddPeopleOpinionReturnReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddPeopleOpinionReturnReqBody : ReqBody
{
    NSString *peopleOpinionId;//回复针对的意见的id
    NSString *returnOpinion;//回复内容
    NSString *accountId;//回复人内部账号id
}
@property (nonatomic, retain) NSString *peopleOpinionId;
@property (nonatomic, retain) NSString *returnOpinion;
@property (nonatomic, retain) NSString *accountId;
@end
