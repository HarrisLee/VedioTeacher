//
//  CollectionCell.m
//  LuxuryA4L
//
//  Created by Cao JianRong on 13-12-5.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell
@synthesize icon;
@synthesize label;
@synthesize name;
@synthesize point;
@synthesize count;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder_horizontal"]];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 35);
        self.icon = imageView;
        [self.contentView addSubview:imageView];
        [imageView release];
        
//        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 105.0, 240, 20)];
//        self.label = lb;
//        self.label.textAlignment = NSTextAlignmentRight;
//        self.label.font = [UIFont boldSystemFontOfSize:11.0];
//        self.label.backgroundColor = [UIColor brownColor];
//        self.label.textColor = [UIColor blackColor];
//        [self.contentView addSubview:self.label];
//        [lb release];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(5, imageView.frame.size.height + imageView.frame.origin.y, 230, 20)];
        lb.textColor = [UIColor blackColor];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = [UIFont systemFontOfSize:13.0f];
        self.name = lb;
        [self.contentView addSubview:lb];
        [lb release];
        
        lb = [[UILabel alloc] initWithFrame:CGRectMake(5, lb.frame.size.height + lb.frame.origin.y, 160, 15)];
        lb.textColor = [UIColor blackColor];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = [UIFont systemFontOfSize:11.0f];
        self.count = lb;
        [self.contentView addSubview:lb];
        [lb release];
        
//        lb = [[UILabel alloc] initWithFrame:CGRectMake(lb.frame.size.width + lb.frame.origin.x, lb.frame.origin.y, 70, 15)];
//        lb.textAlignment = NSTextAlignmentRight;
//        lb.textColor = [UIColor blackColor];
//        lb.backgroundColor = [UIColor clearColor];
//        lb.font = [UIFont systemFontOfSize:11.0f];
//        self.point = lb;
//        [self.contentView addSubview:lb];
//        [lb release];
        
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    }
    return self;
}

-(void) dealloc
{
    [icon release];
    [label release];
    [name release];
    [point release];
    [count release];
    [super dealloc];
}

@end
