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
    [DataCenter shareInstance].loginId = @"NA140714020202352";
    
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
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkData:(GetTopDirectoryRespBody *)response
{
    NSLog(@"%@",response.topDirectoryArray);
    
    if ([response.topDirectoryArray count] < 6) {
        alertMessage(@"主目录获取个数小于6");
        return ;
    }
    
    [[DataCenter shareInstance].topDirectory addObjectsFromArray:response.topDirectoryArray];
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor getColor:@"6ABAFA"],NSForegroundColorAttributeName,nil];
    
    //个人中心
    SendTaskViewController *send = [[SendTaskViewController alloc] init];
    send.title = @"个人中心";
    UINavigationController *sendNav = [[UINavigationController alloc] initWithRootViewController:send];
    [sendNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [sendNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
    //    sendNav.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
    //    sendNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    sendNav.navigationBar.titleTextAttributes = dict;
    sendNav.navigationBar.translucent = NO;
    [viewArray addObject:sendNav];
    [send release];
    [sendNav release];
    
    //首页
    HeadViewController *hvc = [[HeadViewController alloc]init];
    hvc.title = [[response.topDirectoryArray objectAtIndex:0] nameTopDirectory];
    hvc.topId = [[response.topDirectoryArray objectAtIndex:0] idTopDirectory];
    UINavigationController *hvcNav = [[UINavigationController alloc] initWithRootViewController:hvc];
    hvcNav.navigationBar.translucent = NO;
//    hvcNav.tabBarItem.image = [UIImage imageNamed:@"icon_home_nomal"];
//    hvcNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_click"];
    [hvcNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [hvcNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
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
//    cardNav.tabBarItem.image = [UIImage imageNamed:@"icon_onecard_nomal"];
//    cardNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_onecard_click"];
    [cardNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [cardNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
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
    [tvcNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
//    tvcNav.tabBarItem.image = [UIImage imageNamed:@"icon_carticket_nomal"];
//    tvcNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_carticket_click"];
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
//    zoneNav.tabBarItem.image = [UIImage imageNamed:@"icon_mine_nomal"];
//    zoneNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_mine_click"];
    zoneNav.navigationBar.titleTextAttributes = dict;
    [zoneNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [zoneNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
    zoneNav.navigationBar.translucent = NO;
    [viewArray addObject:zoneNav];
    [zone release];
    [zoneNav release];
    
    //第五个主目录
    FifthViewController *four = [[FifthViewController alloc] init];
    four.title = [[response.topDirectoryArray objectAtIndex:4] nameTopDirectory];
    four.topId = [[response.topDirectoryArray objectAtIndex:4] idTopDirectory];
    UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:four];
    //    fourNav.tabBarItem.image = [UIImage imageNamed:@"icon_mine_nomal"];
    //    fourNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_mine_click"];
    fourNav.navigationBar.titleTextAttributes = dict;
    [fourNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [fourNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
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
    [moreNav.navigationBar setTintColor:[UIColor getColor:@"6ABAFA"]];
//    moreNav.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
//    moreNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    moreNav.navigationBar.titleTextAttributes = dict;
    moreNav.navigationBar.translucent = NO;
    [viewArray addObject:moreNav];
    [more release];
    [moreNav release];
    

    
    //tab
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab.tabBar setTintColor:[UIColor getColor:@"6ABAFA"]];
    tab.viewControllers = viewArray;
    [self.navigationController pushViewController:tab animated:YES];
    [viewArray release];
    [tab release];
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
