//
//  ImageCommentModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCommentModel : NSObject
{
    NSString *_Id;//评论id
    NSString *idImg;//照片id
    NSString *comment;//评论内容
    NSString *commentAccountId;//评论人id
    NSString *addtime;//评论时间
    NSString *accountName;//评论人账号名称
}
@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) NSString *idImg;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *commentAccountId;
@property (nonatomic, retain) NSString *addtime;
@property (nonatomic, retain) NSString *accountName;
@end
