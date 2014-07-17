//
//  TaskCell.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell
@synthesize taskName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

- (void) createInitView
{
    // Initialization code
    self.contentView.backgroundColor = [UIColor getColor:@"E4E4E4"];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 185, 20)];
    name.textAlignment = NSTextAlignmentCenter;
    name.textColor = [UIColor blackColor];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:13.0];
    self.taskName = name;
    [self addSubview:name];
    [name release];
    
    UIImageView *hor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29.5, 205, 0.5)];
    hor.alpha = 0.5;
    hor.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:hor];
    [hor release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    [taskName release];
    [super dealloc];
}

@end
