//
//  UploadTVFileReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface UploadTVFileReqBody : ReqBody
{
    NSString   *fs;
    NSString *idSecondDirectory;//该图片所属的二级目录的id
    NSString *nameTV;//该图片的显示名称（不是服务器存储该照片的物理文件名，物理文件名是服务器自动创建的。）；
    NSString *describeTV;//该图片的描述，
    NSString *addAccountId;//上传该图片的账号id
    NSString *idTask;
}
@property (nonatomic, retain) NSString *fs;
@property (nonatomic, retain) NSString *idSecondDirectory;
@property (nonatomic, retain) NSString *nameTV;
@property (nonatomic, retain) NSString *describeTV;
@property (nonatomic, retain) NSString *addAccountId;
@property (nonatomic, retain) NSString *idTask;
@end
