//
//  UploadViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()
{
    UIView *uView;
}
@end

//(1024*1024*2)=2097152   上传视频时，如果视频过大，已固定大小分段上传
#define kConstLeng   2097152

@implementation UploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor getColor:@"E4E4E4"];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationItem.rightBarButtonItems = nil;
    
    selectType = 1;
    fileCount = 0;
    errorCount = 0;
    sendType = @"1";
    secondArray = [[NSMutableArray alloc] init];
    taskArray = [[NSMutableArray alloc] init];
    uploadArray = [[NSMutableArray alloc] init];
    fileArray = [[NSMutableArray alloc] init];
    
    [self setUpInitView];
    
    GetMyExecuteTaskListReqBody *reqBody = [[GetMyExecuteTaskListReqBody alloc] init];
    reqBody.accountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_EXECUTETASK];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetMyExecuteTaskListRespBody *respBody = (GetMyExecuteTaskListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_EXECUTETASK];
        [self checkTask:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取二级目录失败.");
    }];
    
    [operation start];
    [operation release];
    
}

-(void) checkTask:(GetMyExecuteTaskListRespBody *)response
{
    NSLog(@"%@",response.taskArray);
    if ([response.taskArray count] == 0) {
        return ;
    }
    [taskArray removeAllObjects];
    for (TaskModel *model in response.taskArray) {
        [taskArray addObject:model];
    }
}

#pragma mark ---------------------------------
#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"取消选择");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";
}

- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return [NSString stringWithFormat:@"图片%d张", numberOfPhotos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"视频%d", numberOfVideos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"图片%d 视频%d", numberOfPhotos, numberOfVideos];
}

/**
 *  多选视频的代理方法。在这里进行选择，上传等一系列操作
 */
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    if(imagePickerController.allowsMultipleSelection) {
        NSArray *mediaInfoArray = (NSArray *)info;
        [self dismissViewControllerAnimated:YES completion:^{
            [self uploadVedioWith:mediaInfoArray];
        }];
        NSLog(@"Selected %d vedio and mediaInfoArray==%@", mediaInfoArray.count,mediaInfoArray);
    } else {
        NSDictionary *mediaInfo = (NSDictionary *)info;
        NSLog(@"Selected: %@", mediaInfo);
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }
}

-(void) uploadVedioWith:(NSArray *)mediaInfoArray
{
    errorCount = 0;
    finishCount = 0;
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"视频上传中...";
    [HUD show:YES];
    UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actView.frame = CGRectMake(502, (768 - 20)/2-11, 20, 20);
    [actView startAnimating];
    [HUD addSubview:actView];
    [actView release];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    int writeCount = 0;
    [fileArray removeAllObjects];
    
    for (ALAsset *asset in mediaInfoArray) {
        writeCount ++ ;
        NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:[[asset defaultRepresentation] filename]];
        if ([Utils writeDataToPath:documentsDirectory andAsset:asset]) {
            [fileArray addObject:documentsDirectory];
        }
        if ([mediaInfoArray count] == writeCount) {
            fileCount = 0;
            [self upLoadImageWithSort:fileCount];
        }
    }
}

