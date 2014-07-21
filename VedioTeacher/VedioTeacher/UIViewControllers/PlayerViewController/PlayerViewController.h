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
#import "AddGoodReqBody.h"
#import "AddGoodRespBody.h"
#import "GetTVInfoReqBody.h"
#import "GetTVInfoRespBody.h"

@interface PlayerViewController : BaseViewController
{
    UIScrollView *scrollView;
    VedioModel *vedioModel;
    NSString *topName;
    NSString *secondName;
    UIButton *goodBtn;
    UILabel *countLabel;
}
@property (nonatomic, retain) VedioModel *vedioModel;
@property (nonatomic, retain) NSString *topName;
@property (nonatomic, retain) NSString *secondName;
@end
