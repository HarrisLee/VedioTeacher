//
//  GetPeopleOpinionReturnRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface GetPeopleOpinionReturnRespBody : RespBody
{
    NSMutableArray *optinReturnArray;
}
@property (nonatomic, retain) NSMutableArray *optinReturnArray;
@end
