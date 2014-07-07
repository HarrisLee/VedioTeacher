//
//  GetMainInfoRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetMainInfoRespBody : RespBody
{
    NSString *workInfo;//工作信息
    NSString *addAccountId;//添加该条记录的内部账号id
    NSString *addTime;//添加该条记录的时间
    NSString *iosDownLoadAddress;//该应用ios客户端的下载url
    NSString *androidDownLoadAddress;//该应用android客户端的下载url
    NSString *winceDownLoadAddress;//该应用wince客户端的下载url
    NSString *isDel;//是否删除 0表示已经删除  1表示未删除
    NSString *webSite;
}
@property(nonatomic, retain)NSString *workInfo;
@property(nonatomic, retain)NSString *addAccountId;
@property(nonatomic, retain)NSString *addTime;
@property(nonatomic, retain)NSString *iosDownLoadAddress;
@property(nonatomic, retain)NSString *androidDownLoadAddress;
@property(nonatomic, retain)NSString *winceDownLoadAddress;
@property(nonatomic, retain)NSString *isDel;
@property(nonatomic, retain)NSString *webSite;
@end
