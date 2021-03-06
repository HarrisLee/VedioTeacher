//
//  SendTaskViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SendTaskViewController.h"

@interface SendTaskViewController ()

@end

@implementation SendTaskViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"%@",[DataCenter shareInstance].taskDirId);
    if ([DataCenter shareInstance].isLogined) {
        nameLabel.text = [DataCenter shareInstance].loginName;
    } else {
        nameLabel.text = @"您尚未登录，请登录";
        LoginsViewController *login = [[LoginsViewController alloc] init];
        login.modalPresentationStyle = UIModalPresentationFormSheet;
        login.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:login animated:YES completion:nil];
        login.view.superview.frame = CGRectMake(0, 0, 512, 320);
        login.view.superview.center = self.view.center;
        [login release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    didSection = 0;
    didRow = 0;
    showTask = @"1";
    dateArray = [[NSMutableArray alloc] initWithObjects:@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020", nil];;
    taskArray = [[NSMutableArray alloc] init];
    acceptArray = [[NSMutableArray alloc] init];
    accountArray = [[NSMutableArray alloc] init];
    tvArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:@"updateInfo" object:nil];
    
    [self createInitView];
    
    [self getAccountList:[DataCenter shareInstance].loginId];
    
}

-(void) updateUserInfo:(NSNotification *)notification
{
    nameLabel.text = [DataCenter shareInstance].loginName;
    [self getAccountList:[DataCenter shareInstance].loginId];
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
    return [tvArray count];
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
    static NSString *collectionIdentifier = @"myTVList";
    VedioModel *model = [tvArray objectAtIndex:indexPath.row];
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[CollectionCell alloc] init] autorelease];
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
    VedioModel *model = [tvArray objectAtIndex:indexPath.row];
    PlayerViewController *play = [[PlayerViewController alloc] init];
    play.title = @"视频详情";
    play.topName = self.title;
    play.secondName = model.fileTVName;
    play.vedioModel = model;
    [self.navigationController pushViewController:play animated:YES];
    [play release];
}

//显示我发布的任务
-(void) sendedTask:(id)sender
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
    
    [waterView setHidden:YES];
    [submit setHidden:NO];
    [submit setTitle:@"立即发布任务" forState:UIControlStateNormal];
    didRow = 0;
    showTask = @"1";
    [titleRect setHidden:NO];
    taskTitleField.text = @"";
    taskInfoView.text = @"";
    taskTitleField.userInteractionEnabled = YES;
    taskInfoView.userInteractionEnabled = YES;
    taskAccountName.text = @"";
    [taskAccount setHidden:YES];
    [taskAccountName setHidden:YES];
    taskInfoView.layer.borderWidth = 1.0;
    [sendedView setHidden:NO];
    for (int i = 0; i<[accountArray count]; i++) {
        UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
        [btn setSelected:NO];
    }
    [sendTable reloadData];
}

//显示我接受的任务
-(void) acceptedNewTask:(id)sender
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
    
    [waterView setHidden:YES];
    [submit setHidden:YES];
    [submit setTitle:@"立即接受任务" forState:UIControlStateNormal];
    didRow = 0;
    showTask = @"2";
    [titleRect setHidden:YES];
    taskTitleField.text = @"";
    taskInfoView.text = @"";
    taskTitleField.userInteractionEnabled = NO;
    taskInfoView.userInteractionEnabled = NO;
    taskAccountName.text = @"";
    [taskAccount setHidden:NO];
    [taskAccountName setHidden:NO];
    taskInfoView.layer.borderWidth = 0.0;
    [sendedView setHidden:NO];
    for (int i = 0; i<[accountArray count]; i++) {
        UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
        btn.userInteractionEnabled = NO;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setSelected:NO];
    }
    [sendTable reloadData];
}

