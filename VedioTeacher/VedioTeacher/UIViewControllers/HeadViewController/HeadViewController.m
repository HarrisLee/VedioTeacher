//
//  HeadViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "HeadViewController.h"

@interface HeadViewController ()
{
    NSString *dirName;
}
@end

@implementation HeadViewController
@synthesize topId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    secArray = [[NSMutableArray alloc] init];
    vedioDictionary = [[NSMutableDictionary alloc] init];
    clickedIndex = 0;
    isLoading = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(240, 160)];
    //    [layout setMinimumInteritemSpacing:1];
    [layout setMinimumLineSpacing:10.0f];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    waterView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, 1004, 768 - 64 - 10) collectionViewLayout:layout];
    waterView.delegate = self;
    waterView.dataSource = self;
    waterView.showsVerticalScrollIndicator = NO;
    [waterView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"collectionIdentifier"];
    [waterView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeaderIdentifier"];
    waterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:waterView];
    [layout release];
    [waterView release];
    
    GetSecondDirectoryReqBody *req = [[GetSecondDirectoryReqBody alloc] init];
    req.idTopDirectory = self.topId;
    NSMutableURLRequest *urlRequets = [[AFHttpRequestUtils shareInstance] requestWithBody:req andReqType:GETSECDIR];
    [req release];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequets];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetSecondDirectoryRespBody *respBody = (GetSecondDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GETSECDIR];
        [self checkData:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取二级目录目录失败.");
    }];
    
    [operation start];
    [operation release];
}

-(void) checkData:(GetSecondDirectoryRespBody *)response
{
    NSLog(@"%d",[response.sDirectoryArray count]);
    if ([response.sDirectoryArray count] == 0) {
//        alertMessage(@"二级目录暂时为空.");
        return ;
    }
    
    clickedIndex = 0;
    
    [DataCenter shareInstance].taskDirId = [[response.sDirectoryArray objectAtIndex:0] idSecondDirectory];

    [secArray removeAllObjects];
    
    for (SDirectoryModel *model in response.sDirectoryArray) {
        [secArray addObject:model];
    }
    [self getTVListAtIndex:clickedIndex];
    [waterView reloadData];
}

-(BOOL) addSecDir:(id)sender
{
    if (![super addSecDir:sender]) {
        return NO;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入活动主题"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
    [alertView textFieldAtIndex:0].delegate = self;
    [alertView show];
    [alertView release];
    return YES;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if ([dirName length] == 0) {
        return ;
    }
    if (buttonIndex == 1) {   //创建二级目录
        AddSecondDirectoryReqBody *reqBody = [[AddSecondDirectoryReqBody alloc] init];
        reqBody.idTopDirectory = [self.topId stringByReplacingOccurrencesOfString:@" " withString:@""];
        reqBody.nameSecondDirectory = dirName;
        reqBody.addAccountId = [DataCenter shareInstance].loginId;
        
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_SECDIR];
        
        [reqBody release];
        
        AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            AddSecondDirectoryRespBody *respBody = (AddSecondDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_SECDIR];
            [self addSecDirSuccess:respBody];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"添加分类失败,请重新创建.");
        }];
        [theOperation start];
        [theOperation release];
    }
}

-(void) addSecDirSuccess:(AddSecondDirectoryRespBody *)respBody
{
    if ([@"\"0\"" isEqualToString:respBody.secondDir]) {
        alertMessage(@"添加分类失败.请重新创建");
        return ;
    }
    SDirectoryModel *model = [[SDirectoryModel alloc] init];
    model.idSecondDirectory = respBody.secondDir;
    model.nameSecondDirectory = dirName;
    [secArray addObject:model];
    [model release];
    [waterView reloadData];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    dirName = [textField.text retain];
    NSLog(@"%@",dirName);
}

/**
 *  返回每个collectionViewCell的大小（可以进行单独的配置）
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout collectionViewLayout
 *  @param indexPath            indexPath
 *
 *  @return 返回每个collectionViewCell的大小
 */
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(240, 160);
}


-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.0;
}

/**
 *  总共有多少个Section
 *
 *  @param collectionView collectionView
 *
 *  @return 返回总共多少个Section
 */
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/*!
 *  sectionHeader的frame
 *
 *  @param collectionView       collection
 *  @param collectionViewLayout collectionViewLayout
 *  @param section              section
 *
 *  @return 返回sectionHeader的大小以及位置
 */
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(1004, 50);
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionHeaderView *header = (CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeaderIdentifier" forIndexPath:indexPath];
    if (!header) {
        header = [[[CollectionHeaderView alloc] init] autorelease];
    }
    header.delegate =self;
    [header setHeaderDataView:secArray index:clickedIndex];
    return header;
}

//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//
//}

/**
 *  每个section总共有多少个cell
 *
 *  @param collectionView collection
 *  @param section        当前的section
 *
 *  @return 返回每个section总共有多少个cell
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 28;
}

/**
 *  返回的UICollectionViewCell
 *  这个cell返回的时候必须先从
 *  -dequeueReusableCellWithReuseIdentifier:forIndexPath:中检索
 *
 *  @param  collectionView
 *
 *  @return 返回Cell
 */
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionIdentifier = @"collectionIdentifier";
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[CollectionCell alloc] init] autorelease];
    }
    cell.label.text = @"20：19";
    cell.name.text = @"变形金刚4:绝境重生";
    cell.count.text = [NSString stringWithFormat:@"播放：19.5万"];
    cell.point.text = @"9.8";
    return cell;
}

/**
 *  选中的当前Cell的点击事件
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath  索引
 */
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDirectoryModel *model = [secArray objectAtIndex:clickedIndex];
    PlayerViewController *play = [[PlayerViewController alloc] init];
    play.title = @"视频播放";
    play.topName = self.title;
    play.secondName = model.nameSecondDirectory;
    [self.navigationController pushViewController:play animated:YES];
    [play release];
}

-(void) headerClickAtIndex:(id)sender
{
    if (isLoading) {
        return;
    }
    NSLog(@"%d",[sender tag]);
    clickedIndex = [sender tag] - 5000;
    [self getTVListAtIndex:clickedIndex];
}

- (void) getTVListAtIndex:(NSInteger)index
{
    isLoading = YES;
    SDirectoryModel *model = [secArray objectAtIndex:index];
    GetTVListOfGoodCountReqBody *reqBody = [[GetTVListOfGoodCountReqBody alloc] init];
    reqBody.idSecondDirectory = [model.idSecondDirectory stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TVLIST_GOODCOUNT];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetTVListOfGoodCountRespBody *respBody = (GetTVListOfGoodCountRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TVLIST_GOODCOUNT];
        [self checkSecondDirectroy:respBody];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        [self checkSecondDirectroy:nil];
    }];
    [operation start];
    [operation request];
}

-(void)checkSecondDirectroy:(GetTVListOfGoodCountRespBody *) response
{
    isLoading = NO;
    if (!response) {
//        alertMessage(@"获取视频列表失败，请重新获取.");
        return ;
    }
    
    if ([response.tvList count] == 0) {
//        alertMessage(@"该目录下视频列表为空.");
        return ;
    }
    
    [vedioDictionary removeObjectForKey:[NSString stringWithFormat:@"%d",clickedIndex]];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (id obj in response.tvList) {
        [array addObject:obj];
    }
    
    if ([array count] > 0) {
        [vedioDictionary setObject:array forKey:[NSString stringWithFormat:@"%d",clickedIndex]];
    }
    
    [waterView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [topId release];
    [secArray release];
    [super dealloc];
}

@end
