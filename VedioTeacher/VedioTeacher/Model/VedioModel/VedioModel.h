//
//  VedioModel.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VedioModel : NSObject
{
    NSString *idTV;
    NSString *nameTV;
    NSString *virtualPath;
    NSString *tvPicVirtualPath;
    NSString *fileImgName;
    NSString *goodCount;
    NSString *describeTV;
    NSString *addAccountId;
    NSString *addTime;
    NSString *accountName;
}
@property (nonatomic, retain) NSString *idTV;
@property (nonatomic, retain) NSString *nameTV;
@property (nonatomic, retain) NSString *virtualPath;
@property (nonatomic, retain) NSString *tvPicVirtualPath;
@property (nonatomic, retain) NSString *fileImgName;
@property (nonatomic, retain) NSString *goodCount;
@property (nonatomic, retain) NSString *describeTV;
@property (nonatomic, retain) NSString *addAccountId;
@property (nonatomic, retain) NSString *addTime;
@property (nonatomic, retain) NSString *accountName;
@end
