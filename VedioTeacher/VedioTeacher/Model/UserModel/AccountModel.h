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
    NSString *idAccoun;
    NSString *accountName;
    NSString *accountPassword;
    NSString *peopleName;
}
@property (nonatomic, retain) NSString *idAccoun;
@property (nonatomic, retain) NSString *accountName;
@property (nonatomic, retain) NSString *accountPassword;
@property (nonatomic, retain) NSString *peopleName;
@end
