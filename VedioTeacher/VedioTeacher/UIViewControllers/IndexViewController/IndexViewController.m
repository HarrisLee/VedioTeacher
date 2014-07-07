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
    GetTopDirectoryReqBody *reqBody = [[GetTopDirectoryReqBody alloc] init];
    NSMutableURLRequest *urlRequets = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TOPDIR];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequets];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetTopDirectoryRespBody *respBody = (GetTopDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TOPDIR];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取一级目录不成功.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkData:(GetTopDirectoryRespBody *)response
{
    NSLog(@"%@",response.topDirectoryArray);
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor getColor:@"ff956c"],NSForegroundColorAttributeName,nil];
    
    //首页
    BaseViewController *hvc = [[BaseViewController alloc]init];
    hvc.title = @"首页";
    UINavigationController *hvcNav = [[UINavigationController alloc] initWithRootViewController:hvc];
    hvcNav.navigationBar.translucent = NO;
//    hvcNav.tabBarItem.image = [UIImage imageNamed:@"icon_home_nomal"];
//    hvcNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_click"];
    [hvcNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [hvcNav.navigationBar setTintColor:[UIColor orangeColor]];
    hvcNav.navigationBar.titleTextAttributes = dict;
    [viewArray addObject:hvcNav];
    [hvc release];
    [hvcNav release];
    
    //一卡通
    BaseViewController *oneCard = [[BaseViewController alloc] init];
    oneCard.title = @"一卡通";
    UINavigationController *cardNav = [[UINavigationController alloc] initWithRootViewController:oneCard];
    cardNav.navigationBar.translucent = NO;
//    cardNav.tabBarItem.image = [UIImage imageNamed:@"icon_onecard_nomal"];
//    cardNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_onecard_click"];
    [cardNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [cardNav.navigationBar setTintColor:[UIColor orangeColor]];
    cardNav.navigationBar.titleTextAttributes = dict;
    [viewArray addObject:cardNav];
    [oneCard release];
    [cardNav release];
    
    //汽车票
    BaseViewController *tvc = [[BaseViewController alloc]init];
    tvc.title = @"汽车票";
    UINavigationController *tvcNav = [[UINavigationController alloc] initWithRootViewController:tvc];
    [tvcNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [tvcNav.navigationBar setTintColor:[UIColor orangeColor]];
//    tvcNav.tabBarItem.image = [UIImage imageNamed:@"icon_carticket_nomal"];
//    tvcNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_carticket_click"];
    tvcNav.navigationBar.titleTextAttributes = dict;
    tvcNav.navigationBar.translucent = NO;
    [viewArray addObject:tvcNav];
    [tvc release];
    [tvcNav release];
    
    //我的
    BaseViewController *zone = [[BaseViewController alloc] init];
    zone.title = @"我的";
    UINavigationController *zoneNav = [[UINavigationController alloc] initWithRootViewController:zone];
//    zoneNav.tabBarItem.image = [UIImage imageNamed:@"icon_mine_nomal"];
//    zoneNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_mine_click"];
    zoneNav.navigationBar.titleTextAttributes = dict;
    [zoneNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [zoneNav.navigationBar setTintColor:[UIColor orangeColor]];
    zoneNav.navigationBar.translucent = NO;
    [viewArray addObject:zoneNav];
    [zone release];
    [zoneNav release];
    
    //设置
    BaseViewController *more = [[BaseViewController alloc] init];
    more.title = @"设置";
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:more];
    [moreNav.navigationBar setBarTintColor:[UIColor whiteColor]];
    [moreNav.navigationBar setTintColor:[UIColor orangeColor]];
//    moreNav.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
//    moreNav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    moreNav.navigationBar.titleTextAttributes = dict;
    moreNav.navigationBar.translucent = NO;
    [viewArray addObject:moreNav];
    [more release];
    [moreNav release];
    
    //tab
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab.tabBar setTintColor:[UIColor getColor:@"ff4800"]];
    tab.viewControllers = viewArray;
    [self.navigationController pushViewController:tab animated:YES];
    [viewArray release];
}

-(void) releaseTask:(id)sender
{
    NSLog(@"index");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