//显示我发布的视频
-(void) sendedVideo:(id)sender
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
    
    [sendedView setHidden:YES];
    [submit setHidden:YES];
    [waterView setHidden:NO];
    GetMyTVListOfTimeReqBody *req = [[GetMyTVListOfTimeReqBody alloc] init];
    req.accountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:req andReqType:GET_MYTVLIST_TIME];
    [req release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetMyTVListOfTimeRespBody *respBody = (GetMyTVListOfTimeRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_MYTVLIST_TIME];
        [self checkMyTVList:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，请重新获取视频列表.");
    }];
    [operation start];
    [operation release];
}

-(void) checkMyTVList:(GetMyTVListOfTimeRespBody *)response
{
    if ([response.tvList count] == 0) {
        return ;
    }
    [tvArray removeAllObjects];
    for (VedioModel *model in response.tvList) {
        [tvArray addObject:model];
    }
    [waterView reloadData];
}

-(void) submitTask:(id)sender
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
    
    if ([[sender currentTitle] isEqualToString:@"立即发布任务"]) {
        NSMutableString *accountList = [[NSMutableString alloc] init];
        for (int i = 0; i<[accountArray count]; i++) {
            UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
            if ([btn isSelected]) {
                AccountModel *model = [accountArray objectAtIndex:i];
                [accountList appendString:[NSString stringWithFormat:@"|%@",[model.idAccoun stringByReplacingOccurrencesOfString:@" " withString:@""]]];
            }
        }

        if ([taskTitleField.text length] == 0 || [taskInfoView.text length] == 0) {
            alertMessage(@"任务信息输入不完整，请补充");
            [accountList release];
            return;
        }

        if ([accountList length] == 0) {
            alertMessage(@"您尚未选择任务接收者");
            [accountList release];
            return;
        }
        
        [accountList deleteCharactersInRange:NSMakeRange(0, 1)];
        
        AddTaskReqBody *reqBody = [[AddTaskReqBody alloc] init];
        reqBody.taskName = taskTitleField.text;
        reqBody.taskNote = taskInfoView.text;
        reqBody.idSecondDirectory = @"SD140715094304369";//[DataCenter shareInstance].taskDirId;
        reqBody.addTaskAccountID = [DataCenter shareInstance].loginId;
        reqBody.AcceptAccountList = accountList;
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_TASK];
        [accountList release];
        [reqBody release];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            AddTaskRespBody *respBody = (AddTaskRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_TASK];
            [self checkAddTask:respBody];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"请求失败，请重新添加任务.");
        }];
        [operation start];
        [operation release];
    } else if([[sender currentTitle] isEqualToString:@"立即接受任务"]){
        AcceptTaskReqBody *reqBody = [[AcceptTaskReqBody alloc] init];
        reqBody.accountid = [DataCenter shareInstance].loginId;
        TaskModel *model = [acceptArray objectAtIndex:didSelectCell];
        reqBody.taskId = [model.taskID stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ACCEPT_TASK];
        [reqBody release];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            AcceptTaskRespBody *respBody = (AcceptTaskRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ACCEPT_TASK];
            [self checkAcceptTask:respBody];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"请求失败，请重新接受任务.");
        }];
        [operation start];
        [operation release];
    } else if([[sender currentTitle] isEqualToString:@"结束任务"]) {
        EndTaskReqBody *end = [[EndTaskReqBody alloc] init];
        TaskModel *model = [acceptArray objectAtIndex:didSelectCell];
        end.taskId = [model.taskID stringByReplacingOccurrencesOfString:@" " withString:@""];
        end.accountid = [DataCenter shareInstance].loginId;
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:end andReqType:END_TASK];
        [end release];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            EndTaskRespBody *respBody = (EndTaskRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:END_TASK];
            [self checkEndTask:respBody];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"请求失败，请重新接受任务.");
        }];
        [operation start];
        [operation release];
    }
}

-(void) checkAddTask:(AddTaskRespBody *) response
{
    NSLog(@"%@",response.result);
    if ([@"\"0\"" isEqualToString:response.result]) {
        alertMessage(@"添加任务失败，请重新添加");
        return ;
    }
    alertMessage(@"添加任务成功.");
}

