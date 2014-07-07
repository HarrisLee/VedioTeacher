//
//  RespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespBody : NSObject
{
    NSString *message;
    NSString *errorCode;
}
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *errorCode;

-(void) setValue:(id)value;

@end
