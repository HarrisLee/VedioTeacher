//
//  DataCenter.h
//  Hey!XuanWu
//
//  Created by xuchuanyong on 11/22/12.
//  Copyright (c) 2012 q mm. All rights reserved.
//

//数据中心，用于保存一些整个应用全局的标志或者数据
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserModel.h"

@interface DataCenter : NSObject <UIAlertViewDelegate>{
    BOOL                    isLogined;              //是否登录
    NSDictionary            *configDictionary;      //配置字典
    NSDictionary            *errorDictionary;       //错误码字典
    UserModel               *userInfo;
    BOOL                    isOpen;
    BOOL                    isOutLogin;              //是否是外部账号登录
    NSString                *outLoginName;
    NSString                *outLoginId;
    NSString                *loginName;
    NSString                *loginId;
}
@property                    BOOL                   isOpen;
@property                    BOOL                   isLogined;
@property                    BOOL                   isShare;
@property                    BOOL                   isOutLogin;
@property (nonatomic,retain) UserModel              *userInfo;
@property (nonatomic,retain) NSDictionary           *configDictionary;
@property (nonatomic,retain) NSDictionary           *errorDictionary;
@property (nonatomic,retain) NSString               *outLoginName;
@property (nonatomic,retain) NSString               *outLoginId;
@property (nonatomic,retain) NSString               *loginName;
@property (nonatomic,retain) NSString               *loginId;

+(DataCenter*)shareInstance;
+ (NSString*)saveImageFile:(UIImage*)image;


/*
- (void)initShareSDK;

- (void)shareContent:(id)content withSender:(id)sender;
- (void)shareContent:(NSString*)content title:(NSString*)title url:(NSString*)url image:(NSString*)imageUrl withSender:(id)sender;
 */
@end
