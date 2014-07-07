//
//  AFHttpRequestUtils.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqBody.h"
#import "RespBody.h"

#define SPACE_URL  @"http://202.119.101.46/GS/TVWebService.asmx"

@interface AFHttpRequestUtils : NSObject
{
    NSDictionary        *urlDic;           //保存url字典
    NSDictionary        *respNameDic;      //返回类名字典
    NSDictionary        *errorCodeDic;     //错误码字典
    NSString            *baseUrl;
}
+(AFHttpRequestUtils*)shareInstance;

-(NSMutableURLRequest *)requestWithBody:(ReqBody*)reqBody andReqType:(NSString*)reqType;

-(RespBody *) jsonConvertObject:(NSData *)jsonData withReqType:(NSString *)reqType;

@end
