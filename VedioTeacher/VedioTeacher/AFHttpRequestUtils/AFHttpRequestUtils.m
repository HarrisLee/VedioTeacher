//
//  AFHttpRequestUtils.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AFHttpRequestUtils.h"
#import "TBXML.h"

static AFHttpRequestUtils *m_RequestCenter = nil;

@implementation AFHttpRequestUtils

+(AFHttpRequestUtils*)shareInstance {
    @synchronized(self)
	{
		if (m_RequestCenter == nil)
		{
			m_RequestCenter = [[AFHttpRequestUtils alloc] init];
		}
	}
	
	return m_RequestCenter;
}

- (id)init {
    self = [super init];
    if (self) {
        //初始化请求url字典
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ReqUrlDefine" ofType:@"plist"];
        urlDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        //初始化返回结构体名称字典，不同请求类型对应的结构体名称
        plistPath = [[NSBundle mainBundle] pathForResource:@"RespNameDefine" ofType:@"plist"];
        respNameDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        plistPath = [[NSBundle mainBundle] pathForResource:@"ErrorCode" ofType:@"plist"];
        errorCodeDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        if (![Utils isFileExists:[Utils documentsPath:@"Config.plist"]]) {
            [Utils copyPlistToDst:@"Config"];
        }
        
        NSMutableDictionary *configPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:[Utils documentsPath:@"Config.plist"]] mutableCopy];
        
        baseUrl = [configPlist objectForKey:@"service"];
        
    }
    return self;
}


-(NSMutableURLRequest *)requestWithBody:(ReqBody*)reqBody andReqType:(NSString*)reqType
{
    NSDictionary *parameterDic = [Utils getPropertyDic:reqBody];
    
    NSString *soapMethod = [urlDic objectForKey:reqType];
    
    NSString *soapMessage = [self appendSoapBody:parameterDic withMethod:soapMethod];
    
    NSURL *theURL = [NSURL URLWithString:baseUrl];

    NSString *soapLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:theURL];
    
    [urlRequest setValue:urlRequest.URL.host
                  forHTTPHeaderField:@"Host"];
    [urlRequest setValue:@"application/soap+xml; charset=utf-8"
                  forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:soapLength
                  forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:[NSString stringWithFormat:@"%@",soapMethod]
                  forHTTPHeaderField:@"SOAPAction"];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    [urlRequest setTimeoutInterval:2];
    
    return urlRequest;
}

/**
 *  soap请求体拼接
 *
 *  @param soapDic 请求的request体
 *  @param method  请求的方法
 *
 *  @return 返回soap请求体
 */
-(NSString *) appendSoapBody:(NSDictionary *)soapDic withMethod:(NSString *)method
{
    NSString *parameter = @"";
    for (NSString *key in [soapDic allKeys]) {
        parameter = [parameter stringByAppendingFormat:[NSString stringWithFormat:@"<%@>%@</%@>\n",key,[soapDic objectForKey:key],key],nil];
    }
    
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> \n"
    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
    "<soap12:Body>\n"
    "<%@ xmlns=\"http://tempuri.org/\">\n"
    "%@"
    "</%@>\n"
    "</soap12:Body>\n"
    "</soap12:Envelope>\n",method,parameter,method];
    
    NSLog(@"%@",soapMessage);
    
    return soapMessage;
}

-(RespBody *) jsonConvertObject:(NSData *)jsonData withReqType:(NSString *)reqType
{
    NSString *respName = [respNameDic objectForKey:reqType];
    RespBody *respBody = [[[NSClassFromString(respName) alloc] init] autorelease];

    NSError *error = nil;
    
    TBXML *tbxml = [[TBXML alloc] initWithXMLData:jsonData error:&error];
    
    if (error) {
        NSLog(@"xmlParseError:%@",error);
        [tbxml release];
        return nil;
    }
    
    NSString *respStr = nil;
    
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) {
        TBXMLElement *body = [TBXML childElementNamed:@"soap:Body" parentElement:root];
        if (body) {
            NSString *name = [NSString stringWithFormat:@"%@Response",[urlDic objectForKey:reqType]];
            TBXMLElement *content = [TBXML childElementNamed:name parentElement:body];
            if (content) {
                NSString *childName = [NSString stringWithFormat:@"%@Result",[urlDic objectForKey:reqType]];
                TBXMLElement *response = [TBXML childElementNamed:childName parentElement:content];
                if (response) {
                    respStr = [TBXML textForElement:response];
                    NSLog(@"%@",respStr);
                }
            }
        }
    }
    
    if (!respStr) {
        return nil;
    }
    
    NSData *contentData = [respStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:contentData options:kNilOptions error:&error];
    
    if (error) {
        [respBody setValue:respStr];
        return respBody;
    }
    
    [respBody setValue:respDic];

    return respBody;
}

@end
