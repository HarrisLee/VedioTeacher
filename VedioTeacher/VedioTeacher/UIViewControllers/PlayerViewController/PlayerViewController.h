//
//  PlayerViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "VedioModel.h"
#import "TVCommentModel.h"
#import "GetTVCommentReqBody.h"
#import "GetTVCommentRespBody.h"
#import "AddTVCommentReqBody.h"
#import "AddTVCommentRespBody.h"
#import "AddTVGoodReqBody.h"
#import "AddTVGoodRespBody.h"
#import "GetTVInfoReqBody.h"
#import "GetTVInfoRespBody.h"
#import "LoginsViewController.h"
#import "VedioPlayerViewController.h"

@interface PlayerViewController : BaseViewController<UITextFieldDelegate>
{
    UIScrollView *scrollView;
    VedioModel *vedioModel;
    NSString *topName;
    NSString *secondName;
    UIButton *goodBtn;
    UILabel *countLabel;
    UILabel *uploader;
    UILabel *uploadTime;
    UITextField *contentField;
    UIImageView *bottomBack;
    CGPoint point;
    NSInteger commentCount;
}
@property (nonatomic, retain) VedioModel *vedioModel;
@property (nonatomic, retain) NSString *topName;
@property (nonatomic, retain) NSString *secondName;
@end
