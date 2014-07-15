//
//  BaseViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"

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
    
}

-(void) releaseTask:(id)sender
{
    NSLog(@"task");
    [self isVerifyLogin];
}

-(void) uploadVedio:(id)sender
{
    [self isVerifyLogin];
}

-(void) shootingVedio:(id)sender
{
    [self isVerifyLogin];
}

-(void) searchTask:(id)sender
{
    [self isVerifyLogin];
}

-(void) addSecDir:(id)sender
{
    [self isVerifyLogin];
}

-(BOOL) isVerifyLogin
{
    if (![DataCenter shareInstance].isLogined) {
        NSLog(@"please login");
        return NO;
    }
    NSLog(@"yes log");
    return YES;
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
