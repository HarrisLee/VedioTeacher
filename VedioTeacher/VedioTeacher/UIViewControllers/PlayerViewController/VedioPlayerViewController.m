//
//  VedioPlayerViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-8-4.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "VedioPlayerViewController.h"

@interface VedioPlayerViewController ()

@end

@implementation VedioPlayerViewController
@synthesize url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationItem.rightBarButtonItems = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
    [web loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:web];
    [web release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [url release];
    [super dealloc];
}

@end
