//
//  GetSecondDirectoryOfTimeRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetSecondDirectoryOfTimeRespBody : RespBody
{
    NSMutableArray *searchArray;
}
@property (nonatomic, retain) NSMutableArray *searchArray;
@end
