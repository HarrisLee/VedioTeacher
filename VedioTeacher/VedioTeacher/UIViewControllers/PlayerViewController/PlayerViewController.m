//
//  PlayerViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "PlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

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

-(void) viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItems = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
    
    [self createInitView];
    
    commentCount = 0;
    
    GetTVInfoReqBody *reqBody = [[GetTVInfoReqBody alloc] init];
    reqBody.idTV = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TVINFO];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetTVInfoRespBody *respBody = (GetTVInfoRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TVINFO];
        [self getTVInfoCheck:respBody];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取视频详细信息失败，请重新获取.");
    }];
    [operation start];
    [operation release];
    
    GetTVCommentReqBody *requestBody = [[GetTVCommentReqBody alloc] init];
    requestBody.idTV = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableURLRequest *requestComment = [[AFHttpRequestUtils shareInstance] requestWithBody:requestBody andReqType:GET_TVCOMMENT];
    [requestBody release];
    AFHTTPRequestOperation *operationComent = [[AFHTTPRequestOperation alloc] initWithRequest:requestComment];
    [operationComent setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetTVCommentRespBody *respBody = (GetTVCommentRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TVCOMMENT];
        [self getTVCommentCheck:respBody];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取视频评论失败，请重新获取.");
    }];
    [operationComent start];
    [operationComent release];
}

-(void) getTVInfoCheck:(GetTVInfoRespBody *)response
{
    if (![response.info isKindOfClass:[NSMutableDictionary class]]) {
        alertMessage(@"获取视频详细信息失败，请重新获取！");
        return ;
    }
    uploader.text = [NSString stringWithFormat:@"作者: %@",[[response.info objectForKey:@"accountName"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSString *time = [response.info objectForKey:@"addTime"];
    if (time && [time length] >= 19 ) {
        time = [[time substringToIndex:19] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    uploadTime.text = [NSString stringWithFormat:@"上传时间: %@", time];
}

-(void) getTVCommentCheck:(GetTVCommentRespBody *) response
{
    if ([response.commentList count] == 0) {
        return ;
    }
    NSInteger count = response.commentList.count;
    commentCount += count;
    for (int i = 0; i < count; i++) {
        TVCommentModel *model = [response.commentList objectAtIndex:count- i - 1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 600 + i*25, 984, 17)];
        label.text = [NSString stringWithFormat:@"%@:%@",model.accountName,model.comment];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        [scrollView addSubview:label];
        [label release];
    }
    [scrollView setContentSize:CGSizeMake(1024, 600+25*commentCount)];
}

-(void) playVedio
{
    
    NSString *getPath = [[NSUserDefaults standardUserDefaults] objectForKey:self.vedioModel.tvVirtualPath];
    if ([getPath isKindOfClass:[NSString class]] && [getPath length] > 0) {
        // create MPMoviePlayerViewController
        NSURL *url = [NSURL fileURLWithPath:getPath];
        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        playerViewController.view.frame = CGRectMake(0, 0, 1024, 768);
        // add to view
//        [self.view addSubview:playerViewController.view];
        [self.navigationController presentViewController:playerViewController animated:YES completion:^{
            
        }];
        
        // play movie
        MPMoviePlayerController *player = [playerViewController moviePlayer];
        player.controlStyle = MPMovieControlStyleFullscreen;
        player.shouldAutoplay = NO;
        player.repeatMode = MPMovieRepeatModeNone;
        [player setFullscreen:YES animated:YES];
        player.scalingMode = MPMovieScalingModeAspectFit;
        [player play];
        [playerViewController release];
        return ;
    }
    
    VedioPlayerViewController *play = [[VedioPlayerViewController alloc] init];
    play.title = @"播放";
    play.url = [NSURL URLWithString:self.vedioModel.tvVirtualPath];
    [self.navigationController pushViewController:play animated:YES];
    [play release];
    return ;
/*
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.vedioModel.tvVirtualPath]]];
    [self.view addSubview:web];
    [web release];
 */
}


-(void) addGood:(id) sender
{
    if (![DataCenter shareInstance].isLogined) {
        LoginsViewController *login = [[LoginsViewController alloc] init];
        login.modalPresentationStyle = UIModalPresentationFormSheet;
        login.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:login animated:YES completion:nil];
        login.view.superview.frame = CGRectMake(0, 0, 512, 320);
        login.view.superview.center = self.view.center;
        [login release];
        return ;
    }
    
    AddTVGoodReqBody *reqBody = [[AddTVGoodReqBody alloc] init];
    reqBody.TVId = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    reqBody.AccountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_TVGOOD];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        AddTVGoodRespBody *respBody = (AddTVGoodRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_TVGOOD];
        [self addGoodCheck:respBody];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，请重新操作.");
    }];
    [operation start];
    [operation release];
}

