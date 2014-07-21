//
//  PlayerViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController
@synthesize vedioModel,topName,secondName;

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
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768-64-55)];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, 1026, 50)];
    header.layer.borderWidth = 1.0f;
    header.layer.borderColor = [UIColor lightGrayColor].CGColor;
    header.backgroundColor = [UIColor getColor:@"F6F6F6"];
    [scrollView addSubview:header];
    [header release];
    
    NSMutableAttributedString *string =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"首页 > %@ > %@",self.topName,self.secondName]];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(3, 1)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(6+[self.topName length], 1)];
    UILabel *reference = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 994, 50)];
    reference.textColor = [UIColor getColor:@"3FA6FF"];
    reference.attributedText = string;
    reference.backgroundColor = [UIColor clearColor];
    reference.font = [UIFont systemFontOfSize:15.0f];
    [header addSubview:reference];
    [string release];
    [reference release];
    
    string =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"视频名称:%@",self.vedioModel.nameTV]];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor getColor:@"3FA6FF"] range:NSMakeRange(0, 5)];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, header.frame.origin.y + header.frame.size.height, 994, 30)];
    name.textColor = [UIColor lightGrayColor];
    name.attributedText = string;
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:15.0f];
    [scrollView addSubview:name];
    [string release];
    [name release];
    
    UIImageView *thumbnailImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, name.frame.origin.y + name.frame.size.height, 994, 400)];
    [thumbnailImage setBackgroundColor:[UIColor redColor]];
    [scrollView addSubview:thumbnailImage];
    [thumbnailImage release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVedio)];
    thumbnailImage.userInteractionEnabled = YES;
    [thumbnailImage addGestureRecognizer:tap];
    [tap release];
    
    goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [goodBtn setImage:[UIImage imageNamed:@"common_button_green_disable"] forState:UIControlStateNormal];
//    [goodBtn setImage:[UIImage imageNamed:@"common_button_green_highlighted"] forState:UIControlStateSelected];
    goodBtn.frame = CGRectMake(20, thumbnailImage.frame.origin.y + thumbnailImage.frame.size.height + 15, 40, 40);
    [goodBtn addTarget:self action:@selector(addGood:) forControlEvents:UIControlEventTouchUpInside];
    goodBtn.backgroundColor = [UIColor brownColor];
    [scrollView addSubview:goodBtn];
    
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, goodBtn.frame.origin.y + goodBtn.frame.size.height, goodBtn.frame.size.width, 15)];
    countLabel.text = @"123456";
    countLabel.textColor = [UIColor darkGrayColor];
    countLabel.backgroundColor = [UIColor blueColor];
    countLabel.font = [UIFont systemFontOfSize:13.0f];
    [scrollView addSubview:countLabel];
    [countLabel release];
    
    UIImageView *section = [[UIImageView alloc] initWithFrame:CGRectMake(20, countLabel.frame.origin.y + 35, 3, 25)];
    section.backgroundColor = [UIColor getColor:@"3FA6FF"];
    [scrollView addSubview:section];
    [section release];
    
    UILabel *commentSection = [[UILabel alloc] initWithFrame:CGRectMake(30, section.frame.origin.y+2.5, 200, 20)];
    commentSection.text = @"网友评论";
    commentSection.font = [UIFont boldSystemFontOfSize:20.0];
    [scrollView addSubview:commentSection];
    [commentSection release];
}

-(void) playVedio
{
    NSLog(@"player");
    return ;
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://feiclass.winnovo.com/fileupload/feiclass/course_file/20140522/14007534063406838420MTE=.mp4"]]];
    [self.view addSubview:web];
    [web release];
}

-(void) addGood:(id) sender
{
    [goodBtn setSelected:![sender isSelected]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [vedioModel release];
    [topName release];
    [secondName release];
    [super dealloc];
}

@end
