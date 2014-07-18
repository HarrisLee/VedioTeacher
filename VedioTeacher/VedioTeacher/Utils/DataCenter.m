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
@synthesize loginName;
@synthesize loginId;
@synthesize topDirectory;
@synthesize taskDirId;

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

        [Utils copyPlistToDst:@"Config"];
        NSDictionary *tmpdic = [[NSDictionary alloc] initWithContentsOfFile:[Utils getDstPlistPath:@"Config"]];
        self.configDictionary = tmpdic;
        [tmpdic release];
        
        tmpdic = [[NSDictionary alloc] initWithContentsOfFile:[Utils getSrcPlistPath:@"errorCode"]];
        self.errorDictionary = tmpdic;
        [tmpdic release];
        
        topDirectory = [[NSMutableArray alloc] init];
        
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

- (void)dealloc {
    [configDictionary release];
    [errorDictionary release];
    [m_DataCenter release];
    [topDirectory release];
    [taskDirId release];
    [userInfo release];
    [loginId release];
    [loginName release];
    [super dealloc];
}

@end
