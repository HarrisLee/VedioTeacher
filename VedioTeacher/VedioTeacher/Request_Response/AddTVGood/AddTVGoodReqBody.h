//
//  AddTVGoodReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface AddTVGoodReqBody : ReqBody
{
    NSString *TVId;
    NSString *AccountId;
}
@property (nonatomic, retain) NSString *TVId;
@property (nonatomic, retain) NSString *AccountId;
@end