-(void) checkAcceptTask:(AcceptTaskRespBody *)response
{
    NSLog(@"%@",response.result);
    if ([@"0" isEqualToString:[response.result description]]) {
        alertMessage(@"接受任务失败，请重新操作");
        return ;
    }
    alertMessage(@"接受任务成功.");
    TaskModel *model = [acceptArray objectAtIndex:didSelectCell];
    model.isAccept = @"1";
    [acceptArray replaceObjectAtIndex:didSelectCell withObject:model];
    [sendTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:didSelectCell inSection:7]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [submit setTitle:@"结束任务" forState:UIControlStateNormal];
    for (int i = 0; i < [accountArray count]; i++) {
        AccountModel *model = [accountArray objectAtIndex:i];
        if ([[model.idAccoun stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:[DataCenter shareInstance].loginId]) {
            UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
            [btn setSelected:YES];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            break ;
        }
    }
}

-(void) checkEndTask:(EndTaskRespBody *)response
{
    NSLog(@"%@",response.result);
    if ([@"0" isEqualToString:[response.result description]]) {
        alertMessage(@"结束任务失败，请重新操作");
        return ;
    }
    alertMessage(@"结束任务成功.");
    TaskModel *model = [acceptArray objectAtIndex:didSelectCell];
    model.isAccept = @"2";
    [acceptArray replaceObjectAtIndex:didSelectCell withObject:model];
    [sendTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:didSelectCell inSection:7]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [submit setHidden:YES];
}

#pragma mark ----------------------------------------
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <= 6) {
        return didSection - section ? 0 : 1;
    }
    if ([showTask isEqualToString:@"1"]) {
        return [taskArray count];
    }
    return [acceptArray count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 6) {
        return nil;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[NSString stringWithFormat:@"%@年",[dateArray objectAtIndex:section]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 205, 25.0f);
    button.tag = section+500;
    [button addTarget:self action:@selector(sectionHeaderDidSelectAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor getColor:@"E4E4E4"]];
    if (didSection == section) {
        [button setBackgroundColor:[UIColor getColor:@"3FA6FF"]];
    }
    
    UIImageView *hor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 24.5, 205, 0.5)];
    hor.alpha = 0.5;
    hor.backgroundColor = [UIColor lightGrayColor];
    [button addSubview:hor];
    [hor release];
    
    return button;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section <= 6 ? [NSString stringWithFormat:@"%@年",[dateArray objectAtIndex:section]] : nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section <= 6 ? 25.0f : 0.0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section <= 6 ? 80.0f : 30.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section <= 6) {
        static NSString *identifier = @"date";
        DateShowCell *cell = (DateShowCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[DateShowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        }
        cell.delegate = self;
        [cell setHighlightedAtIndex:didRow];
        return cell;
    }
    static NSString *identifier = @"task";
    TaskCell *cell = (TaskCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[TaskCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    if ([showTask isEqualToString:@"1"]) {
        TaskModel *model = [taskArray objectAtIndex:indexPath.row];
        cell.taskName.textColor = [UIColor blackColor];
        cell.taskName.text = model.taskName;
    } else {
        TaskModel *model = [acceptArray objectAtIndex:indexPath.row];
        if ([[model.isAccept description] isEqualToString:@"0"]) {
            cell.taskName.textColor = [UIColor greenColor];
        } else if ([[model.isAccept description] isEqualToString:@"2"]) {
            cell.taskName.textColor = [UIColor redColor];
        } else {
            cell.taskName.textColor = [UIColor blackColor];
        }
        cell.taskName.text = model.taskName;
    }

    return cell;
}

-(void) sectionHeaderDidSelectAtIndex:(id) sender
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
    
    NSInteger section = [sender tag] - 500;
    didSection = section;
    didRow = 0;
    [sendTable reloadData];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d-%d",indexPath.section,indexPath.row);
    didSelectCell = indexPath.row;
    if (indexPath.section > 6) {
        if ([showTask isEqualToString:@"1"]) {
            TaskModel *selectModel = [taskArray objectAtIndex:didSelectCell];
            taskTitleField.text = selectModel.taskName;
            taskInfoView.text = selectModel.taskNote;
            //显示接受的用户
            [self getTaskInfo:selectModel.taskID];
        } else {
            TaskModel *selectModel = [acceptArray objectAtIndex:didSelectCell];
            taskTitleField.text = selectModel.taskName;
            taskAccountName.text = selectModel.addTaskAccountID;
            taskInfoView.text = selectModel.taskNote;
            [self getTaskInfo:selectModel.taskID];
            if ([[selectModel.isAccept description] isEqualToString:@"0"]) {
                [submit setTitle:@"立即接受任务" forState:UIControlStateNormal];
                [submit setHidden:NO];
            }
            else if ([[selectModel.isAccept description] isEqualToString:@"1"]) {
                [submit setTitle:@"结束任务" forState:UIControlStateNormal];
                [submit setHidden:NO];
            }
            else {
                [submit setHidden:YES];
            }
        }
    }
}

-(void) mouthClickAtIndex:(id)sender
{
    NSLog(@"%@",[[sender currentTitle] stringByReplacingOccurrencesOfString:@"月" withString:@""]);
    
    if ([startTime hasSuffix:[NSString stringWithFormat:@"%02d-01",[sender tag]]]) {
        if ([startTime hasPrefix:[dateArray objectAtIndex:didSection]]) {
            return ;
        }
    }
    NSString *mouth = [[sender currentTitle] stringByReplacingOccurrencesOfString:@"月" withString:@""];
    didRow = [mouth intValue];
    [startTime release];  [endTime release];
    startTime = [[NSString stringWithFormat:@"%@-%02d-01",[dateArray objectAtIndex:didSection],[mouth intValue]] retain];
    endTime = [[NSString stringWithFormat:@"%@-%02d-30",[dateArray objectAtIndex:didSection],[mouth intValue]] retain];
    if ([showTask isEqualToString:@"1"]) {
        [self getMySendedTask:[DataCenter shareInstance].loginId startTime:startTime endTime:endTime];
        taskTitleField.text = @"";
        taskInfoView.text = @"";
        for (int i = 0; i<[accountArray count]; i++) {
            UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setSelected:NO];
        }
    } else {
        [self getMyAcceptTask:[DataCenter shareInstance].loginId startTime:startTime endTime:endTime];
        taskTitleField.text = @"";
        taskAccountName.text = @"";
        taskInfoView.text = @"";
        for (int i = 0; i<[accountArray count]; i++) {
            UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setSelected:NO];
        }
    }
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -260, 1024, 768);
    }];
    return YES;
}

