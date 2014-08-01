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
    [self createInitView];
    
//    GetTVInfoReqBody *reqBody = [[GetTVInfoReqBody alloc] init];
//    reqBody.idTV = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TVINFO];
//    [reqBody release];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        GetTVInfoRespBody *respBody = (GetTVInfoRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TVINFO];
//        [self getTVInfoCheck:respBody];
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error : %@", [error localizedDescription]);
//        alertMessage(@"获取视频详细信息失败，请重新获取.");
//    }];
//    [operation start];
//    [operation request];
    
//    GetTVCommentReqBody *reqBody = [[GetTVCommentReqBody alloc] init];
//    reqBody.idTV = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TVCOMMENT];
//    [reqBody release];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        GetTVCommentRespBody *respBody = (GetTVCommentRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TVCOMMENT];
//        [self getTVCommentCheck:respBody];
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error : %@", [error localizedDescription]);
//        alertMessage(@"获取视频评论失败，请重新获取.");
//    }];
//    [operation start];
//    [operation request];
    
//    AddTVCommentReqBody *reqBody = [[AddTVCommentReqBody alloc] init];
//    reqBody.TVId = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    reqBody.accountId = [DataCenter shareInstance].loginId;
//    reqBody.commentNote = @"这个视频很好看";
//    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_TVCOMMENT];
//    [reqBody release];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        AddTVCommentRespBody *respBody = (AddTVCommentRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_TVCOMMENT];
//        [self addTVCommentCheck:respBody];
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error : %@", [error localizedDescription]);
//        alertMessage(@"添加评论失败，请重新添加.");
//    }];
//    [operation start];
//    [operation request];
}

-(void) getTVInfoCheck:(GetTVInfoRespBody *)response
{
    
}

-(void) getTVCommentCheck:(GetTVCommentRespBody *) response
{
    
}

-(void) addTVCommentCheck:(AddTVCommentRespBody *) response
{
    if (response.tvCommentResult || [@"0" isEqualToString:response.tvCommentResult]) {
        alertMessage(@"添加评论失败，请重新添加");
        return;
    }
    
}

-(void) playVedio
{
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://feiclass.winnovo.com/fileupload/feiclass/course_file/20140522/14007534063406838420MTE=.mp4"]]];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.vedioModel.tvVirtualPath]]];
    [self.view addSubview:web];
    [web release];
}

-(void) addGood:(id) sender
{
    AddGoodReqBody *reqBody = [[AddGoodReqBody alloc] init];
    reqBody.TVId = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    reqBody.AccountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_GOOD];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        AddGoodRespBody *respBody = (AddGoodRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_GOOD];
        [self addGoodCheck:respBody];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，请重新操作.");
    }];
    [operation start];
    [operation request];
}

-(void) addGoodCheck:(AddGoodRespBody *)response
{
    if ([@"-1" isEqualToString:response.result]) {
        alertMessage(@"点赞失败，请重新操作");
    } else if ([@"0" isEqualToString:response.result]) {
        alertMessage(@"您已经对该视频进行过点赞操作，请勿重复点赞");
    } else {
        alertMessage(@"点赞成功");
        [goodBtn setSelected:![goodBtn isSelected]];
        [goodBtn setTitle:[response.result stringByReplacingOccurrencesOfString:@" " withString:@""] forState:UIControlStateNormal];
        goodBtn.userInteractionEnabled = NO;
    }
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

-(void) createInitView
{
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
    
    string =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"视频名称:%@",[self.vedioModel.nameTV stringByReplacingOccurrencesOfString:@"(null)" withString:@" "]]];
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
    [thumbnailImage setImageWithURL:[NSURL URLWithString:self.vedioModel.tvPicVirtualPath]];
    [thumbnailImage setBackgroundColor:[UIColor clearColor]];
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
    countLabel.text = [NSString stringWithFormat:@"%@",[self.vedioModel.goodCount description]];
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

@end
