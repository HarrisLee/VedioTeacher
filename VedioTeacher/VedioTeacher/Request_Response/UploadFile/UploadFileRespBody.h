//
//  UploadFileRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"

@interface UploadFileRespBody : RespBody
{
    NSString *result;
    NSInteger index;
}
@property (nonatomic, retain) NSString *result;
@property (nonatomic, assign) NSInteger index;
@end
