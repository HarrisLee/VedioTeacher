//
//  OptinReturnModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptinReturnModel : NSObject
{
    NSString *_Id;//意见回复id
    NSString *peopleOpinionId;//回复针对的意见的id
    NSString *returnOpinion;//回复内容
    NSString *addtime;//回复时间
    NSString *AccountId;//回复者内部账号id
    NSString *accountName;//回复者内部账号名称
    NSString *isDel;//是否删除
}
@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) NSString *peopleOpinionId;
@property (nonatomic, retain) NSString *returnOpinion;
@property (nonatomic, retain) NSString *addtime;
@property (nonatomic, retain) NSString *AccountId;
@property (nonatomic, retain) NSString *accountName;
@property (nonatomic, retain) NSString *isDel;
@end
