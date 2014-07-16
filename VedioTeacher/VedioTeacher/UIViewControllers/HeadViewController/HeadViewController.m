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
    serviceArray = [[NSMutableArray alloc] init];
    
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
    [serviceArray addObject:model];
    [model release];
//    [dirTable reloadData];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    dirName = [textField.text retain];
    NSLog(@"%@",dirName);
}

-(void) goBackViewController:(id)sender
{
    NSLog(@"don't go preview");
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
