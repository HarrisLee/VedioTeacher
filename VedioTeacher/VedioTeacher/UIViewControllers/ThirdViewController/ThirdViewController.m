//
//  ThirdViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
{
    NSString *dirName;
}
@end

@implementation ThirdViewController
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
    tvList = [[NSMutableArray alloc] init];
    accountArray = [[NSMutableArray alloc] init];
    clickedIndex = 0;
    isLoading = NO;
    isSearching = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearSearchResult:) name:@"clear" object:nil];
    
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
    
    NSString *date = [Utils stringWithDate:[NSDate date] andFormat:@"yyyy-MM-dd"];
    
    searchView = [[UIView alloc] initWithFrame:CGRectMake((1024-320)/2, 60, 320, 500)];
    searchView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:searchView];
    [searchView release];
    
    keyWordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    keyWordField.text = @"";
    keyWordField.placeholder = @"请输入搜索关键词";
    keyWordField.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:keyWordField];
    [keyWordField release];
    
    startField = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
    startField.delegate = self;
    startField.text = date;
    startField.placeholder = @"请选择搜索开始时间";
    startField.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:startField];
    [startField release];
    
    endField = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, 300, 30)];
    endField.delegate = self;
    endField.text = date;
    endField.placeholder = @"请选择搜索结束时间";
    endField.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:endField];
    [endField release];
    
    accountField = [[UITextField alloc] initWithFrame:CGRectMake(10, 130, 300, 30)];
    accountField.delegate = self;
    accountField.text = @"";
    accountField.placeholder = @"请选择用户";
    accountField.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:accountField];
    [accountField release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 170, 300, 30);
    button.backgroundColor = [UIColor getColor:@"3FA6FF"];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchTVList:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:button];
    
    pickerView = [[CHPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    pickerView.delegate = self;
    [pickerView setHidden:YES];
    [searchView addSubview:pickerView];
    [pickerView release];
    
    accountTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 200) style:UITableViewStylePlain];
    accountTable.delegate = self;
    accountTable.dataSource = self;
    accountTable.showsVerticalScrollIndicator = NO;
    [searchView addSubview:accountTable];
    [accountTable setHidden:YES];
    [accountTable release];
    
    [searchView setHidden:YES];
}

-(void) pickerViewString:(NSString *)date
{
    if (selectView == 1) {
        startField.text = date;
        return ;
    }
    endField.text = date;
}

-(void) searchTVList:(id)sender
{
    if (![DataCenter shareInstance].isLogined) {
        LoginsViewController *login = [[LoginsViewController alloc] init];
        login.modalPresentationStyle = UIModalPresentationFormSheet;
        login.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:login animated:YES completion:nil];
        login.view.superview.frame = CGRectMake(0, 0, 512, 320);
        login.view.superview.center = self.view.center;
        [login release];
        return ;
    }
    
    if ([keyWordField.text length] == 0 || [startField.text length] == 0 || [endField.text length] == 0) {
        alertMessage(@"信息输入不全，请不全");
        return ;
    }
    
    isSearching = YES;
    
    [searchView endEditing:YES];
    
    GetTVOfSearchReqBody *reqBody = [[GetTVOfSearchReqBody alloc] init];
    reqBody.startTime = startField.text;
    reqBody.endTime = endField.text;
    reqBody.GJZ = keyWordField.text;
    if (accountModel) {
        reqBody.accountId = [accountModel.idAccoun stringByReplacingOccurrencesOfString:@" " withString:@""];
    } else {
        reqBody.accountId = @"";
    }
    reqBody.jobId = @"";
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TV_SEARCH];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetTVOfSearchRespBody *respBody = (GetTVOfSearchRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TV_SEARCH];
        [self checkSearchTVList:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"搜索视频失败,请重新搜索.");
    }];
    
    [operation start];
    [operation release];
    
}

-(void) checkSearchTVList:(GetTVOfSearchRespBody *)response
{
    if (![response.tvList isKindOfClass:[NSArray class]]) {
        alertMessage(@"搜索视频失败,请重新搜索.");
        return ;
    }
    [tvList removeAllObjects];
    for (VedioModel *model in response.tvList) {
        [tvList addObject:model];
    }
    [waterView reloadData];
    [searchView setHidden:YES];
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == startField || textField == endField) {
        [accountTable setHidden:YES];
        [self.view endEditing:YES];
        if (textField == startField) {
            selectView = 1;
        } else {
            selectView = 2;
        }
        [pickerView setHidden:NO];
        return NO;
    }
    
    if (textField == accountField) {
        [self getAccountList:nil];
        return NO;
    }
    
    return YES;
}

