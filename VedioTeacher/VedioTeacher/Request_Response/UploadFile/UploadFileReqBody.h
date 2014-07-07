//
//  UploadFileReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface UploadFileReqBody : ReqBody
{
    NSString   *fs;
    NSString *idSecondDirectory;//该图片所属的二级目录的id
    NSString *nameImg;//该图片的显示名称（不是服务器存储该照片的物理文件名，物理文件名是服务器自动创建的。）；
    NSString *describeImg;//该图片的描述，
    NSString *addAccountId;//上传该图片的账号id
}
@property (nonatomic, retain) NSString *fs;
@property (nonatomic, retain) NSString *idSecondDirectory;
@property (nonatomic, retain) NSString *nameImg;
@property (nonatomic, retain) NSString *describeImg;
@property (nonatomic, retain) NSString *addAccountId;
@end
