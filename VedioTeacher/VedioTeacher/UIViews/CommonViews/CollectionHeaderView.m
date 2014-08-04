//
//  CollectionHeaderView.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1004, 50)];
        label.text = @"搜索结果";
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20.0f];
        [label setHidden:YES];
        [self addSubview:label];
        [label release];
        
        headerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1004, 50)];
        [self addSubview:headerScroll];
        [headerScroll release];
    }
    return self;
}

-(void) setHeaderDataView:(NSArray *)headerArray  index:(NSInteger)index
{
    [[headerScroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [headerScroll setContentSize:CGSizeMake(1004, 50)];
    
    buttonCount = [headerArray count];
    
    if (!headerArray && buttonCount == 0) {
        return ;
    }
    
    for (int i = 0; i < buttonCount; i++) {
        SDirectoryModel *model = [headerArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 4.0f;
        button.frame = CGRectMake(5+100*i, 10, 100, 30);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        if (i == index) {
            button.backgroundColor = [UIColor getColor:@"3FA6FF"];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        button.tag = 5000+i;
        [button setTitle:model.nameSecondDirectory forState:UIControlStateNormal];
        [button addTarget:self action:@selector(headerClickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [headerScroll addSubview:button];
    }
 
    [headerScroll setContentSize:CGSizeMake(10+100*buttonCount,50.0f)];
}

-(void) headerClickAtIndex:(id) sender
{
    for (int i = 0; i<buttonCount; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+5000];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor getColor:@"3FA6FF"]];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerClickAtIndex:)]) {
        [self.delegate headerClickAtIndex:sender];
    }
}

-(void) setSearch:(BOOL)isSearch
{
    [headerScroll setHidden:isSearch];
    [label setHidden:!isSearch];
}

@end
