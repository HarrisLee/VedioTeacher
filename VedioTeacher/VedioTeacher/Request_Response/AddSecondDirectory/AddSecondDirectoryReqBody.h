//
//  AddSecondDirectoryReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddSecondDirectoryReqBody : ReqBody
{
    NSString *idTopDirectory;//一级目录id
    NSString *nameSecondDirectory;//二级活动目录的名称
    NSString *addAccountId;//新建二级目录的账号id
}
@property (nonatomic, retain) NSString *idTopDirectory;
@property (nonatomic, retain) NSString *nameSecondDirectory;
@property (nonatomic, retain) NSString *addAccountId;
@end
