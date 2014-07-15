//
//  BaseViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//发布任务
-(BOOL) releaseTask:(id)sender;

//上传视频
-(BOOL) uploadVedio:(id)sender;

//拍摄
-(BOOL) shootingVedio:(id)sender;

//搜索视频
-(BOOL) searchTask:(id)sender;

//添加二级目录
-(BOOL) addSecDir:(id)sender;

-(void) setTitleViewHidden:(BOOL) hidden;

@end
