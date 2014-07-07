//
//  UIPlaceHolderTextView.h
//  Hey!XuanWu
//
//  Created by 徐 传勇 on 13-1-15.
//  Copyright (c) 2013年 q mm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView {
    NSString *placeholder;
    UIColor *placeholderColor;
@private
    UILabel *placeHolderLabel;
}
@property(nonatomic, retain) UILabel *placeHolderLabel;
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;
-(void)textChanged:(NSNotification*)notification;
@end
