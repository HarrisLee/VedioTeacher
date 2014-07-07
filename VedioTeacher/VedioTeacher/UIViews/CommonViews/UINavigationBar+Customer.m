//
//  UINavigationBar+Customer.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 13-12-2.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "UINavigationBar+Customer.h"

@implementation UINavigationBar (Customer)

-(void) drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@""];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, 440.f)];
}

-(void) loadNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:rgbaColor(118, 4, 112, 1.0)];
}

@end
