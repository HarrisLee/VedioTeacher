//
//  AccountModel.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject
{
    NSString *userId;
    NSString *loginname;
    NSString *passowrd;
    NSString *userName;
}
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *loginname;
@property (nonatomic, retain) NSString *passowrd;
@property (nonatomic, retain) NSString *userName;
@end