-(void) upLoadImageWithSort:(NSInteger)repeat
{
    if ([fileArray count] == 0 || fileCount >= [fileArray count]) {
        [HUD hide:YES];
        fileCount = 0;
        errorCount = 0;
        residueSize = 0;
        sendCount = 0;
        totalCount = 0;
        for (NSString *path in fileArray) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        [fileArray removeAllObjects];
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }

    NSError *error = nil;
    NSData *fileData = [NSData dataWithContentsOfFile:[fileArray objectAtIndex:repeat] options:NSDataReadingMappedIfSafe error:&error];
    if (error) {
        NSLog(@"error %@",[error localizedDescription]);
        fileCount ++;
        [self upLoadImageWithSort:fileCount];
        return ;
    }
    
    //当视频小于2M的时候 直接完全上传  否则调用下面的方法
    if ([fileData length] <= kConstLeng) {
        NSString *idSec = [selectModel.idSecondDirectory stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self uploadVedioWithUserId:[DataCenter shareInstance].loginId idSecondDirectory:idSec path:[fileArray objectAtIndex:repeat] describeTV:coverRemark.text fs:[fileData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] taskName:relevanceField.text vedioName:vedioNameField.text];
        return ;
    }
    sendCount = 0;
    sendType = @"1";
    residueSize = [fileData length]%kConstLeng;
    totalCount = [fileData length]/kConstLeng;
    
    NSString *idSec = [selectModel.idSecondDirectory stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self transTvFile:[DataCenter shareInstance].loginId idSecondDirectory:idSec path:[fileArray objectAtIndex:fileCount] describeTV:coverRemark.text fs:nil taskName:relevanceField.text vedioName:vedioNameField.text ifCreate:sendType TVFileName:tvfileNameContinue tvPicName:tvPicNameContinue];
    
    return ;
}


