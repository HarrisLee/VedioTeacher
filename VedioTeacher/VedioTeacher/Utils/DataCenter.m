//
//  DataCenter.m
//  Hey!XuanWu
//
//  Created by xuchuanyong on 11/22/12.
//  Copyright (c) 2012 q mm. All rights reserved.
//

#import "DataCenter.h"

static DataCenter *m_DataCenter = nil;
@implementation DataCenter
@synthesize isLogined;
@synthesize configDictionary;
@synthesize errorDictionary;
@synthesize userInfo;
@synthesize isOpen;
@synthesize isOutLogin;
@synthesize outLoginName;
@synthesize outLoginId;
@synthesize loginName;
@synthesize loginId;

+(DataCenter*)shareInstance {
    @synchronized(self)
	{
		if (m_DataCenter == nil)
		{
			m_DataCenter = [[DataCenter alloc] init];
		}
	}
	return m_DataCenter;
}

- (id)init {
    self = [super init];
    if (self) {
        if(userInfo == nil)
        {
            userInfo = [[UserModel alloc] init];
        }
        
        self.isShare = YES;
        self.isOpen = NO;
        self.isOutLogin = NO;
        [Utils copyPlistToDst:@"Config"];
        NSDictionary *tmpdic = [[NSDictionary alloc] initWithContentsOfFile:[Utils getDstPlistPath:@"Config"]];
        self.configDictionary = tmpdic;
        [tmpdic release];
        
        tmpdic = [[NSDictionary alloc] initWithContentsOfFile:[Utils getSrcPlistPath:@"errorCode"]];
        self.errorDictionary = tmpdic;
        [tmpdic release];
        
    }
    return self;
}

+ (NSString*)saveImageFile:(UIImage*)image {
//    NSData *imagedata=UIImagePNGRepresentation(image);
    //JEPG格式
    NSData *imagedata=UIImageJPEGRepresentation(image,0.5);
    NSString *tempDirectory=NSTemporaryDirectory();
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *fileName = [NSString stringWithFormat:@"%@_%d.jpg",[formater stringFromDate:[NSDate date]],arc4random()%1000];
    NSString *savedImagePath=[tempDirectory stringByAppendingPathComponent:fileName];
    [imagedata writeToFile:savedImagePath atomically:YES];
    [formater release];
    return savedImagePath;
}


/*
- (void)initShareSDK {
    [ShareSDK registerApp:@"4bc85e7e32f"];
    [self initializePlat];
}

- (void)initializePlat {
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"2466269561" appSecret:@"dc10567186edd4ad24087af1a805d971"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"];
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801375520" appSecret:@"cbc953adc30235fd8ee84b63a6ab1a27"
                                redirectUri:@"http://www.taijiongle.com"];
    
    [ShareSDK connectWeChatWithAppId:@"wx3b825bad3d12129a"
                           wechatCls:[WXApi class]];
    [ShareSDK convertUrlEnabled:NO];
    [ShareSDK setStatPolicy:SSCStatPolicyLimitSize];
}

- (void)shareContent:(id)content withSender:(id)sender {
    [self shareContent:content title:nil url:nil image:nil withSender:sender];
}

- (void)shareContent:(NSString*)content title:(NSString*)title url:(NSString*)url image:(NSString*)imageUrl withSender:(id)sender{
    id<ISSContainer> container = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        container = [ShareSDK container];
        [container setIPadContainerWithView:sender
                                arrowDirect:UIPopoverArrowDirectionDown];
    }
    
    UIImage *imageData = [[HttpRequestCenter shareInstance] getImageWithUrl:imageUrl];
//    if (!imageData) {
//        return;
//    }
    id<ISSCAttachment>image = [ShareSDK pngImageWithImage:imageData];
    //构造分享内容
    id<ISSContent>publishContent=[ShareSDK content:content
                                    defaultContent:@"客道"
                                             image:image
                                             title:title
                                               url:url
                                       description:@"囧图分享"
                                         mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSShareOptions>shareOptions=[ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                           oneKeyShareList:nil qqButtonHidden:YES
                                                     wxSessionButtonHidden:YES wxTimelineButtonHidden:YES showKeyboardOnAppear:YES
                                                         shareViewDelegate:nil friendsViewDelegate:nil
                                                     picViewerViewDelegate:nil];
    
    //    id<ISSShareOptions>shareOptions = [ShareSDK simpleShareOptionsWithTitle:@"内容分享" shareViewDelegate:nil];
    id<ISSAuthOptions>authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                        allowCallback:NO
                                                        authViewStyle:SSAuthViewStyleModal
                                                         viewDelegate:nil
                                              authManagerViewDelegate:nil];
    
    NSMutableArray *shareList = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [shareList addObjectsFromArray:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeTencentWeibo,ShareTypeWeixiSession,ShareTypeWeixiTimeline,nil]];
    }else
    {
        [shareList addObjectsFromArray:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeTencentWeibo,ShareTypeWeixiSession,ShareTypeWeixiTimeline,nil]];
//        [shareList addObjectsFromArray:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeTencentWeibo,ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeSMS,nil]];
    }
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                      authOptions :authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo>
                                     statusInfo,id<ICMErrorInfo>error,BOOL end){
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil];
                                    [alert show];
                                    [alert release];
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode],[error errorDescription]);
                                }
                            }
     ];
}
 */

- (void)dealloc {
    [configDictionary release];
    [m_DataCenter release];
    [super dealloc];
}

@end
