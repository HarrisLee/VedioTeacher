//
//  GetImgListReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface GetImgListReqBody : ReqBody
{
    NSString *idSecondDirectory;//二级目录的id号
}
@property (nonatomic, retain) NSString *idSecondDirectory;
@end
