//
//  AddCommentReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddCommentReqBody : ReqBody
{
    NSString *imgId;//照片id
    NSString *accountId;//账号id
    NSString *commentNote;//评论内容
}
@property (nonatomic, retain) NSString *imgId;
@property (nonatomic, retain) NSString *accountId;
@property (nonatomic, retain) NSString *commentNote;
@end