-(void) transTvFile:(NSString *)userId idSecondDirectory:(NSString *)idSecondDirectory path:(NSString *)path describeTV:(NSString *)describe fs:(NSString *)fs taskName:(NSString *)taskName vedioName:(NSString *)vedioName ifCreate:(NSString *)ifCreate TVFileName:(NSString *)tvFileName tvPicName:(NSString *)tvPicName
{
    TransTVFileReqBody *upreqBody = [[TransTVFileReqBody alloc] init];
    
    upreqBody.idSecondDirectory = idSecondDirectory;
    
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *file = [path substringFromIndex:range.location+1];
    
    upreqBody.nameTV = [NSString stringWithFormat:@"%@_%d_%@",vedioName,fileCount,file];
    
    upreqBody.describeTV = describe;
    
    upreqBody.addAccountId = userId;
    
    NSError *error = nil;
    NSData *fileData = [NSData dataWithContentsOfFile:[fileArray objectAtIndex:fileCount] options:NSDataReadingMappedIfSafe error:&error];
    if (error) {
        NSLog(@"error %@",[error localizedDescription]);
        [upreqBody release];
        fileCount ++;
        [self upLoadImageWithSort:fileCount];
        return ;
    }
    
    if ([sendType isEqualToString:@"1"] || [sendType isEqualToString:@"2"]) {
        NSString *data = [[fileData subdataWithRange:NSMakeRange(kConstLeng * sendCount, kConstLeng)] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        upreqBody.fs = data;
    } else {
        NSString *data = [[fileData subdataWithRange:NSMakeRange(kConstLeng * totalCount, residueSize)] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        upreqBody.fs = data;
    }

    upreqBody.ifCreate = ifCreate;
    
    upreqBody.TVfileName = tvFileName ? tvFileName : @"";
    
    upreqBody.tvPicfileName = tvPicName ? tvPicName : @"";
    
    if ([taskName length] == 0) {
        upreqBody.idTask = @"0";
    } else {
        upreqBody.idTask = [taskModel.taskID stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    NSMutableURLRequest *requestUp = [[AFHttpRequestUtils shareInstance] requestWithBody:upreqBody andReqType:TRANSTV_FILE];
    
    [upreqBody release];
    
    AFHTTPRequestOperation *theOperationUp = [[AFHTTPRequestOperation alloc] initWithRequest:requestUp];
    [theOperationUp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){
        
        TransTVFileRespBody *respBody = (TransTVFileRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:TRANSTV_FILE];
        
        [self TVFileCheckSuccess:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        NSLog(@"Error : %@",[error localizedDescription]);
        [self TVFileCheckFile:error];
        
    }];
    [theOperationUp start];
    [theOperationUp release];
}

-(void) TVFileCheckSuccess:(TransTVFileRespBody *)response
{
    if ([response.result isEqualToString:@"0"]) {
        sendType = @"1";
        HUD.progress = ((float)fileCount)/fileArray.count;
        fileCount ++ ;
        errorCount ++;
        [self upLoadImageWithSort:fileCount];
        if (fileCount == [fileArray count] && errorCount > 0) {
            alertMessage(@"有视频上传失败。");
        }
        return ;
    }
    
    NSString *idSec = [selectModel.idSecondDirectory stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([sendType isEqualToString:@"3"]) {
        fileCount ++ ;
        [self upLoadImageWithSort:fileCount];
    } else if ([sendType isEqualToString:@"1"]) {
        NSArray *array = [response.result componentsSeparatedByString:@"|"];
        [tvfileNameContinue release]; [tvPicNameContinue release];
        tvfileNameContinue = [[[array objectAtIndex:0] substringFromIndex:1] retain];
        tvPicNameContinue = [[array objectAtIndex:1] retain];
        sendType = @"2";
        NSString *data = nil;
        sendCount ++ ;  //1
        [self transTvFile:[DataCenter shareInstance].loginId idSecondDirectory:idSec path:[fileArray objectAtIndex:fileCount] describeTV:coverRemark.text fs:data taskName:relevanceField.text vedioName:vedioNameField.text ifCreate:sendType TVFileName:tvfileNameContinue tvPicName:tvPicNameContinue];
        HUD.progress = ((float)fileCount)/fileArray.count  + ((float)sendCount)/totalCount/fileArray.count;
    } else {
        if (sendCount < totalCount) {
            //继续发送
            sendType = @"2";
            NSString *data = nil;
            sendCount ++ ;  //2.3
            [self transTvFile:[DataCenter shareInstance].loginId idSecondDirectory:idSec path:[fileArray objectAtIndex:fileCount] describeTV:coverRemark.text fs:data taskName:relevanceField.text vedioName:vedioNameField.text ifCreate:sendType TVFileName:tvfileNameContinue tvPicName:tvPicNameContinue];
            HUD.progress = ((float)fileCount)/fileArray.count + ((float)sendCount)/totalCount/fileArray.count;
        } else if (sendCount == totalCount) {
            if (residueSize == 0) {
                sendType = @"1";
                fileCount ++ ;
                [self upLoadImageWithSort:fileCount];
            } else {
                sendType = @"3";
                NSString *data = nil;
                [self transTvFile:[DataCenter shareInstance].loginId idSecondDirectory:idSec path:[fileArray objectAtIndex:fileCount] describeTV:coverRemark.text fs:data taskName:relevanceField.text vedioName:vedioNameField.text ifCreate:sendType TVFileName:tvfileNameContinue tvPicName:tvPicNameContinue];
            }
        }
    }
}

-(void) TVFileCheckFile:(NSError *)error
{
    sendType = @"1";
    HUD.progress = ((float)fileCount)/fileArray.count;
    fileCount ++ ;
    [self upLoadImageWithSort:fileCount];
    errorCount ++;
    if (fileCount == [fileArray count] && errorCount > 0) {
        alertMessage(@"有视频上传失败。");
    }
}


-(void) uploadVedioWithUserId:(NSString *)userId idSecondDirectory:(NSString *)idSecondDirectory path:(NSString *)path describeTV:(NSString *)describe fs:(NSString *)fs taskName:(NSString *)taskName vedioName:(NSString *)vedioName
{
    sendType = @"1";
    
    UploadTVFileReqBody *upreqBody = [[UploadTVFileReqBody alloc] init];
    
    upreqBody.idSecondDirectory = idSecondDirectory;
    
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *file = [path substringFromIndex:range.location+1];
    
    upreqBody.nameTV = [NSString stringWithFormat:@"%@_%d_%@",vedioName,fileCount,file];
    
    upreqBody.describeTV = describe;
    
    upreqBody.addAccountId = userId;
    
    upreqBody.fs = fs;
    
    if ([taskName length] == 0) {
        upreqBody.idTask = @"0";
    } else {
        upreqBody.idTask = [taskModel.taskID stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    NSMutableURLRequest *requestUp = [[AFHttpRequestUtils shareInstance] requestWithBody:upreqBody andReqType:UPLOAD_TVFILE];
    
    [upreqBody release];
    
    AFHTTPRequestOperation *theOperationUp = [[AFHTTPRequestOperation alloc] initWithRequest:requestUp];
    [theOperationUp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){
        
        UploadTVFileRespBody *respBody = (UploadTVFileRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:UPLOAD_TVFILE];

        [self reloadWaterView:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        NSLog(@"Error : %@",[error localizedDescription]);
        [self uploadFail:error];
        
    }];
    [theOperationUp start];
    [theOperationUp release];
}

-(void) reloadWaterView:(UploadTVFileRespBody *)respBody
{
    fileCount ++;
    HUD.progress = ((float)fileCount)/fileArray.count;
    if ([@"\"0\"" isEqualToString:respBody.result]) {
        [self upLoadImageWithSort:fileCount];
        errorCount ++;
        if (fileCount == [fileArray count] && errorCount > 0) {
            alertMessage(@"有视频上传失败。");
        }
        return ;
    }
    
    [self upLoadImageWithSort:fileCount];
}

-(void) uploadFail:(NSError *)error
{
    fileCount ++;
    errorCount ++;
    HUD.progress = ((float)fileCount)/fileArray.count;
    [self upLoadImageWithSort:fileCount];
    if (fileCount == [fileArray count] && errorCount > 0) {
        alertMessage(@"有视频上传失败。");
    }
}

#pragma mark ---------------------------------
#pragma mark UITextFieldDelegate/UITextViewDelegate

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == top1Field) {
        selectType = 1;
        top2Field.text = @"";
        [dropView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            [dropView setHidden:NO];
            dropView.frame = CGRectMake(105, top1Field.frame.origin.y + 25, 200, 25*6);
        }];
    } else if(textField == top2Field) {
        if ([secondArray count] == 0) {
            return NO;
        }
        selectType = 2;
        [dropView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            [dropView setHidden:NO];
            dropView.frame = CGRectMake(105, top2Field.frame.origin.y + 25, 200, 25*([secondArray count] > 6 ? 6 : [secondArray count]));
        }];
    } else {
        if ([taskArray count] == 0) {
            return NO;
        }
        selectType = 3;
        [dropView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            [dropView setHidden:NO];
            dropView.frame = CGRectMake(105, relevanceField.frame.origin.y + 25, 200, 25*([taskArray count] > 6 ? 6 : [taskArray count]));
        }];
    }
    return NO;
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        uView.frame = CGRectMake(600, -150,  400, 768 - 112);
    }];
    return YES;
}

