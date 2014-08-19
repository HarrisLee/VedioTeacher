//
//  LoginsViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-15.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "LoginsViewController.h"

@interface LoginsViewController ()

@end

@implementation LoginsViewController

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
    [self createLoginView];
    [self createRegisterView];
}

-(void)createLoginView
{
    loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 512, 320)];
    loginView.backgroundColor = [UIColor getColor:@"E8E7ED"];
    [self.view addSubview:loginView];
    [loginView release];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 512, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:17.0f];
    title.text = @"登录";
    title.textColor = [UIColor blackColor];
    [loginView addSubview:title];
    [title release];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.frame = CGRectMake(0, 0, 60, 40);
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor getColor:@"3FA6FF"] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancleLogin:) forControlEvents:UIControlEventTouchUpInside];
    [cancle.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [loginView addSubview:cancle];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((512-390)/2, 50, 390, 75)];
    bgView.layer.cornerRadius = 4.0;
    bgView.backgroundColor = [UIColor whiteColor];
    [loginView addSubview:bgView];
    [bgView release];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake((512-390)/2 + 5, 55, 380, 35)];
    nameField.placeholder = @"账号";
    nameField.font = [UIFont systemFontOfSize:15.0f];
    nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [loginView addSubview:nameField];
    [nameField release];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake((512-390)/2 + 5, 90, 380, 35)];
    passwordField.placeholder = @"密码";
    passwordField.secureTextEntry = YES;
    passwordField.font = [UIFont systemFontOfSize:15.0f];
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [loginView addSubview:passwordField];
    [passwordField release];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake((512-390)/2, 140, 390, 35);
    login.layer.cornerRadius = 5.0f;
    [login setBackgroundColor:[UIColor getColor:@"3FA6FF"]];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [login addTarget:self action:@selector(loginInService:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:login];
    
    UIButton *regsiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regsiBtn.frame = CGRectMake(150, 180, 100, 35);
    [regsiBtn setBackgroundColor:[UIColor clearColor]];
    [regsiBtn setTitleColor:[UIColor getColor:@"3FA6FF"] forState:UIControlStateNormal];
    [regsiBtn setTitle:@"注册账户" forState:UIControlStateNormal];
    [regsiBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [regsiBtn addTarget:self action:@selector(goRegisterView:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:regsiBtn];
    
    UIImageView *hor = [[UIImageView alloc] initWithFrame:CGRectMake(255, 190, 1, 15)];
    hor.backgroundColor = [UIColor lightGrayColor];
    [loginView addSubview:hor];
    [hor release];
    
    UIButton *forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPass.frame = CGRectMake(260, 180, 100, 35);
    [forgetPass setBackgroundColor:[UIColor clearColor]];
    [forgetPass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [forgetPass addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPass];
}

-(void) createRegisterView
{
    registerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 512, 320)];
    [registerView setHidden:YES];
    registerView.backgroundColor = [UIColor getColor:@"E8E7ED"];
    [self.view addSubview:registerView];
    [registerView release];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 512, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:17.0f];
    title.text = @"注册";
    title.textColor = [UIColor blackColor];
    [registerView addSubview:title];
    [title release];
    
    UIButton *gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gobackBtn.frame = CGRectMake(0, 0, 60, 40);
    [gobackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [gobackBtn setTitleColor:[UIColor getColor:@"3FA6FF"] forState:UIControlStateNormal];
    [gobackBtn addTarget:self action:@selector(goLoginView:) forControlEvents:UIControlEventTouchUpInside];
    [gobackBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [registerView addSubview:gobackBtn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((512-390)/2, 50, 390, 10+35*5)];
    bgView.layer.cornerRadius = 4.0;
    bgView.backgroundColor = [UIColor whiteColor];
    [registerView addSubview:bgView];
    [bgView release];
    
    NSArray *array = @[@"请输入账号",@"请输入密码",@"请输入真实姓名",@"请输入工作单位",@"请输入手机号码"];
    
    for (int i = 0; i<5; i++) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake((512-390)/2 + 5, 55+35*i, 380, 35)];
        field.placeholder = [array objectAtIndex:i];
        field.tag = 1500+i;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.secureTextEntry = (i==1);
        field.font = [UIFont systemFontOfSize:15.0f];
        field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [registerView addSubview:field];
        [field release];
    }
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake((512-390)/2, 260, 390, 35);
    registerBtn.layer.cornerRadius = 5.0f;
    [registerBtn setBackgroundColor:[UIColor getColor:@"3FA6FF"]];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册账户" forState:UIControlStateNormal];
    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [registerBtn addTarget:self action:@selector(registerInService:) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:registerBtn];

}

