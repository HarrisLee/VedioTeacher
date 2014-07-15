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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    VerifyLoginReqBody *req = [[VerifyLoginReqBody alloc] init];
//    req.password = @"123456";
//    req.name = @"123456";
//    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:req andReqType:VERITY_LOGIN];
//    [req release];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        VerifyLoginRespBody *respBody = (VerifyLoginRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:VERITY_LOGIN];
//        [self checkDataLogin:respBody];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error : %@", [error localizedDescription]);
//        alertMessage(@"请求失败，获取二级目录目录失败.");
//    }];
//
//    [operation start];
//    [operation release];
    
//    AddAccountReqBody *requs = [[AddAccountReqBody alloc] init];
//    requs.accountName = @"123456";
//    requs.accountPassword = @"123456";
//    requs.peopleName = @"haha";
//    requs.peopleJob = @"Jobs";
//    requs.peopleMobileNo = @"15152569200";
//    NSMutableURLRequest *ust = [[AFHttpRequestUtils shareInstance] requestWithBody:requs andReqType:ADD_ACCOUNT];
//    [requs release];
//    
//    AFHTTPRequestOperation *operations = [[AFHTTPRequestOperation alloc] initWithRequest:ust];
//    [operations setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        AddAccountRespBody *respBody = (AddAccountRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_ACCOUNT];
//        [self checkDatas:respBody];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error : %@", [error localizedDescription]);
//        alertMessage(@"请求失败，获取二级目录目录失败.");
//    }];
//    
//    [operations start];
//    [operations release];
    
    
    
    
    secArray = [[NSMutableArray alloc] init];
    
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
    
    self.view.backgroundColor = [UIColor redColor];
}

-(void) checkDataLogin:(VerifyLoginRespBody *) response
{
    NSLog(@"%@",response.userId);
}

-(void) checkDatas:(AddAccountRespBody *)response
{
    NSLog(@"%@",response.result);
}

-(void) checkData:(GetSecondDirectoryRespBody *)response
{
    NSLog(@"%@",response.sDirectoryArray);
}

-(BOOL) addSecDir:(id)sender
{
    BOOL tag = [super addSecDir:sender];
    
    if (!tag) {
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
    if (buttonIndex == 1) {   //创建相册
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
//    [secArray addObject:model];
//    [serviceArray addObject:model];
//    [model release];
//    [dirTable reloadData];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    dirName = [textField.text retain];
    NSLog(@"%@",dirName);
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
