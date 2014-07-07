//
//  CommentCell.m
//  Hey!XuanWu
//
//  Created by xuchuanyong on 12/11/12.
//  Copyright (c) 2012 q mm. All rights reserved.
//

#import "CommentCell.h"

#define NAME_LABEL_FRAME    CGRectMake(50, 5, 150, 15)
#define TIME_LABEL_FRAME    CGRectMake(160, 5, 150, 15)
#define COMMENT_LAEBL_FRAME CGRectMake(50, 25, 270, 15)
#define HEAD_IMG_FRAME      CGRectMake(5, 5, 40, 40)
#define LINE_IMAGE_FRAME    CGRectMake(50, 48, 300, 2)

@implementation CommentCell
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize commentLabel;
@synthesize cellHeight;
@synthesize headImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:NAME_LABEL_FRAME];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont fontWithName:@"Arial" size:10];
        self.nameLabel = label;
        [label release];
        [self addSubview:nameLabel];
        
        label = [[UILabel alloc] initWithFrame:TIME_LABEL_FRAME];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont fontWithName:@"Arial" size:10];
        self.timeLabel = label;
        [label release];
        [self addSubview:timeLabel];
        
        label = [[UILabel alloc] initWithFrame:COMMENT_LAEBL_FRAME];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textColor = HEXCOLOR(cusColor);
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"Arial" size:12];
        self.commentLabel = label;
        [label release];
        [self addSubview:commentLabel];
        
        lineImage = [[UIImageView alloc] initWithFrame:LINE_IMAGE_FRAME];
        lineImage.image = [[UIImage imageNamed:@"line.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self addSubview:lineImage];
        [lineImage release];
        
        headImg = [[UIImageView alloc] initWithFrame:HEAD_IMG_FRAME];
        headImg.layer.cornerRadius = 4;
        headImg.layer.masksToBounds = YES;
        headImg.image = [[UIImage imageNamed:@"default_avatar.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        [self addSubview:headImg];
        [headImg release];
    }
    return self;
}

- (void)setContent:(NSString*)content {
    commentLabel.text = content;
    CGSize size = [content sizeWithFont:commentLabel.font constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = COMMENT_LAEBL_FRAME;
    commentLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    lineImage.frame = CGRectMake(10, size.height+28, 300, 2);
    cellHeight = size.height+30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [nameLabel release];
    [timeLabel release];
    [commentLabel release];
    [super dealloc];
}

@end
