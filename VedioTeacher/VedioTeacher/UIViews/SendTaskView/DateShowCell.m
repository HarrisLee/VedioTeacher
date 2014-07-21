//
//  DateShowCell.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "DateShowCell.h"

@implementation DateShowCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

-(void) createInitView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor getColor:@"E4E4E4"];
    for (int i=0; i<12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(9+49*(i%4), 5+25*(i/4), 40, 20);
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1.0;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%d月",i+1] forState:UIControlStateNormal];
        button.tag = 600 + i;
        [button addTarget:self action:@selector(mouthClickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIImageView *hor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, 205, 1)];
    hor.alpha = 0.5;
    hor.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:hor];
    [hor release];
}

-(void) mouthClickAtIndex:(id) sender
{
    for (int i = 0; i<12; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:600+i];
        [btn setBackgroundColor:[UIColor whiteColor]];
        if ([sender tag] - 600 == i) {
            [btn setBackgroundColor:[UIColor getColor:@"3FA6FF"]];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mouthClickAtIndex:)]) {
        [self.delegate mouthClickAtIndex:sender];
    }
}

-(void) clearClicked
{
    for (int i = 0; i<12; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:600+i];
        [btn setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
