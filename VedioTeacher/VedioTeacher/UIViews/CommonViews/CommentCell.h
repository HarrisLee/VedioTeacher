//
//  CommentCell.h
//  Hey!XuanWu
//
//  Created by xuchuanyong on 12/11/12.
//  Copyright (c) 2012 q mm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell {
    UIImageView     *lineImage;     //分割线图片
    UIImageView     *headImg;       //用户头像
    UILabel         *nameLabel;     //名称标签
    UILabel         *timeLabel;     //发表时间标签
    UILabel         *commentLabel;  //评论内容
    CGFloat         cellHeight;     //cell高度
}
@property (nonatomic,retain) UIImageView *headImg; 
@property (nonatomic,retain) UILabel     *nameLabel;
@property (nonatomic,retain) UILabel     *timeLabel;
@property (nonatomic,retain) UILabel     *commentLabel;
@property                    CGFloat       cellHeight;
- (void)setContent:(NSString*)content;
@end
