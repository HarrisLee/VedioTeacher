//
//  JobModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobModel : NSObject
{
    NSString *_id;//意见回复id
    NSString *jobName;//回复针对的意见的id
    NSString *isDel;//回复内容
}
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *jobName;
@property (nonatomic, retain) NSString *isDel;
@end