-(void) loginInService:(id)sender
{
    if ([nameField.text length] == 0 || [passwordField.text length] == 0) {
        alertMessage(@"用户名或密码没有输入，请输入");
        return;
    }
    
    VerifyLoginReqBody *reqBody = [[VerifyLoginReqBody alloc] init];
    reqBody.name = nameField.text;
    reqBody.password = passwordField.text;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                            andReqType:VERITY_LOGIN];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        VerifyLoginRespBody *respBody = (VerifyLoginRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:VERITY_LOGIN];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"登录出错,请稍后重试.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkData:(VerifyLoginRespBody *) respBody
{
    if (![@"\"0\"" isEqualToString:respBody.userId]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:nameField.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setValue:passwordField.text forKey:@"userpwd"];
        
        [DataCenter shareInstance].isLogined = YES;
        [DataCenter shareInstance].loginName = nameField.text;
        [DataCenter shareInstance].loginId = [respBody.userId stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [self dismissViewControllerAnimated:YES completion:^{}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateInfo" object:nil];
    } else {
        alertMessage(@"登录失败,账户或密码错误.");
    }
}

-(void) registerInService:(id)sender
{
    NSString *name = [((UITextField *)[registerView viewWithTag:1500]) text];
    NSString *pwd = [((UITextField *)[registerView viewWithTag:1501]) text];
    NSString *tname = [((UITextField *)[registerView viewWithTag:1502]) text];
    NSString *job = [((UITextField *)[registerView viewWithTag:1503]) text];
    NSString *mobile = [((UITextField *)[registerView viewWithTag:1504]) text];
    
    if (name.length == 0 || pwd.length == 0 || tname.length == 0 || job.length == 0 || mobile.length == 0 ) {
        alertMessage(@"请确认信息是否输入完整");
        return ;
    }
    
    if ([mobile length] != 11) {
        alertMessage(@"号码输入不正确，请重新输入");
        return ;
    }
    
    if ([[mobile stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]] trimming].length >0) {
        alertMessage(@"号码输入不正确，请重新输入");
        return ;
    }
    
    AddAccountReqBody *reqBody = [[AddAccountReqBody alloc] init];
    reqBody.accountName = name;
    reqBody.accountPassword = pwd;
    reqBody.peopleJob = job;
    reqBody.peopleName = tname;
    reqBody.peopleMobileNo = mobile;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                            andReqType:ADD_ACCOUNT];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddAccountRespBody *respBody = (AddAccountRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_ACCOUNT];
        [self checkRegster:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求出错,请稍后重试.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkRegster:(AddAccountRespBody *)respBody
{
    if ([respBody.result isEqualToString:@"\"1\""]) {
        alertMessage(@"注册成功! 请登录");
        for (int i=1500; i<1505; i++) {
            ([(UITextField *)[registerView viewWithTag:i] setText:@""]);
        }
        [UIView animateWithDuration:1.0 animations:^{
            [loginView setHidden:NO];
            [registerView setHidden:YES];
        }];
    } else {
        alertMessage(@"注册失败,请重新提交注册.");
    }
}

-(void) goRegisterView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        [loginView setHidden:YES];
        [registerView setHidden:NO];
    }];
}

-(void) goLoginView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        [loginView setHidden:NO];
        [registerView setHidden:YES];
    }];
}

-(void) forgetPassword:(id)sender
{
    
}

-(void) cancleLogin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameField resignFirstResponder];
    [passwordField resignFirstResponder];
//    @try
//    {
//        Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
//        id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
//        [activeInstance performSelector:@selector(dismissKeyboard)];
//    }
//    @catch (NSException *exception)
//    {
//        NSLog(@"%@", exception);
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
