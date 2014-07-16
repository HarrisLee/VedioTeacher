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
    
    selectType = 1;
    secondArray = [[NSMutableArray alloc] init];
    taskArray = [[NSMutableArray alloc] init];
    
    [self setUpInitView];
    
    GetMyExecuteTaskListReqBody *reqBody = [[GetMyExecuteTaskListReqBody alloc] init];
    reqBody.accountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_EXECUTETASK];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetMyExecuteTaskListRespBody *respBody = (GetMyExecuteTaskListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_EXECUTETASK];
        [self checkTask:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取二级目录目录失败.");
    }];
    
    [operation start];
    [operation release];
    
}

-(void) checkTask:(GetMyExecuteTaskListRespBody *)response
{
    NSLog(@"%@",response.taskArray);
}

#pragma mark ---------------------------------
#pragma mark QBImagePickerControllerDelegate

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
        selectType = 2;
        [dropView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            [dropView setHidden:NO];
            dropView.frame = CGRectMake(105, top2Field.frame.origin.y + 25, 200, 25*([secondArray count] > 6 ? 6 : [secondArray count]));
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
    NSLog(@"choose file");
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
            
            cell.textLabel.text = @"1";
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
        FDirectoryModel *model = [[DataCenter shareInstance].topDirectory objectAtIndex:indexPath.row];
        top1Field.text = model.nameTopDirectory;
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
        SDirectoryModel *model = [secondArray objectAtIndex:indexPath.row];
        top2Field.text = model.nameSecondDirectory;
    } else {
        
        relevanceField.text = @"111";
    }
}

-(void) checkData:(GetSecondDirectoryRespBody *)response
{
    NSLog(@"%d",[response.sDirectoryArray count]);
    if ([response.sDirectoryArray count] == 0) {
        alertMessage(@"该主目录下没有二级目录，请重新选择");
        return;
    }
    
    [secondArray removeAllObjects];
    for (SDirectoryModel *model in response.sDirectoryArray) {
        [secondArray addObject:model];
    }
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
    
/*   封面空间去除
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
    fileBtn.frame = CGRectMake(coverRemark.frame.origin.x, coverRemark.frame.origin.y + 215, 70, 35);
    [fileBtn setBackgroundColor:[UIColor getColor:@"155AC3"]];
    [fileBtn addTarget:self action:@selector(chooseFile:) forControlEvents:UIControlEventTouchUpInside];
    [uView addSubview:fileBtn];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [submit setTitle:@"立即上传" forState:UIControlStateNormal];
    submit.layer.cornerRadius = 4.0f;
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    submit.frame = CGRectMake(coverRemark.frame.origin.x + 100, coverRemark.frame.origin.y + 215, 70, 35);
    [submit setBackgroundColor:[UIColor getColor:@"155AC3"]];
    [submit addTarget:self action:@selector(submitFile:) forControlEvents:UIControlEventTouchUpInside];
    [uView addSubview:submit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
