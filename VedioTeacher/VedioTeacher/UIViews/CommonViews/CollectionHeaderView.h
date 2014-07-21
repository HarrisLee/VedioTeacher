//
//  CollectionHeaderView.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-21.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDirectoryModel.h"

@protocol CollectionHeaderViewDelegate <NSObject>

-(void) headerClickAtIndex:(id) sender;

@end

@interface CollectionHeaderView : UICollectionReusableView
{
    UIScrollView *headerScroll;
    NSInteger    buttonCount;
    id<CollectionHeaderViewDelegate> delegate;
}
@property (nonatomic, assign) id<CollectionHeaderViewDelegate> delegate;
-(void) setHeaderDataView:(NSArray *)headerArray index:(NSInteger)index;

@end
