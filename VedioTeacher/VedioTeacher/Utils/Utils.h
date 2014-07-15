//
//  Utils.h
//  Hey!XuanWu
//
//  Created by xuchuanyong on 11/26/12.
//  Copyright (c) 2012 q mm. All rights reserved.
//
//工具类，常用方法定义
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Security/Security.h>

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C extern
#endif

// 安装结果
typedef enum
{
	InstallResultOK = 0,				// 安装成功
	InstallResultFail = -1,				// 安装失败
	InstallResultNoFunction = 0xBEFC,	// 私有 API 未找到
	InstallResultFileNotFound = 0xBFEC,	// 拷贝 IPA 错误
}
InstallResult;

#define usualFormat  @"yyyy-MM-dd HH:mm:ss"

@interface Utils : NSObject

+ (NSMutableDictionary*)getPropertyWithType:(Class)objClass withSuper:(BOOL)getSuper;

+ (NSMutableDictionary*)getPropertyWithType:(Class)objClass;

+ (NSMutableArray*)getClassProperty:(Class)objClass withSuper:(BOOL)getSuper;

//获取类的属性列表
+ (NSMutableArray*)getClassProperty:(Class)objClass;

//获取对象的属性列表
+ (NSMutableArray*)getPropertyArray:(id)obj;

//获取类的属性与值的字典
+ (NSMutableDictionary*)getPropertyDic:(id)obj;

//将字典转换为json字符串
+ (NSString*)getStringFromDic:(NSDictionary*)dic;

+ (NSString*)getJsonFromObj:(id)obj;

//根据字典对对象设值
+ (void)setProperty:(id)obj withDic:(NSDictionary*)dic;

//获取已安装的应用信息
+ (NSDictionary*)getInstalledApps;

//根据ipa包的路径安装应用
+ (InstallResult)installAppWithPath:(NSString*)fromPath;

+ (BOOL)isFileExists:(NSString*)filePath;
+ (void)copyFiletoDst:(NSString*)fileName withFolder:(NSString*)folder;
+ (NSString*)getSrcFilePath:(NSString *)fileName;
+ (NSString*)getDstFilePath:(NSString *)fileName withFolder:(NSString*)folder;

//获取plist文件的应用程序路径
+ (NSString *)getSrcPlistPath:(NSString *)fileName;

//获取plist文件的沙盒路径
+ (NSString *)getDstPlistPath:(NSString *)fileName;

//将plist文件从应用程序拷贝到沙盒
+ (void)copyPlistToDst:(NSString *)fileName;

//获取某个文件的路径
+ (NSString *)documentsPath:(NSString *)fileName;

//在屏幕上显示消息
+ (void)ShowMessage:(NSString *)text onView:(UIView *)view withTime:(NSUInteger)duration;

+ (float)getSystemVersion;

+ (NSString*)stringWithDate:(NSDate*)date andFormat:(NSString*)dateFormat;

+ (NSDate*)dateWithString:(NSString*)dateStr andFormat:(NSString*)dateFormat;

+ (NSString*) dateFromTimeInterval:(NSString *)dateInterval withFormat:(NSString *)format;

//计算某一天与今天的时间天数
+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format;

+ (NSString *) getWeekDay:(NSString *) week;

//在状态栏显示信息
+ (void)ShowMessage:(NSString *)text onStatusWithTime:(NSTimeInterval)duration;

//显示类似安卓的小的提示效果
+ (void)ShowMessageInView:(NSString *)text onWindowWithTime:(NSTimeInterval)duration;

+ (void)showToast:(NSString *)text duration:(NSInteger) duration;

+ (void)showToast:(NSString *)text duration:(NSInteger) duration upKeyBoard:(BOOL)isUp;

@end

#import <CommonCrypto/CommonDigest.h>

@interface NSString (extend)
- (NSString *) trimming;
//md5加密
-(NSString *) md5HexDigest;
- (NSString *)urlEncodedString;
- (NSString *)urlDecodedString;
- (NSString *)stringByDecodingXMLEntities;
- (NSString *)stringRemoveWhiteAndEnter;
+ (NSData*) base64Decode:(NSString *)string;
+ (NSString*) base64Encode:(NSData *)data;
+ (NSString*) lationEncode:(NSString*)string;
@end

