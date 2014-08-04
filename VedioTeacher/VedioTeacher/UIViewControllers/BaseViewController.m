//
//  BaseViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginsViewController.h"
#import "UploadViewController.h"
#import "SendTaskViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    isSearching = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 400, 44)];
    logoView.backgroundColor = [UIColor redColor];
    UIButton *logo = [UIButton buttonWithType:UIButtonTypeCustom];
    logo.frame = CGRectMake(0, 0, 300, 44);
    logo.backgroundColor = [UIColor brownColor];
    [logo addTarget:self action:@selector(goBackViewController:) forControlEvents:UIControlEventTouchUpInside];
    [logoView addSubview:logo];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(300, 5, 100, 30)];
    name.text = self.title;
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:18.0];
    [logoView addSubview:name];
    [name release];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:logoView] autorelease];
    [logoView release];
    
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_icon_redirect_hight_os7"] style:UIBarButtonItemStylePlain target:self action:@selector(addSecDir:)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_icon_redirect_hight_os7"] style:UIBarButtonItemStylePlain target:self action:@selector(releaseTask:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_icon_redirect_hight_os7"] style:UIBarButtonItemStylePlain target:self action:@selector(uploadVedio:)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_icon_redirect_hight_os7"] style:UIBarButtonItemStylePlain target:self action:@selector(searchTask:)];
    self.navigationItem.rightBarButtonItems = @[item3,item2,item1,item0];

}

-(BOOL) addSecDir:(id)sender
{
    return [self isVerifyLogin];
}

-(BOOL) releaseTask:(id)sender
{
    BOOL islogin = [self isVerifyLogin];
    if (!islogin) {
        return NO;
    }
    
    [self.tabBarController setSelectedIndex:6];
    
    return YES;
}

-(BOOL) uploadVedio:(id)sender
{
    BOOL islogin = [self isVerifyLogin];
    if (!islogin) {
        return NO;
    }
    
    UploadViewController *upload = [[UploadViewController alloc] init];
    [self.navigationController pushViewController:upload animated:YES];
    [upload release];
    
    return YES;
}

-(BOOL) searchTask:(id)sender
{
    return [self isVerifyLogin];
}

-(BOOL) isVerifyLogin
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
    return YES;
}

-(void) goBackViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) clearSearch
{
    isSearching = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [super dealloc];
}

@end