-(void) addGoodCheck:(AddTVGoodRespBody *)response
{
    if ([@"\"-1\"" isEqualToString:response.tVGoodResult]) {
        alertMessage(@"点赞失败，请重新操作");
    } else if ([@"\"0\"" isEqualToString:response.tVGoodResult]) {
        alertMessage(@"您已经对该视频进行过点赞操作，请勿重复点赞");
    } else {
        alertMessage(@"点赞成功");
        [goodBtn setSelected:YES];
        countLabel.text = [response.tVGoodResult stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        goodBtn.userInteractionEnabled = NO;
    }
}

-(void) submitComment:(id)sender
{
    NSLog(@"submit");
    if ([contentField.text length] == 0) {
        alertMessage(@"内容为空，请先输入评论内容。");
        return ;
    }
    
    if ([contentField.text length] > 100) {
        alertMessage(@"内容过长，请控制在100字以内。");
        return ;
    }
    
    if (![DataCenter shareInstance].isLogined) {
        LoginsViewController *login = [[LoginsViewController alloc] init];
        login.modalPresentationStyle = UIModalPresentationFormSheet;
        login.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:login animated:YES completion:nil];
        login.view.superview.frame = CGRectMake(0, 0, 512, 320);
        login.view.superview.center = self.view.center;
        [login release];
        return ;
    }
    
    AddTVCommentReqBody *reqBody = [[AddTVCommentReqBody alloc] init];
    reqBody.TVId = [[self.vedioModel.idTV description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    reqBody.accountId = [DataCenter shareInstance].loginId;
    reqBody.commentNote = contentField.text;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_TVCOMMENT];
    [reqBody release];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        AddTVCommentRespBody *respBody = (AddTVCommentRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_TVCOMMENT];
        [self addTVCommentCheck:respBody];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"添加评论失败，请重新添加.");
    }];
    [operation start];
    [operation release];

}

