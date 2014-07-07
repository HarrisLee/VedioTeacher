//
//  AddPeopleOpinionReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddPeopleOpinionReqBody : ReqBody
{
    NSString *opinionNote;//意见内容
    NSString *PeopleId;//提交意见外部账号id
    NSString *addIpAddress;//提交设备的ip地址
}
@property (nonatomic, retain) NSString *opinionNote;
@property (nonatomic, retain) NSString *PeopleId;
@property (nonatomic, retain) NSString *addIpAddress;
@end
