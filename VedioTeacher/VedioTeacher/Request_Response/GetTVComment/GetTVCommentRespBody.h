//
//  GetTVCommentRespBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "TVCommentModel.h"

@interface GetTVCommentRespBody : RespBody
{
    NSMutableArray *commentList;
}
@property (nonatomic, retain) NSMutableArray *commentList;
@end