-(BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        uView.frame = CGRectMake(600, 24,  400, 768 - 112);
    }];
    return YES;
}

-(void) pickerCoverImage:(UITapGestureRecognizer *) tap
{
    NSLog(@"select image");
}

-(void) chooseFile:(id) sender
{
    if ([top1Field.text length] == 0 || [top2Field.text length] == 0 || [vedioNameField.text length]==0 || [coverRemark.text length] == 0) {
        alertMessage(@"您的上传信息尚未输入完整，请先输入！");
        return ;
    }
    
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.filterType = QBImagePickerFilterTypeAllVideos;
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    navigationController.navigationBar.tintColor = [UIColor blackColor];
    navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [self presentViewController:navigationController animated:YES completion:NULL];
    [imagePickerController release];
    [navigationController release];
}

-(void) submitFile:(id) sender
{
    NSLog(@"submite file");
    [uploadArray removeAllObjects];
    [fileArray removeAllObjects];
}

#pragma mark ---------------------------------
#pragma mark UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (selectType) {
        case 1:
            return [[DataCenter shareInstance].topDirectory count];
            break;
        case 2:
            return [secondArray count];
        default:
            return [taskArray count];
            break;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    switch (selectType) {
        case 1:
        {
            FDirectoryModel *model = [[DataCenter shareInstance].topDirectory objectAtIndex:indexPath.row];
            cell.textLabel.text = model.nameTopDirectory;
        }
            break;
        case 2:
        {
            SDirectoryModel *model = [secondArray objectAtIndex:indexPath.row];
            cell.textLabel.text = model.nameSecondDirectory;
        }
            break;
        default:
        {
            TaskModel *model = [taskArray objectAtIndex:indexPath.row];
            cell.textLabel.text = model.taskName;
        }
            break;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [dropView setHidden:YES];
    if (selectType == 1) {
        //获取二级目录
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        if ([cell.textLabel.text isEqualToString:top1Field.text]) {
            return ;
        }
        FDirectoryModel *model = [[DataCenter shareInstance].topDirectory objectAtIndex:indexPath.row];
        top1Field.text = model.nameTopDirectory;
        [secondArray removeAllObjects];
        GetSecondDirectoryReqBody *req = [[GetSecondDirectoryReqBody alloc] init];
        req.idTopDirectory = model.idTopDirectory;
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
    } else if(selectType == 2){
        [selectModel release];
        selectModel = [[secondArray objectAtIndex:indexPath.row] retain];
        top2Field.text = selectModel.nameSecondDirectory;
    } else {
        [taskModel release];
        taskModel = [[taskArray objectAtIndex:indexPath.row] retain];
        relevanceField.text = taskModel.taskName;
    }
}

