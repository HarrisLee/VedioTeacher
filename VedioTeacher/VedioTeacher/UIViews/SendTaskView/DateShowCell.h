//
//  DateShowCell.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateShowCellDelegate <NSObject>

-(void) mouthClickAtIndex:(id) sender;

@end

@interface DateShowCell : UITableViewCell
{
    id<DateShowCellDelegate> delegate;
}
@property (nonatomic, assign) id<DateShowCellDelegate> delegate;

-(void) clearClicked;

-(void) setHighlightedAtIndex:(int) index;

@end
