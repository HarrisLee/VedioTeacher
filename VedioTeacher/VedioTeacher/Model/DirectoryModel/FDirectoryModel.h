//
//  FDirectoryModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDirectoryModel : NSObject
{
    NSString *idTopDirectory;//一级目录的id
    NSString *nameTopDirectory;//一级目录的名称
    NSString *addTime;//一级目录新建时间
    NSString *addAccountId;//新建一级目录的内部账号id
    NSString *isDel;//是否删除 0表示已经删除  1表示未删除
}
@property(nonatomic, retain)NSString *idTopDirectory;
@property(nonatomic, retain)NSString *nameTopDirectory;
@property(nonatomic, retain)NSString *addTime;
@property(nonatomic, retain)NSString *addAccountId;
@property(nonatomic, retain)NSString *isDel;
@end
