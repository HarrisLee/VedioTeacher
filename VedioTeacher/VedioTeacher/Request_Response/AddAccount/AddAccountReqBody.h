//
//  AddAccountReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddAccountReqBody : ReqBody
{
    NSString *accountName;//注册的名称
    NSString *accountPassword;//注册的密码
    NSString *peopleName;//注册人的真实姓名
    NSString *peopleJob;//注册人的工作单位
    NSString *peopleMobileNo;//注册人的手机号码
}
@property (nonatomic, retain) NSString *accountName;
@property (nonatomic, retain) NSString *accountPassword;
@property (nonatomic, retain) NSString *peopleName;
@property (nonatomic, retain) NSString *peopleJob;
@property (nonatomic, retain) NSString *peopleMobileNo;
@end
