//
//  UserModel.h
//  Hey!XuanWu
//
//  Created by Melo on 13-6-14.
//  Copyright (c) 2013年 Melo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject {
    NSString *uid;          //用户ID
    NSString *uname;        //用户昵称
    NSString *password;     //用户密码
    NSString *email;        //用户邮箱
    NSString *face;         //用户头像
    NSString *money;        //用户金钱
    NSString *lasttime;     //上次登录时间
    NSString *lastip;       //上次登录IP
    NSString *jointime;     //注册时间
    NSString *joinip;       //注册IP
    NSString *checkmail;    //验证邮箱
    NSString *state;        //状态
    NSString *fans;         //粉丝
    NSString *look;         //
    NSString *articles;     //发表文章数
    NSString *comments;     //回复数
}
@property (retain, nonatomic) NSString *uid;          //用户ID
@property (retain, nonatomic) NSString *uname;        //用户昵称
@property (retain, nonatomic) NSString *password;     //用户密码
@property (retain, nonatomic) NSString *email;        //用户邮箱
@property (retain, nonatomic) NSString *face;         //用户头像
@property (retain, nonatomic) NSString *money;        //用户金钱
@property (retain, nonatomic) NSString *lasttime;     //上次登录时间
@property (retain, nonatomic) NSString *lastip;       //上次登录IP
@property (retain, nonatomic) NSString *jointime;     //注册时间
@property (retain, nonatomic) NSString *joinip;       //注册IP
@property (retain, nonatomic) NSString *checkmail;    //验证邮箱
@property (retain, nonatomic) NSString *state;        //状态
@property (retain, nonatomic) NSString *fans;         //粉丝
@property (retain, nonatomic) NSString *look;         //
@property (retain, nonatomic) NSString *articles;     //发表文章数
@property (retain, nonatomic) NSString *comments;     //回复数

@end
