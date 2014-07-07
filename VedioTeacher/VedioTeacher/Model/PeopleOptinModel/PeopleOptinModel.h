//
//  PeopleOptinModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleOptinModel : NSObject
{
    NSString *_id;//意见id
    NSString *opinionNote;//意见内容
    NSString *PeopleId;//提意见的外部账号id
    NSString *PeopleName;//提意见的外部账号名称
    NSString *addTime;//提意见的时间
    NSString *addIpAddress;//提意见设备ip地址
    NSString *isDel;//是否删除
}
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *opinionNote;
@property (nonatomic, retain) NSString *PeopleId;
@property (nonatomic, retain) NSString *PeopleName;
@property (nonatomic, retain) NSString *addTime;
@property (nonatomic, retain) NSString *addIpAddress;
@property (nonatomic, retain) NSString *isDel;
@end