-(BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }];
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length] == 0) {
        return ;
    }
    
    if (baseURL) {
        [baseURL release];
        baseURL = nil;
    }
    
    NSString *plistName = [NSString stringWithFormat:@"Config.plist"];
    // 创建本地Plist文件实现缓存
    NSString *plistPath = [Utils documentsPath:plistName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:dic attributes:nil];
        [dic release];
    }
    NSMutableDictionary *infoDictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    baseURL = [textField.text retain];
    
    if (textField.text.length != 0) {
        
        [infoDictionary setObject:baseURL forKey:@"service"];
        
        [infoDictionary writeToFile:plistPath atomically:YES];
    }
    
    NSLog(@"%@",baseURL);
    [[AFHttpRequestUtils shareInstance] setBaseUrl:baseURL];
    
    [infoDictionary release];
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
    [[userScroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [userScroll setContentSize:CGSizeMake(204, sendedView.frame.size.height)];
    [accountArray removeAllObjects];
    for (AccountModel *model in response.accountListResult) {
        [accountArray addObject:model];
    }
    
    UIButton *title = [UIButton buttonWithType:UIButtonTypeCustom];
    title.frame = CGRectMake(10, 20, 100, 30);
    [title setImage:[UIImage imageNamed:@"common_button_green_highlighted"] forState:UIControlStateNormal];
    [title setTitle:@"  已参与者" forState:UIControlStateNormal];
    [title setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [title.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    title.userInteractionEnabled = NO;
    [userScroll addSubview:title];
    
    for (int i = 0; i < [accountArray count]; i++) {
        AccountModel *model = accountArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10 + 97*(i%2), 60 + 40*(i/2), 87, 30);
        button.tag = 2000+i;
        [button.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [button setTitle:[model.peopleName stringByReplacingOccurrencesOfString:@" " withString:@""] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_check"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseAccount:) forControlEvents:UIControlEventTouchUpInside];
        [userScroll addSubview:button];
    }
    [userScroll setContentSize:CGSizeMake(204, 60 + 40*ceilf([accountArray count]/2.0))];
}

-(void) chooseAccount:(id) sender
{
    [sender setSelected:![sender isSelected]];
}

/*!
 *  获取我发布的任务
 *
 *  @param account 用户ID
 *  @param start   开始时间
 *  @param end     结束时间
 */
-(void) getMySendedTask:(NSString *)account startTime:(NSString *)start endTime:(NSString *)end
{
    GetMySendTaskListReqBody *reqBody = [[GetMySendTaskListReqBody alloc] init];
    reqBody.accountId = account;
    reqBody.startTime = start;
    reqBody.endTime = end;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_MYSENDTASKLIST];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetMySendTaskListRespBody *respBody = (GetMySendTaskListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_MYSENDTASKLIST];
        [self checkSendTaskList:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取当前时间段的我发布的任务失败，请重新获取.");
    }];
    
    [operation start];
    [operation release];
}

-(void) checkSendTaskList:(GetMySendTaskListRespBody *) response
{
    [taskArray removeAllObjects];
    if ([response.taskList count] == 0) {
        alertMessage(@"当前日期范围内暂无任务.");
        [sendTable reloadData];
        return ;
    }
    for (id obj in response.taskList) {
        [taskArray addObject:obj];
    }
    [sendTable reloadData];
}

/*!
 *  获取我接受的任务
 *
 *  @param account 用户ID
 *  @param start   开始时间
 *  @param end     结束时间
 */
-(void) getMyAcceptTask:(NSString *)account startTime:(NSString *)start endTime:(NSString *)end
{
    GetMyAcceptTaskListReqBody *reqBody = [[GetMyAcceptTaskListReqBody alloc] init];
    reqBody.accountId = account;
    reqBody.startTime = start;
    reqBody.endTime = end;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_MYACCEPTTASKLIST];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetMyAcceptTaskListRespBody *respBody = (GetMyAcceptTaskListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_MYACCEPTTASKLIST];
        [self checkAccpetTaskList:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取当前时间段的我的任务失败，请重新获取.");
    }];
    
    [operation start];
    [operation release];
}

