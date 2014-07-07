//
//  ImageDetailModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDetailModel : NSObject
{
    NSString *idImg;//照片id
    NSString *nameImg;//照片名
    NSString *fileImgName;//照片物理路径文件名
    NSString *describeImg;//照片描述
    NSString *addAccountId;//照片添加人账号id
    NSString *addTime;//照片添加时间
    NSString *accountName;//照片添加人账户名
    NSString *goodCount;//该照片的点赞数
}
@property (nonatomic, retain) NSString *idImg;
@property (nonatomic, retain) NSString *nameImg;
@property (nonatomic, retain) NSString *fileImgName;
@property (nonatomic, retain) NSString *describeImg;
@property (nonatomic, retain) NSString *addAccountId;
@property (nonatomic, retain) NSString *addTime;
@property (nonatomic, retain) NSString *accountName;
@property (nonatomic, retain) NSString *goodCount;
@end