-(void) addTVCommentCheck:(AddTVCommentRespBody *) response
{
    if ([[response.tvCommentResult stringByReplacingOccurrencesOfString:@"\"" withString:@""] integerValue] == 0) {
        alertMessage(@"添加评论失败，请重新添加");
        return;
    }
    alertMessage(@"添加评论成功！");
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 600 + commentCount*25, 984, 17)];
    label.text = [NSString stringWithFormat:@"%@:%@",[DataCenter shareInstance].loginName,contentField.text];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [scrollView addSubview:label];
    [label release];
    [scrollView setContentSize:CGSizeMake(1024, 600+25*commentCount)];
    contentField.text = @"";
    [contentField resignFirstResponder];
    commentCount ++;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (!contentField.isEditing) {
        return;
    }

    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardBounds;
    [keyboardBoundsValue getValue:&keyboardBounds];
    NSLog(@"height = %f  %f",keyboardBounds.size.height,keyboardBounds.size.width);
    [UIView animateWithDuration:0.3 animations:^{
        bottomBack.frame = CGRectMake(0, 768 - 64 - 60 - keyboardBounds.size.width, 1024, 60);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    [UIView animateWithDuration:0.3 animations:^{
        bottomBack.frame = CGRectMake(0, 768 - 64 - 60, 1024, 60);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) downVedioFromService:(id)sender
{
    NSLog(@"下载");
    NSString *getPath = [[NSUserDefaults standardUserDefaults] objectForKey:self.vedioModel.tvVirtualPath];
    if ([getPath isKindOfClass:[NSString class]] && [getPath length] > 0) {
        alertMessage(@"该视频已经下载。");
        return ;
    }
    
    maskHUD = [[MBProgressHUD alloc] initWithView:self.view];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:maskHUD];
    // Set determinate mode
    maskHUD.mode = MBProgressHUDModeAnnularDeterminate;
    maskHUD.delegate = self;
    maskHUD.labelText = @"视频下载中...";
    [maskHUD show:YES];
    UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actView.frame = CGRectMake(502, (768 - 20)/2-11, 20, 20);
    [actView startAnimating];
    [maskHUD addSubview:actView];
    [actView release];
    
    NSURL *url = [NSURL URLWithString:[self.vedioModel.tvVirtualPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:9999];
    AFHTTPRequestOperation *operationDown = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[array objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",self.vedioModel.fileTVName]];
    operationDown.outputStream = [[NSOutputStream alloc] initToFileAtPath:path append:NO];
    [operationDown setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
        maskHUD.progress = progress;
    }];
    
    [operationDown setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self downloadSuccess:path downloadURL:self.vedioModel.tvVirtualPath];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [maskHUD hide:YES];
        NSLog(@"error : %@",[error localizedDescription]);
        alertMessage(@"下载失败，请重新下载");
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }];
    
    [operationDown start];
    [request release];
    [operationDown release];
    
}

-(void) downloadSuccess:(NSString *)path downloadURL:(NSString *)url
{
    maskHUD.labelText = @"下载完成";
    [maskHUD hide:YES afterDelay:1.0];
    [[NSUserDefaults standardUserDefaults] setValue:path forKey:url];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
	[hud release];
	hud = nil;
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}

-(void) createInitView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768-64-60)];
    scrollView.showsVerticalScrollIndicator = NO;
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
    
    NSString *nameString = [self.vedioModel.nameTV stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSRange range = [nameString rangeOfString:@"." options:NSBackwardsSearch];
    NSString *file = @"";
    if (range.length > 0) {
        file = [nameString substringToIndex:range.location];
    }
    
    string =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"视频名称: %@",file]];
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
    [thumbnailImage setImageWithURL:[NSURL URLWithString:self.vedioModel.tvPicVirtualPath] placeholderImage:[UIImage imageNamed:@"placeholder_home"]];
    thumbnailImage.layer.borderWidth = 1.0;
    thumbnailImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [thumbnailImage setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:thumbnailImage];
    [thumbnailImage release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVedio)];
    thumbnailImage.userInteractionEnabled = YES;
    [thumbnailImage addGestureRecognizer:tap];
    [tap release];
    
    goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goodBtn setImage:[UIImage imageNamed:@"detail_broadcast_praise_normal"] forState:UIControlStateNormal];
    [goodBtn setImage:[UIImage imageNamed:@"detail_broadcast_praise_select"] forState:UIControlStateSelected];
    goodBtn.frame = CGRectMake(20, thumbnailImage.frame.origin.y + thumbnailImage.frame.size.height + 15, 40, 40);
    [goodBtn addTarget:self action:@selector(addGood:) forControlEvents:UIControlEventTouchUpInside];
    goodBtn.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:goodBtn];
    
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, goodBtn.frame.origin.y + goodBtn.frame.size.height, goodBtn.frame.size.width, 15)];
    countLabel.text = [NSString stringWithFormat:@"%@",[self.vedioModel.goodCount description] ? [self.vedioModel.goodCount description] : @"0"];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.textColor = [UIColor getColor:@"4C4C4C"];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.font = [UIFont systemFontOfSize:13.0f];
    [scrollView addSubview:countLabel];
    [countLabel release];
    
    UIButton *download = [UIButton buttonWithType:UIButtonTypeCustom];
    [download setBackgroundImage:[UIImage imageNamed:@"tool_download"] forState:UIControlStateNormal];
    [download setBackgroundImage:[UIImage imageNamed:@"tool_download_selected"] forState:UIControlStateHighlighted];
    download.frame = CGRectMake(75, goodBtn.frame.origin.y+7.5, 40, 40);
    [download addTarget:self action:@selector(downVedioFromService:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:download];
    
    uploader = [[UILabel alloc] initWithFrame:CGRectMake(1024-320, goodBtn.frame.origin.y, 300, 19)];
    uploader.textColor = [UIColor blackColor];
    uploader.backgroundColor = [UIColor clearColor];
    uploader.font = [UIFont systemFontOfSize:15.0f];
    uploader.textAlignment = NSTextAlignmentRight;
    [scrollView addSubview:uploader];
    [uploader release];
    
    uploadTime = [[UILabel alloc] initWithFrame:CGRectMake(1024-320, uploader.frame.origin.y + 25, 300, 19)];
    uploadTime.textColor = [UIColor blackColor];
    uploadTime.backgroundColor = [UIColor clearColor];
    uploadTime.font = [UIFont systemFontOfSize:15.0f];
    uploadTime.textAlignment = NSTextAlignmentRight;
    [scrollView addSubview:uploadTime];
    [uploadTime release];
    
    UIImageView *section = [[UIImageView alloc] initWithFrame:CGRectMake(20, countLabel.frame.origin.y + 35, 3, 25)];
    section.backgroundColor = [UIColor getColor:@"3FA6FF"];
    [scrollView addSubview:section];
    [section release];
    
    UILabel *commentSection = [[UILabel alloc] initWithFrame:CGRectMake(30, section.frame.origin.y+2.5, 200, 20)];
    commentSection.text = @"网友评论";
    commentSection.font = [UIFont boldSystemFontOfSize:20.0];
    [scrollView addSubview:commentSection];
    [commentSection release];

    bottomBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 768 - 64 - 60, 1024, 60)];
    [bottomBack setImage:[[UIImage imageNamed:@"bottomView.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:5]];
    bottomBack.userInteractionEnabled = YES;
    [self.view addSubview:bottomBack];
    [bottomBack release];
    
    point = bottomBack.center;
    
    contentField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, 840, 40)];
    contentField.backgroundColor = [UIColor whiteColor];
    contentField.delegate = self;
    contentField.font = [UIFont fontWithName:@"Arial" size:15];
    contentField.placeholder = @"请输入评论，字数在0-100字之间";
    [bottomBack addSubview:contentField];
    [contentField release];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(875, 4, 142, 52);
    [submit setBackgroundImage:[UIImage imageNamed:@"button_13.png"] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitComment:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBack addSubview:submit];
}

@end
