//
//  SDirectoryModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDirectoryModel : NSObject
{
    NSString *idSecondDirectory;//二级目录id
    NSString *idTopDirectory;//一级目录的id
    NSString *nameSecondDirectory;//二级目录的名称
    NSString *addTime;//二级目录新建时间
    NSString *addAccountId;//二级级目录创建人id
    NSString *FolderName;//二级目录物理文件夹名称
    NSString *accountName;//添加二级目录的账户名
    NSString *isDel;//是否删除 0表示已经删除  1表示未删除
    
}
@property(nonatomic, retain)NSString *idSecondDirectory;
@property(nonatomic, retain)NSString *idTopDirectory;
@property(nonatomic, retain)NSString *nameSecondDirectory;
@property(nonatomic, retain)NSString *addTime;
@property(nonatomic, retain)NSString *addAccountId;
@property(nonatomic, retain)NSString *FolderName;
@property(nonatomic, retain)NSString *accountName;
@property(nonatomic, retain)NSString *isDel;
@end
