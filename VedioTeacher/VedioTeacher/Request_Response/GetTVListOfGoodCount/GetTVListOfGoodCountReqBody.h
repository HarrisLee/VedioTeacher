//
//  GetTVListOfGoodCountReqBody.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ReqBody.h"

@interface GetTVListOfGoodCountReqBody : ReqBody
{
    NSString *idSecondDirectory;
}
@property (nonatomic, retain) NSString *idSecondDirectory;
@end