-(void) checkAccpetTaskList:(GetMyAcceptTaskListRespBody *) response
{
    [acceptArray removeAllObjects];
    if ([response.taskAcceptList count] == 0) {
        alertMessage(@"当前日期范围内暂无任务.");
        [sendTable reloadData];
        return ;
    }
    for (id obj in response.taskAcceptList) {
        [acceptArray addObject:obj];
    }
    [sendTable reloadData];
}

/*!
 *  获取任务信息
 *
 *  @param taskid 任务ID
 */
-(void) getTaskInfo:(NSString *)taskid
{
    GetTaskInfoReqBody *reqBody = [[GetTaskInfoReqBody alloc] init];
    reqBody.taskid = [taskid stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TASKINFO];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetTaskInfoRespBody *respBody = (GetTaskInfoRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TASKINFO];
        [self checkTaskInfo:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，请重新获取任务详情.");
    }];
    
    [operation start];
    [operation release];
}

-(void) checkTaskInfo:(GetTaskInfoRespBody *) response
{
    if (!response.taskResult) {
        alertMessage(@"获取任务信息出错,请重新获取.");
        return ;
    }
    
    if ([response.taskResult count] == 0) {
        return ;
    }
    
    for (int i = 0; i < [accountArray count]; i++) {
        AccountModel *indexModel = [accountArray objectAtIndex:i];
        UIButton *btn = (UIButton *)[userScroll viewWithTag:2000+i];
        for (TaskModel *model in response.taskResult) {
            if ([[model.accountID stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:[indexModel.idAccoun stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                [btn setSelected:YES];
                if ([model.isAccept intValue] == 0) {
                    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
                } else {
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                }
                break ;
            } else {
                [btn setSelected:NO];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}

/*!
 *  获取我发布的视频
 *
 *  @param accound 用户ID
 *  @param byTime  是否根据时间来排序   YES:时间倒序  NO:点赞数倒序
 */
-(void) getMyTV:(NSString *) accound withTime:(BOOL)byTime
{
    if (byTime) {
        GetMyTVListOfTimeReqBody *reqBody = [[GetMyTVListOfTimeReqBody alloc] init];
        reqBody.accountId = [DataCenter shareInstance].loginId;
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_MYTVLIST_TIME];
        [reqBody release];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            GetMyTVListOfTimeRespBody *respBody = (GetMyTVListOfTimeRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_MYTVLIST_TIME];
            [self checkTVList:respBody];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"获取我的视频失败,请重新获取.");
        }];
        
        [operation start];
        [operation release];
    } else {
        GetMyTVListOfGoodCountReqBody *reqBody = [[GetMyTVListOfGoodCountReqBody alloc] init];
        reqBody.accountId = [DataCenter shareInstance].loginId;
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_MYTVLIST_GOODCOUNT];
        [reqBody release];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            GetMyTVListOfGoodCountRespBody *respBody = (GetMyTVListOfGoodCountRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_MYTVLIST_GOODCOUNT];
            [self checkTVList:respBody];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"获取我的视频失败,请重新获取.");
        }];
        
        [operation start];
        [operation release];
    }
}

