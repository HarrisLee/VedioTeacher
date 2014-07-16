//
//  GetSecondDirectoryRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "SDirectoryModel.h"

@interface GetSecondDirectoryRespBody : RespBody
{
    NSMutableArray *sDirectoryArray;
}
@property (nonatomic, retain) NSMutableArray *sDirectoryArray;
@end
