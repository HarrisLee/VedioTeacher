//
//  GetJobRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetJobRespBody : RespBody
{
    NSMutableArray *jobArray;
}
@property (nonatomic, retain) NSMutableArray *jobArray;
@end
