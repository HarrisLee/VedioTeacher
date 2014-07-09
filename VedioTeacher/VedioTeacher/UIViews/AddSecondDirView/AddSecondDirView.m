//
//  AddSecondDirView.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-9.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddSecondDirView.h"

@implementation AddSecondDirView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
