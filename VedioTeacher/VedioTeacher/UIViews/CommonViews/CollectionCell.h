//
//  CollectionCell.h
//  LuxuryA4L
//
//  Created by Cao JianRong on 13-12-5.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
{
    UIImageView *icon;
    UILabel* label;
    UILabel* name;
    UILabel* count;
    UILabel* point;
}
@property (retain, nonatomic) UIImageView *icon;
@property (retain, nonatomic) UILabel* label;
@property (retain, nonatomic) UILabel* name;
@property (retain, nonatomic) UILabel* count;
@property (retain, nonatomic) UILabel* point;
@end
