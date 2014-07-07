//
//  AddGoodReqBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddGoodReqBody : ReqBody
{
    NSString *imgId;//照片id
    NSString *AccountId;//账号id
}
@property (nonatomic, retain) NSString *imgId;
@property (nonatomic, retain) NSString *AccountId;
@end
