//
//  ViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-1.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SayHello.h"
#import "UtilsGather.h"

@interface ViewController ()
{
    UIImageView *img;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [img setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:img];
    [img release];
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVedio)];
//    img.userInteractionEnabled = YES;
//    [img addGestureRecognizer:tap];
//    [tap release];

    SayHello *say = [[SayHello alloc] init];
    [say sayMessage:@"Utils Test"];
    NSLog(@"%@",[say sayMessage:@"Utils Test"]);
    
    UtilsGather *utls = [[UtilsGather alloc] init];
    [utls sayUtils:@"Utils Test"];
    NSLog(@"%@",[utls sayUtils:@"Utils Test"]);
    
    NSLog(@"%.@", NSStringFromCGRect([[UIApplication sharedApplication] statusBarFrame]) );
  
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"%.@", NSStringFromCGRect([[UIApplication sharedApplication] statusBarFrame]) );
    
    NSLog(@"%.2f",self.navigationController.navigationBar.frame.size.height);
}

-(void) playVedio
{
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://feiclass.winnovo.com/fileupload/feiclass/course_file/20140522/14007534063406838420MTE=.mp4"]]];
    [self.view addSubview:web];
    [web release];
}

-(void) viewDidAppear:(BOOL)animated
{
    [img setImage:[self thumbnailImageForVideo:[NSURL URLWithString:@"http://feiclass.winnovo.com/fileupload/feiclass/course_file/20140522/14007534063406838420MTE=.mp4"] atTime:480.0]];
}

-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[[AVURLAsset alloc] initWithURL:videoURL options:nil] autorelease];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[[AVAssetImageGenerator alloc] initWithAsset:asset] autorelease];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[[UIImage alloc] initWithCGImage:thumbnailImageRef] autorelease] : nil;
    
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
