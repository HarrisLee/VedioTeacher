//
//  AddTVCommentReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddTVCommentReqBody : ReqBody
{
    NSString *TVId;
    NSString *commentNote;
    NSString *accountId;
}
@property (nonatomic, retain) NSString *TVId;
@property (nonatomic, retain) NSString *commentNote;
@property (nonatomic, retain) NSString *accountId;
@end
