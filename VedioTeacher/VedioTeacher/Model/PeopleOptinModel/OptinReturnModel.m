//
//  OptinReturnModel.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "OptinReturnModel.h"

@implementation OptinReturnModel
@synthesize Id = _Id;
@synthesize peopleOpinionId,returnOpinion,addtime,AccountId,accountName,isDel;

-(void) dealloc
{
    [_Id release];
    [peopleOpinionId release];
    [returnOpinion release];
    [addtime release];
    [accountName release];
    [AccountId release];
    [isDel release];
    [super dealloc];
}

@end