-(void) checkTVList:(id) response
{
    
}

-(void) outLogin:(id)sender
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退出当前登录账号么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1005) {
        if (buttonIndex == 1) {
            NSLog(@"修改IP地址");
            return ;
        }
    }
    if (buttonIndex == 1) {
        NSLog(@"注销");
        [DataCenter shareInstance].isLogined = NO;
        [DataCenter shareInstance].loginId = @"";
        [DataCenter shareInstance].loginName = @"";
        [self.tabBarController setSelectedIndex:0];
    }
}

-(void) configBaseURL:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入服务器地址"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
    [alertView textFieldAtIndex:0].delegate = self;
    alertView.tag = 1005;
    [alertView show];
    [alertView release];
}

-(void) createInitView
{
//--------------------------------------------------------
//---------- 个人中心头部界面/高度为300  ---------------------
//--------------------------------------------------------
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 300)];
    headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headerView];
    [headerView release];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 260)];
    [bgView setImage:[UIImage imageNamed:@"personal_bj"]];
    [headerView addSubview:bgView];
    [bgView release];
    
    UIButton *outLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    outLogin.frame = CGRectMake(1024-60, 30, 40, 40);
    outLogin.backgroundColor = [UIColor clearColor];
    [outLogin setBackgroundImage:[UIImage imageNamed:@"tool_share"] forState:UIControlStateNormal];
    [outLogin setBackgroundImage:[UIImage imageNamed:@"tool_share_selected"] forState:UIControlStateHighlighted];
    [outLogin addTarget:self action:@selector(outLogin:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:outLogin];
    
    UIButton *config = [UIButton buttonWithType:UIButtonTypeCustom];
    config.frame = CGRectMake(1024-60, 80, 40, 40);
    config.backgroundColor = [UIColor clearColor];
    [config setBackgroundImage:[UIImage imageNamed:@"broadcast_icon_setting_normal"] forState:UIControlStateNormal];
    [config setBackgroundImage:[UIImage imageNamed:@"broadcast_icon_setting_pressed"] forState:UIControlStateHighlighted];
    [config addTarget:self action:@selector(configBaseURL:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:config];
    
    UIImageView *btnBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 260, 1024, 40)];
    [btnBgView setImage:[UIImage imageNamed:@"personal_bj2"]];
    [headerView addSubview:btnBgView];
    [btnBgView release];
    
    UIButton *sendTask = [UIButton buttonWithType:UIButtonTypeCustom];
    sendTask.frame = CGRectMake(15, headerView.frame.size.height - 35, 90, 30);
    sendTask.layer.cornerRadius = 3.0;
    [sendTask setTitle:@"我发布的任务" forState:UIControlStateNormal];
    [sendTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendTask.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [sendTask addTarget:self action:@selector(sendedTask:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sendTask];
    
    UIButton *newTask = [UIButton buttonWithType:UIButtonTypeCustom];
    newTask.frame = CGRectMake(sendTask.frame.size.width + sendTask.frame.origin.x + 10, headerView.frame.size.height - 35, 90, 30);
    newTask.layer.cornerRadius = 3.0;
    [newTask setTitle:@"我的任务" forState:UIControlStateNormal];
    [newTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newTask.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [newTask addTarget:self action:@selector(acceptedNewTask:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:newTask];
    
    UIButton *sendVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    sendVideo.frame = CGRectMake(newTask.frame.size.width + newTask.frame.origin.x + 10, headerView.frame.size.height - 35, 90, 30);
    sendVideo.layer.cornerRadius = 3.0;
    [sendVideo setTitle:@"我的视频" forState:UIControlStateNormal];
    [sendVideo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendVideo.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [sendVideo addTarget:self action:@selector(sendedVideo:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sendVideo];
    
    submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(headerView.frame.size.width - 105, headerView.frame.size.height - 35, 90, 30);
    submit.layer.cornerRadius = 3.0;
    [submit setTitle:@"立即发布任务" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [submit addTarget:self action:@selector(submitTask:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:submit];
    
    userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    userIcon.layer.cornerRadius = userIcon.frame.size.height/2.0f;
    userIcon.clipsToBounds = YES;
    userIcon.layer.borderWidth = 2.0;
    userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    [userIcon setImage:[UIImage imageNamed:@"take_photo"]];
    userIcon.center = CGPointMake(headerView.frame.size.width/2.0f - 60, headerView.frame.size.height/2.0f - 30);
    [headerView addSubview:userIcon];
    [userIcon release];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.frame.size.width + userIcon.frame.origin.x + 10, userIcon.frame.origin.y + 20, 200, 25)];
    nameLabel.text = @"未登录";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:19.0f];
    [headerView addSubview:nameLabel];
    [nameLabel release];
    
//-------------------------------------------------------
//---------- 三块位置占比 215:615:215 ---------------------
//-------------------------------------------------------
    sendedView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, 1024, 710 - headerView.frame.size.height)];
    sendedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sendedView];
    [sendedView release];
    
    sendTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 205, sendedView.frame.size.height) style:UITableViewStylePlain];
    sendTable.showsVerticalScrollIndicator = NO;
    sendTable.backgroundColor = [UIColor getColor:@"E4E4E4"];
    sendTable.delegate = self;
    sendTable.dataSource = self;
    sendTable.separatorInset = UIEdgeInsetsZero;
    sendTable.separatorColor = [UIColor clearColor];
    [sendedView addSubview:sendTable];
    [sendTable release];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(sendTable.frame.size.width + 50, 30, 100, 20)];
    name.text = @"任务名称:";
    name.textAlignment = NSTextAlignmentRight;
    name.textColor = [UIColor blackColor];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:name];
    [name release];
    
    titleRect = [[UIImageView alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 15, name.frame.origin.y - 5, 250, 30)];
    titleRect.layer.borderWidth = 1.0;
    titleRect.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [sendedView addSubview:titleRect];
    [titleRect release];
    
    taskTitleField = [[UITextField alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 19, name.frame.origin.y - 5, 242, 30)];
    taskTitleField.text = @"";
    [taskTitleField setFont:[UIFont systemFontOfSize:15.0f]];
    taskTitleField.borderStyle = UITextBorderStyleNone;
    [sendedView addSubview:taskTitleField];
    [taskTitleField release];
    
    taskAccount = [[UILabel alloc] initWithFrame:CGRectMake(sendTable.frame.size.width + 50, name.frame.origin.y + name.frame.size.height + 20, 100, 20)];
    [taskAccount setHidden:YES];
    taskAccount.text = @"任务发布者:";
    taskAccount.textAlignment = NSTextAlignmentRight;
    taskAccount.textColor = [UIColor blackColor];
    taskAccount.backgroundColor = [UIColor clearColor];
    taskAccount.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:taskAccount];
    [taskAccount release];
    
    taskAccountName = [[UILabel alloc] initWithFrame:CGRectMake(taskAccount.frame.origin.x + taskAccount.frame.size.width + 15, taskAccount.frame.origin.y, 242, 20)];
    [taskAccountName setHidden:YES];
    taskAccountName.text = @"";
    taskAccountName.textColor = [UIColor blackColor];
    taskAccountName.backgroundColor = [UIColor clearColor];
    taskAccountName.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:taskAccountName];
    [taskAccountName release];
    
    taskInfo = [[UILabel alloc] initWithFrame:CGRectMake(sendTable.frame.size.width + 50, taskAccount.frame.origin.y + taskAccount.frame.size.height + 20, 100, 20)];
    taskInfo.text = @"任务脚本内容:";
    taskInfo.textAlignment = NSTextAlignmentRight;
    taskInfo.textColor = [UIColor blackColor];
    taskInfo.backgroundColor = [UIColor clearColor];
    taskInfo.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:taskInfo];
    [taskInfo release];
    
    taskInfoView = [[UITextView alloc] initWithFrame:CGRectMake(taskInfo.frame.origin.x + taskInfo.frame.size.width + 15, taskInfo.frame.origin.y - 8, 400, 200)];
    taskInfoView.text = @"";
    taskInfoView.delegate = self;
    taskInfoView.layer.borderWidth = 1.0;
    taskInfoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [taskInfoView setFont:[UIFont systemFontOfSize:15.0]];
    [sendedView addSubview:taskInfoView];
    [taskInfoView release];
    
    userScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(1024 - 204, 0, 204, sendedView.frame.size.height)];
    userScroll.backgroundColor = [UIColor getColor:@"E4E4E4"];
    [sendedView addSubview:userScroll];
    [userScroll release];
    
    sendTask.backgroundColor = [UIColor brownColor];
    newTask.backgroundColor = [UIColor brownColor];
    sendVideo.backgroundColor = [UIColor brownColor];
    submit.backgroundColor = [UIColor brownColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(240, 160)];
    //    [layout setMinimumInteritemSpacing:1];
    [layout setMinimumLineSpacing:10.0f];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    waterView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, 1024, 710 - headerView.frame.size.height) collectionViewLayout:layout];
    waterView.delegate = self;
    waterView.dataSource = self;
    waterView.showsVerticalScrollIndicator = NO;
    [waterView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"myTVList"];
    waterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:waterView];
    [layout release];
    [waterView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [accountArray release];
    [dateArray release];
    [taskArray release];
    [accountArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateInfo" object:nil];
    [super dealloc];
}

@end