/*!
 *  获取所有用户列表
 *
 *  @param account 用户ID
 */
-(void) getAccountList:(NSString *)account
{
    GetAccountListReqBody *reqBody = [[GetAccountListReqBody alloc] init];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_ACCOUNTLIST];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetAccountListRespBody *respBody = (GetAccountListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_ACCOUNTLIST];
        [self checkAccountList:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取用户列表失败.");
    }];
    [operation start];
    [operation release];
}

-(void) checkAccountList:(GetAccountListRespBody *) response
{
    if ([response.accountListResult count] == 0) {
        alertMessage(@"请求出错，请重新获取");
        return ;
    }
    [accountTable setHidden:NO];
    [accountArray removeAllObjects];
    for (AccountModel *model in response.accountListResult) {
        [accountArray addObject:model];
    }
    [accountTable reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [accountArray count] ? [accountArray count] : 0 ;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdendefier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    AccountModel *model = [accountArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.accountName;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (accountModel) {
        [accountModel release];
        accountModel = nil;
    }
    accountModel = [[accountArray objectAtIndex:indexPath.row] retain];
    accountField.text = [accountModel.accountName stringByReplacingOccurrencesOfString:@" " withString:@""];
    [tableView setHidden:YES];
}

-(void) clearSearchResult:(NSNotification *)notification
{
    [searchView setHidden:YES];
    isSearching = NO;
    [waterView reloadData];
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
    if (textField == startField || textField == endField) {
        return ;
    }
    if (dirName) {
        [dirName release];
        dirName = nil;
    }
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
    [header setSearch:isSearching];
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
    if (isSearching) {
        NSLog(@"%d",[tvList count]);
        return [tvList count];
    }
    NSArray *array = [vedioDictionary objectForKey:[NSString stringWithFormat:@"%d",clickedIndex]];
    return array ? [array count] : 0;
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
    VedioModel *model = nil;
    if (isSearching) {
        model = [tvList objectAtIndex:indexPath.row];
    } else {
        NSArray *array = [vedioDictionary objectForKey:[NSString stringWithFormat:@"%d",clickedIndex]];
        model = [array objectAtIndex:indexPath.row];
    }
    NSString *name = [model.nameTV stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSRange range = [name rangeOfString:@"." options:NSBackwardsSearch];
    if (range.length > 0) {
        NSString *file = [name substringToIndex:range.location];
        cell.name.text = file;
    } else {
        cell.name.text = name;
    }
    [cell.icon setImageWithURL:[NSURL URLWithString:model.tvPicVirtualPath] placeholderImage:[UIImage imageNamed:@"placeholder_horizontal"]];
    cell.count.text = [NSString stringWithFormat:@"点赞数：%@",[model.goodCount description]];
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
    play.title = @"视频详情";
    play.topName = self.title;
    play.secondName = model.nameSecondDirectory;
    if (isSearching) {
        play.vedioModel = [tvList objectAtIndex:indexPath.row];
    } else {
        play.vedioModel = [[vedioDictionary objectForKey:[NSString stringWithFormat:@"%d",clickedIndex]] objectAtIndex:indexPath.row];
    }
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
    [waterView reloadData];
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
    [operation release];
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
    for (VedioModel *obj in response.tvList) {
        [array addObject:obj];
    }
    
    if ([array count] > 0) {
        [vedioDictionary setObject:array forKey:[NSString stringWithFormat:@"%d",clickedIndex]];
    }
    
    [waterView reloadData];
    [array release];
}

-(BOOL) searchTask:(id)sender
{
    if (![DataCenter shareInstance].isLogined) {
        LoginsViewController *login = [[LoginsViewController alloc] init];
        login.modalPresentationStyle = UIModalPresentationFormSheet;
        login.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:login animated:YES completion:nil];
        login.view.superview.frame = CGRectMake(0, 0, 512, 320);
        login.view.superview.center = self.view.center;
        [login release];
        return NO;
    }
    [tvList removeAllObjects];
    isSearching = YES;
    [waterView reloadData];
    
    [searchView setHidden:NO];
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    if (accountModel) {
        [accountModel release];
        accountModel = nil;
    }
    [topId release];
    [secArray release];
    [accountArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"clear" object:nil];
    [super dealloc];
}

@end
