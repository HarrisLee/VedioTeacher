//
//  FifthViewController.h
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
#import "AccountModel.h"
#import "GetAccountListReqBody.h"
#import "GetAccountListRespBody.h"

@interface FifthViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CollectionHeaderViewDelegate,CHPickerViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
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
    UITextField *accountField;
    AccountModel *accountModel;
    NSMutableArray *accountArray;
    UITableView *accountTable;
    NSMutableArray *tvList;
}
@property (nonatomic, retain) NSString *topId;

@end
