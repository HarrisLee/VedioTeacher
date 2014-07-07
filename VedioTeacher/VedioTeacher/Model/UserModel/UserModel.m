//
//  UserModel.m
//  Hey!XuanWu
//
//  Created by Melo on 13-6-14.
//  Copyright (c) 2013年 Melo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize uid;          //用户ID
@synthesize uname;        //用户昵称
@synthesize password;     //用户密码
@synthesize email;        //用户邮箱
@synthesize face;         //用户头像
@synthesize money;        //用户金钱
@synthesize lasttime;     //上次登录时间
@synthesize lastip;       //上次登录IP
@synthesize jointime;     //注册时间
@synthesize joinip;       //注册IP
@synthesize checkmail;    //验证邮箱
@synthesize state;        //状态
@synthesize fans;         //粉丝
@synthesize look;         //
@synthesize articles;     //发表文章数
@synthesize comments;     //回复数

-(void) dealloc {
    [uid release];
    [uname release];
    [password release];
    [email release];
    [face release];
    [money release];
    [lasttime release];
    [lastip release];
    [jointime release];
    [joinip release];
    [checkmail release];
    [state release];
    [fans release];
    [look release];
    [articles release];
    [comments release];
    [super dealloc];
}

@end
