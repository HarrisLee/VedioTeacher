//
//  SecondViewController.h
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "CollectionCell.h"
#import "CollectionHeaderView.h"
#import "PlayerViewController.h"
#import "GetSecondDirectoryReqBody.h"
#import "GetSecondDirectoryRespBody.h"
#import "AddSecondDirectoryReqBody.h"
#import "AddSecondDirectoryRespBody.h"
#import "SDirectoryModel.h"
#import "GetTVListOfTimeReqBody.h"
#import "GetTVListOfTimeRespBody.h"
#import "GetTVListOfGoodCountReqBody.h"
#import "GetTVListOfGoodCountRespBody.h"
#import "GetTVOfSearchReqBody.h"
#import "GetTVOfSearchRespBody.h"
#import "CHPickerView.h"

@interface SecondViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CollectionHeaderViewDelegate,CHPickerViewDelegate,UITextFieldDelegate>
{
    NSString *topId;
    NSMutableArray *secArray;
    NSMutableDictionary *vedioDictionary;
    UICollectionView *waterView;
    NSInteger  clickedIndex;
    BOOL isLoading;
    
    UIView *searchView;
    CHPickerView *pickerView;
    NSInteger selectView;
    UITextField *keyWordField;
    UITextField *startField;
    UITextField *endField;
    NSMutableArray *tvList;
}
@property (nonatomic, retain) NSString *topId;

@end