-(void) checkData:(GetSecondDirectoryRespBody *)response
{
    NSLog(@"%d",[response.sDirectoryArray count]);
    if ([response.sDirectoryArray count] == 0) {
        alertMessage(@"该主目录下没有二级目录，请重新选择");
        return;
    }
    
    for (SDirectoryModel *model in response.sDirectoryArray) {
        [secondArray addObject:model];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void) setUpInitView
{
    uView = [[UIView alloc] initWithFrame:CGRectMake(600, 24,  400, 768 - 112)];
    [uView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:uView];
    [uView release];
    
    UIImageView *ver = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 2, 15)];
    ver.backgroundColor = [UIColor getColor:@"2E9CFC"];
    [uView addSubview:ver];
    [ver release];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 15)];
    name.text = @"编辑视频文件信息";
    name.font = [UIFont boldSystemFontOfSize:15.0];
    [uView addSubview:name];
    [name release];
    
    ver = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 390, 1)];
    ver.backgroundColor = [UIColor lightGrayColor];
    [uView addSubview:ver];
    [ver release];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(15, ver.frame.origin.y + 15, 80, 15)];
    name.text = @"关联目录:";
    name.textAlignment = NSTextAlignmentRight;
    name.font = [UIFont systemFontOfSize:13.0f];
    [uView addSubview:name];
    [name release];
    
    top1Field = [[UITextField alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, name.frame.origin.y-5, 200, 25)];
    top1Field.placeholder = @"请选择一级目录";
    top1Field.layer.borderColor = [UIColor lightGrayColor].CGColor;
    top1Field.layer.borderWidth = 1.0f;
    top1Field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    top1Field.delegate = self;
    [top1Field setFont:[UIFont systemFontOfSize:13.0f]];
    [uView addSubview:top1Field];
    [top1Field release];
    
    top2Field = [[UITextField alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, name.frame.origin.y - 5 + 35, 200, 25)];
    top2Field.placeholder = @"请选择二级目录";
    top2Field.layer.borderColor = [UIColor lightGrayColor].CGColor;
    top2Field.layer.borderWidth = 1.0f;
    top2Field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    top2Field.delegate = self;
    [top2Field setFont:[UIFont systemFontOfSize:13.0f]];
    [uView addSubview:top2Field];
    [top2Field release];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(15, top2Field.frame.origin.y + 40, 80, 15)];
    name.text = @"关联任务:";
    name.textAlignment = NSTextAlignmentRight;
    name.font = [UIFont systemFontOfSize:13.0f];
    [uView addSubview:name];
    [name release];
    
    relevanceField = [[UITextField alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, name.frame.origin.y-5, 200, 25)];
    relevanceField.placeholder = @"请选择关联任务";
    relevanceField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    relevanceField.layer.borderWidth = 1.0f;
    relevanceField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    relevanceField.delegate = self;
    [relevanceField setFont:[UIFont systemFontOfSize:13.0f]];
    [uView addSubview:relevanceField];
    [relevanceField release];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(15, relevanceField.frame.origin.y + 40, 80, 15)];
    name.text = @"视频名称:";
    name.textAlignment = NSTextAlignmentRight;
    name.font = [UIFont systemFontOfSize:13.0f];
    [uView addSubview:name];
    [name release];
    
    vedioNameField = [[UITextField alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, name.frame.origin.y-5, 200, 25)];
    vedioNameField.placeholder = @"请输入视频名称";
    vedioNameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    vedioNameField.layer.borderWidth = 1.0f;
    vedioNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [vedioNameField setFont:[UIFont systemFontOfSize:13.0f]];
    [uView addSubview:vedioNameField];
    [vedioNameField release];
    
