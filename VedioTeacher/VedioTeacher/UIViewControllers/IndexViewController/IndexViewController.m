//
//  IndexViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

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
//    [DataCenter shareInstance].loginId = @"NA140714020202352";
//    [DataCenter shareInstance].loginName = @"haha";
//    [DataCenter shareInstance].isLogined = YES;
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] valueForKey:@"userpwd"];
    if ([name isKindOfClass:[NSString class]] && [name length] > 0
        && [pwd isKindOfClass:[NSString class]] && [pwd length] > 0 ) {
        VerifyLoginReqBody *reqBody = [[VerifyLoginReqBody alloc] init];
        reqBody.name = name;
        reqBody.password = pwd;
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                                andReqType:VERITY_LOGIN];
        [reqBody release];
        
        AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            VerifyLoginRespBody *respBody = (VerifyLoginRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:VERITY_LOGIN];
            [self checkLoginData:respBody];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
        }];
        
        [theOperation start];
        [theOperation release];
    }
    
    
    [self getIndexDirc];
    
    [self createIpView];

}

- (void)getIndexDirc
{
    GetTopDirectoryReqBody *reqBody = [[GetTopDirectoryReqBody alloc] init];
    NSMutableURLRequest *urlRequets = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TOPDIR];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequets];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetTopDirectoryRespBody *respBody = (GetTopDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TOPDIR];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取主目录目录失败.");
        [self checkData:nil];
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkLoginData:(VerifyLoginRespBody *) respBody
{
    if (![@"\"0\"" isEqualToString:respBody.userId]) {
        [DataCenter shareInstance].isLogined = YES;
        [DataCenter shareInstance].loginName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        [DataCenter shareInstance].loginId = [respBody.userId stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
}

-(void) checkData:(GetTopDirectoryRespBody *)response
{
    NSLog(@"%@",response.topDirectoryArray);
    
    if (!response) {
        //重新输入IP地址
        [ipView setHidden:NO];
        return ;
    }
    
    if ([response.topDirectoryArray count] < 6) {
        alertMessage(@"主目录获取个数小于6");
        return ;
    }
    
    [[DataCenter shareInstance].topDirectory addObjectsFromArray:response.topDirectoryArray];
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor getColor:@"3FA6FF"],NSForegroundColorAttributeName,nil];
    
    //首页
    HeadViewController *hvc = [[HeadViewController alloc]init];
    hvc.title = [[response.topDirectoryArray objectAtIndex:0] nameTopDirectory];
    hvc.topId = [[response.topDirectoryArray objectAtIndex:0] idTopDirectory];
    UINavigationController *hvcNav = [[UINavigationController alloc] initWithRootViewController:hvc];
    hvcNav.navigationBar.translucent = NO;
    hvcNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_home"];
    hvcNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_home"];
    [hvcNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [hvcNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    hvcNav.navigationBar.titleTextAttributes = dict;
    [viewArray addObject:hvcNav];
    [hvc release];
    [hvcNav release];
    
    //第二个主目录
    SecondViewController *oneCard = [[SecondViewController alloc] init];
    oneCard.title = [[response.topDirectoryArray objectAtIndex:1] nameTopDirectory];
    oneCard.topId = [[response.topDirectoryArray objectAtIndex:1] idTopDirectory];
    UINavigationController *cardNav = [[UINavigationController alloc] initWithRootViewController:oneCard];
    cardNav.navigationBar.translucent = NO;
    cardNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_91"];
    cardNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_91"];
    [cardNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [cardNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    cardNav.navigationBar.titleTextAttributes = dict;
    [viewArray addObject:cardNav];
    [oneCard release];
    [cardNav release];
    
    //第三个主目录
    ThirdViewController *tvc = [[ThirdViewController alloc]init];
    tvc.title = [[response.topDirectoryArray objectAtIndex:2] nameTopDirectory];
    tvc.topId = [[response.topDirectoryArray objectAtIndex:2] idTopDirectory];
    UINavigationController *tvcNav = [[UINavigationController alloc] initWithRootViewController:tvc];
    [tvcNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [tvcNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    tvcNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_96"];
    tvcNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_96"];
    tvcNav.navigationBar.titleTextAttributes = dict;
    tvcNav.navigationBar.translucent = NO;
    [viewArray addObject:tvcNav];
    [tvc release];
    [tvcNav release];
    
    //第四个主目录
    FourthViewController *zone = [[FourthViewController alloc] init];
    zone.title = [[response.topDirectoryArray objectAtIndex:3] nameTopDirectory];
    zone.topId = [[response.topDirectoryArray objectAtIndex:3] idTopDirectory];
    UINavigationController *zoneNav = [[UINavigationController alloc] initWithRootViewController:zone];
    zoneNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_95"];
    zoneNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_95"];
    zoneNav.navigationBar.titleTextAttributes = dict;
    [zoneNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [zoneNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    zoneNav.navigationBar.translucent = NO;
    [viewArray addObject:zoneNav];
    [zone release];
    [zoneNav release];
    
    //第五个主目录
    FifthViewController *four = [[FifthViewController alloc] init];
    four.title = [[response.topDirectoryArray objectAtIndex:4] nameTopDirectory];
    four.topId = [[response.topDirectoryArray objectAtIndex:4] idTopDirectory];
    UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:four];
    fourNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_87"];
    fourNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_87"];
    fourNav.navigationBar.titleTextAttributes = dict;
    [fourNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [fourNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    fourNav.navigationBar.translucent = NO;
    [viewArray addObject:fourNav];
    [four release];
    [fourNav release];
    
    //第六个主目录
    MoreViewController *more = [[MoreViewController alloc] init];
    more.title = [[response.topDirectoryArray objectAtIndex:5] nameTopDirectory];
    more.topId = [[response.topDirectoryArray objectAtIndex:5] idTopDirectory];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:more];
    [moreNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [moreNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    moreNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_84"];
    moreNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_84"];
    moreNav.navigationBar.titleTextAttributes = dict;
    moreNav.navigationBar.translucent = NO;
    [viewArray addObject:moreNav];
    [more release];
    [moreNav release];
    
    //个人中心
    SendTaskViewController *send = [[SendTaskViewController alloc] init];
    send.title = @"个人中心";
    UINavigationController *sendNav = [[UINavigationController alloc] initWithRootViewController:send];
    [sendNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [sendNav.navigationBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    sendNav.tabBarItem.image = [UIImage imageNamed:@"icon_tab_account"];
    sendNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tab_selected_account"];
    sendNav.navigationBar.titleTextAttributes = dict;
    sendNav.navigationBar.translucent = NO;
    [viewArray addObject:sendNav];
    [send release];
    [sendNav release];
    
    //tab
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab.tabBar setTintColor:[UIColor getColor:@"3FA6FF"]];
    tab.delegate = self;
    tab.viewControllers = viewArray;
    [self.navigationController pushViewController:tab animated:YES];
    [viewArray release];
    [tab release];
}

- (void)createIpView
{
    ipView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0 - 250, SCREEN_HEIGHT/2.0 - 250, 500, 300)];
    [self.view addSubview:ipView];
    ipView.backgroundColor = [UIColor getColor:@"a9a9a9"];
    [ipView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, ipView.frame.size.width - 60, 30)];
    label.text = @"请输入服务器地址";
    [ipView addSubview:label];
    [label release];
    
    ipField = [[UITextView alloc] initWithFrame:CGRectMake(30, 80, label.frame.size.width, ipView.frame.size.height - 180)];
    ipField.text = [[DataCenter shareInstance].configDictionary objectForKey:@"service"];
    [ipView addSubview:ipField];
    [ipField release];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.backgroundColor = [UIColor getColor:@"3FA6FF"];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(connectServiceAgain) forControlEvents:UIControlEventTouchUpInside];
    cancle.frame = CGRectMake(30, ipField.frame.origin.y + ipField.frame.size.height + 10, ipField.frame.size.width/2 - 15.0, 30.0);
    [ipView addSubview:cancle];
    
    UIButton *connect = [UIButton buttonWithType:UIButtonTypeCustom];
    connect.backgroundColor = [UIColor getColor:@"3FA6FF"];
    [connect setTitle:@"修改" forState:UIControlStateNormal];
    [connect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [connect addTarget:self action:@selector(connectService) forControlEvents:UIControlEventTouchUpInside];
    connect.frame = CGRectMake(cancle.frame.origin.x + cancle.frame.size.width + 30, cancle.frame.origin.y, ipField.frame.size.width/2 - 15.0, 30.0);
    [ipView addSubview:connect];
    
}

- (void)connectServiceAgain
{
    [ipField resignFirstResponder];
    [ipView setHidden:YES];
    [self getIndexDirc];
}

- (void)connectService
{
    [ipField resignFirstResponder];
    [ipView setHidden:YES];
    if([ipField.text length] == 0)
    {
        alertMessage(@"服务器地址不能为空，请重新输入");
        return ;
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
    
    [infoDictionary setObject:ipField.text forKey:@"service"];
    
    [infoDictionary writeToFile:plistPath atomically:YES];

    [DataCenter shareInstance].configDictionary = nil;
    
    [DataCenter shareInstance].configDictionary = infoDictionary;
    
    [[AFHttpRequestUtils shareInstance] setBaseUrl:ipField.text];
    
    [self getIndexDirc];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%d",[tabBarController selectedIndex]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clear" object:nil];
}

-(BOOL) releaseTask:(id)sender
{
    NSLog(@"index");
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
