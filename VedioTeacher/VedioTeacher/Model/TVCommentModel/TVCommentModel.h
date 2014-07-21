//
//  TVCommentModel.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVCommentModel : NSObject
{
    NSString *Id;
    NSString *idTV;
    NSString *comment;
    NSString *commentAccountId;
    NSString *addTime;
    NSString *accountName;
}
@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) NSString *idTV;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *commentAccountId;
@property (nonatomic, retain) NSString *addTime;
@property (nonatomic, retain) NSString *accountName;
@end
