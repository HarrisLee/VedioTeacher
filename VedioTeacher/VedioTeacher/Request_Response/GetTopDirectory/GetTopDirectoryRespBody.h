//
//  GetTopDirectoryRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetTopDirectoryRespBody : RespBody
{
    NSMutableArray *topDirectoryArray;
}
@property (nonatomic, retain) NSMutableArray *topDirectoryArray;
@end
