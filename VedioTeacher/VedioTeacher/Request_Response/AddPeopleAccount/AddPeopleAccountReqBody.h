//
//  AddPeopleAccountReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddPeopleAccountReqBody : ReqBody
{
    NSString *PeopleName;//外部账号的名称
    NSString *PeopleMobileNo;//外部账号的手机号（ 也就是登录密码）
}
@property (nonatomic, retain) NSString *PeopleName;
@property (nonatomic, retain) NSString *PeopleMobileNo;
@end