/*   封面控件去除
    name = [[UILabel alloc] initWithFrame:CGRectMake(15, vedioNameField.frame.origin.y + 40, 80, 15)];
    name.text = @"视频封面:";
    name.textAlignment = NSTextAlignmentRight;
    name.font = [UIFont systemFontOfSize:13.0f];
    [uView addSubview:name];
    [name release];
    
    coverView = [[UIImageView alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, name.frame.origin.y-5, 160, 200)];
    coverView.userInteractionEnabled = YES;
    coverView.backgroundColor = [UIColor brownColor];
    [uView addSubview:coverView];
    [coverView release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerCoverImage:)];
    [coverView addGestureRecognizer:tap];
    [tap release];
*/
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(15, coverView.frame.origin.y + 215, 80, 15)];
    name.text = @"视频简介:";
    name.textAlignment = NSTextAlignmentRight;
    name.font = [UIFont systemFontOfSize:13.0f];
    [uView addSubview:name];
    [name release];
    
    coverRemark = [[UITextView alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, name.frame.origin.y-5, 200, 200)];
    coverRemark.layer.borderColor = [UIColor lightGrayColor].CGColor;
    coverRemark.layer.borderWidth = 1.0f;
    [coverRemark setFont:[UIFont systemFontOfSize:13.0f]];
    coverRemark.delegate = self;
    [uView addSubview:coverRemark];
    [coverRemark release];
    
    dropView = [[UITableView alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 10, top1Field.frame.origin.y + 25, 200, 25*6) style:UITableViewStylePlain];
    dropView.delegate = self;
    dropView.dataSource = self;
    dropView.bounces = NO;
    dropView.separatorInset = UIEdgeInsetsZero;
    [dropView setHidden:YES];
    [uView addSubview:dropView];
    [dropView release];
    
    UIButton *fileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fileBtn setTitle:@"选择文件" forState:UIControlStateNormal];
    fileBtn.layer.cornerRadius = 4.0f;
    [fileBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fileBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    fileBtn.frame = CGRectMake(coverRemark.frame.origin.x, coverRemark.frame.origin.y + 215, 200, 35);
    [fileBtn setBackgroundColor:[UIColor getColor:@"155AC3"]];
    [fileBtn addTarget:self action:@selector(chooseFile:) forControlEvents:UIControlEventTouchUpInside];
    [uView addSubview:fileBtn];
    
//    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
//    [submit setTitle:@"立即上传" forState:UIControlStateNormal];
//    submit.layer.cornerRadius = 4.0f;
//    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [submit.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
//    submit.frame = CGRectMake(coverRemark.frame.origin.x + 100, coverRemark.frame.origin.y + 215, 70, 35);
//    [submit setBackgroundColor:[UIColor getColor:@"155AC3"]];
//    [submit addTarget:self action:@selector(submitFile:) forControlEvents:UIControlEventTouchUpInside];
//    [uView addSubview:submit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [selectModel release];
    [taskModel release];
    [super dealloc];
}

@end
