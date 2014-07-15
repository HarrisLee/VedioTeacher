//
//  BaseViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginsViewController.h"

@interface BaseViewController ()
{
    UISegmentedControl *segment;
}
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

-(void) viewWillAppear:(BOOL)animated
{
    [self setTitleViewHidden:[DataCenter shareInstance].isLogined];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 400, 44)];
    logoView.backgroundColor = [UIColor redColor];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    logo.backgroundColor = [UIColor brownColor];
    [logoView addSubview:logo];
    [logo release];
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
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_icon_redirect_hight_os7"] style:UIBarButtonItemStylePlain target:self action:@selector(shootingVedio:)];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_icon_redirect_hight_os7"] style:UIBarButtonItemStylePlain target:self action:@selector(searchTask:)];
    self.navigationItem.rightBarButtonItems = @[item4,item3,item2,item1,item0];
    
    segment = [[UISegmentedControl alloc] initWithItems:@[@"我的视频",@"全部"]];
    [segment setSelectedSegmentIndex:0];
    segment.clipsToBounds = YES;
    [segment setTintColor:[UIColor getColor:@"6ABAFA"]];
//    [segment setHidden:YES];
    [segment addTarget:self action:@selector(segmentClickedAtIndex:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    [segment release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleViewHiden:) name:@"titleView" object:nil];
    
}

-(void) segmentClickedAtIndex:(id) sender
{
    NSLog(@"%d",[sender selectedSegmentIndex]);
}

-(BOOL) releaseTask:(id)sender
{
    NSLog(@"task");
    return [self isVerifyLogin];
}

-(BOOL) uploadVedio:(id)sender
{
    return [self isVerifyLogin];
}

-(BOOL) shootingVedio:(id)sender
{
    return [self isVerifyLogin];
}

-(BOOL) searchTask:(id)sender
{
    return [self isVerifyLogin];
}

-(BOOL) addSecDir:(id)sender
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

-(void) titleViewHiden:(NSNotification *) notification
{
    NSString *hidden = [notification.userInfo objectForKey:@"show"];
    if ([hidden isEqualToString:@"1"]) {
        [segment setHidden:NO];
    } else {
        [segment setHidden:YES];
    }
    
}

-(void) setTitleViewHidden:(BOOL) hidden
{
    [segment setHidden:!hidden];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"titleView" object:nil];
    [super dealloc];
}

@end
