//
//  ImageModel.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
{
    NSString *idImg;//图片ID
    NSString *nameImg;//图片名称
    NSString *virtualPath;//图片URL
    NSString *fileImgName;//图片物理名称
    NSString *goodCount;//图片点赞数
}
@property (nonatomic, retain) NSString *idImg;
@property (nonatomic, retain) NSString *nameImg;
@property (nonatomic, retain) NSString *virtualPath;
@property (nonatomic, retain) NSString *fileImgName;
@property (nonatomic, retain) NSString *goodCount;
@end
