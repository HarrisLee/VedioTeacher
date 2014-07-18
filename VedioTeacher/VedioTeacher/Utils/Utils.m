//
//  Utils.m
//  Hey!XuanWu
//
//  Created by xuchuanyong on 11/26/12.
//  Copyright (c) 2012 q mm. All rights reserved.
//

#import "Utils.h"
#import <dlfcn.h>


@implementation Utils

+ (NSMutableDictionary*)getPropertyWithType:(Class)objClass withSuper:(BOOL)getSuper {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(objClass, &outCount);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:outCount];
    NSMutableArray *typeArray = [NSMutableArray arrayWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if([propertyName isEqualToString:@"primaryKey"]||[propertyName isEqualToString:@"rowid"])
        {
            continue;
        }
        [propertyArray addObject:propertyName];
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         c char
         i int
         l long
         s short
         d double
         f float
         @ id //指针 对象
         ...  BOOL 获取到的表示 方式是 char
         .... ^i 表示  int*  一般都不会用到ƒ
         */
        
        if ([propertyType hasPrefix:@"T@"]) {
            [typeArray addObject:[propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location-4)]];
        }
        else if ([propertyType hasPrefix:@"Ti"])
        {
            [typeArray addObject:@"int"];
        }
        else if ([propertyType hasPrefix:@"Tf"])
        {
            [typeArray addObject:@"float"];
        }
        else if([propertyType hasPrefix:@"Td"]) {
            [typeArray addObject:@"double"];
        }
        else if([propertyType hasPrefix:@"Tl"])
        {
            [typeArray addObject:@"long"];
        }
        else if ([propertyType hasPrefix:@"Tc"]) {
            [typeArray addObject:@"char"];
        }
        else if([propertyType hasPrefix:@"Ts"])
        {
            [typeArray addObject:@"short"];
        }
    }
    free(properties);
    id obj = [[objClass alloc] init];
    if(getSuper && [obj superclass] != [NSObject class])
    {
        NSMutableDictionary *tmpDic = [self getPropertyWithType:[obj superclass]withSuper:getSuper];
        [propertyArray addObjectsFromArray:[tmpDic objectForKey:@"name"]];
        [typeArray addObjectsFromArray:[tmpDic objectForKey:@"type"]];
        
    }
    [obj release];
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:propertyArray,@"name",typeArray,@"type",nil];
}

+ (NSMutableDictionary*)getPropertyWithType:(Class)objClass {
    return [self getPropertyWithType:objClass withSuper:NO];
}

+ (NSMutableArray*)getClassProperty:(Class)objClass withSuper:(BOOL)getSuper {
    return [[self getPropertyWithType:objClass withSuper:getSuper] objectForKey:@"name"];
}

+ (NSMutableArray*)getClassProperty:(Class)class {
    return [[self getPropertyWithType:class] objectForKey:@"name"];
//    unsigned int outCount;
//    objc_property_t *properties = class_copyPropertyList(class, &outCount);
//    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:outCount];
//    for (int i = 0; i < outCount ; i++)
//    {
//        const char* propertyName = property_getName(properties[i]);
//        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
//    }
//    free(properties);
//    return propertyArray;
}

+ (NSMutableArray*)getPropertyArray:(id)obj {
    Class class = [obj class];
    return [self getClassProperty:class];
}

+ (NSMutableDictionary*)getPropertyDic:(id)obj {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *propertyArray = [Utils getPropertyArray:obj];
    for (NSString *name in propertyArray) {
        id value = [obj valueForKey:name];
        if (!value) {
            continue;
        }
        if (![value isKindOfClass:[NSString class]]&&![value isKindOfClass:[NSNumber class]]&&![value isKindOfClass:[NSArray class]]) {
            value = [Utils getPropertyDic:value];
        }
        [dic setObject:value forKey:name];
    }
    return dic;
}

+ (NSString*)getStringFromDic:(NSDictionary*)dic {
    NSError *error;
    if ([dic count]==0) {
        return nil;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    [string stringRemoveWhiteAndEnter];
    return [string autorelease];
}

+ (NSString*)getJsonFromObj:(id)obj {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *propertyArray = [Utils getPropertyArray:obj];
    for (NSString *name in propertyArray) {
        id value = [obj valueForKey:name];
        if (!value) {
            continue;
        }
        if (![value isKindOfClass:[NSString class]]&&![value isKindOfClass:[NSNumber class]]&&![value isKindOfClass:[NSArray class]]) {
            value = [Utils getJsonFromObj:value];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (id arrayObj in (NSArray*)value) {
                if ([arrayObj isKindOfClass:[NSString class]]) {
                    [array addObject:arrayObj];
                } else {
                   [array addObject:[self getJsonFromObj:arrayObj]]; 
                }

            }
            [dic setObject:array forKey:name];
            [array release];
            continue;
        }
        [dic setObject:value forKey:name];
    }
    return [Utils getStringFromDic:dic];
}

+ (void)setProperty:(id)obj withDic:(NSDictionary*)dic {
    NSArray *propertyArray = [Utils getPropertyArray:obj];
    for (NSString *propertyName in propertyArray) {
        [obj setValue:[dic objectForKey:propertyName] forKey:propertyName];
    }
}

typedef NSDictionary *(*PMobileInstallationLookup)(NSDictionary *params, id callback_unknown_usage);
+ (NSDictionary*)getInstalledApps {
    void *lib = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_LAZY);
	if (lib)
	{
		PMobileInstallationLookup pMobileInstallationLookup = (PMobileInstallationLookup)dlsym(lib, "MobileInstallationLookup");
		if (pMobileInstallationLookup)
		{
            //需要获取的应用id列表
			NSArray *wanted = nil;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"User", @"ApplicationType", wanted, @"BundleIDs",nil];
			NSDictionary *dict = pMobileInstallationLookup(params, NULL);
#ifdef DEBUG
//			NSLog(@"%@", dict);
#endif
			return dict;
		}
	}
	return nil;
}

typedef int (*PMobileInstallationInstall)(NSString *path, NSDictionary *dict, void *na, NSString *path2_equal_path_maybe_no_use);
+ (InstallResult)installAppWithPath:(NSString*)path {
    void *lib = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_LAZY);
	if (lib)
	{
		PMobileInstallationInstall pMobileInstallationInstall = (PMobileInstallationInstall)dlsym(lib, "MobileInstallationInstall");
		if (pMobileInstallationInstall)
		{
			NSString *name = [@"Install_" stringByAppendingString:path.lastPathComponent];
			NSString* temp = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
			if (![[NSFileManager defaultManager] copyItemAtPath:path toPath:temp error:nil])
                return InstallResultFileNotFound;
			NSDictionary *typeDic = [NSDictionary dictionaryWithObjectsAndKeys:@"User",@"ApplicationType",nil];
			int ret = (InstallResult)pMobileInstallationInstall(temp, typeDic, 0, path);
			[[NSFileManager defaultManager] removeItemAtPath:temp error:nil];
            if (ret != 0) {
                NSLog(@"IPA 安装失败。\n\n错误代码：%#08X",ret);
            }
			return ret;
		}
	}
    NSLog(@"私有API未找到");
    return InstallResultNoFunction;
}

+ (BOOL)isFileExists:(NSString*)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}


+ (void)copyFiletoDst:(NSString*)fileName withFolder:(NSString*)folder {
    NSString *srcPath = [self getSrcFilePath:fileName];
	NSString *dstPath = [self getDstFilePath:fileName withFolder:folder];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dstPath]) {
        if (![[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dstPath error:nil]) {
            NSLog(@"copy file error!");
        }
    }
}

+ (NSString*)getSrcFilePath:(NSString *)fileName {
    NSString *prefixName = [fileName substringToIndex:[fileName rangeOfString:@"."].location];
    NSString *subfixName = [fileName substringFromIndex:[fileName rangeOfString:@"."].location+1];
    NSString *str = [[NSBundle mainBundle] pathForResource:prefixName ofType:subfixName];
    return str;
}

+ (NSString*)getDstFilePath:(NSString *)fileName withFolder:(NSString*)folder {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取沙盒文件路径，不存在的话创建该路径
	NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:folder];
	if (![fileManager fileExistsAtPath:filePath]) {
		if (![fileManager createDirectoryAtPath:filePath
					withIntermediateDirectories:YES
									 attributes:nil
										  error:nil]) {
			NSLog(@"file directory create failed!");
		}
	}
	return [filePath stringByAppendingPathComponent:fileName];
}


//拷贝应用程序文件
+ (void)copyPlistToDst:(NSString *)fileName
{
	NSString *srcPath = [self getSrcPlistPath:fileName];
	
	NSString *dstPath = [self getDstPlistPath:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dstPath]&&srcPath) {
        if (![[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dstPath error:nil]) {
            NSLog(@"copy plist error!");
        }
    }
}


//获取文件在应用程序里的路径
+ (NSString *)getSrcPlistPath:(NSString *)fileName
{
	return [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
}


//获取文件在沙盒里的路径
+ (NSString *)getDstPlistPath:(NSString *)fileName
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
    //获取沙盒plist路径，不存在的话创建该路径
//	NSString *plistPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"plist"];
    NSString *plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	if (![fileManager fileExistsAtPath:plistPath]) {
		if (![fileManager createDirectoryAtPath:plistPath
					withIntermediateDirectories:YES
									 attributes:nil
										  error:nil]) {
			NSLog(@"plist directory create failed!");
		}
	}
	NSString *withFileType = [fileName stringByAppendingString:@".plist"];
	
	return [plistPath stringByAppendingPathComponent:withFileType];
}

+ (NSString *)documentsPath:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (void)ShowMessage:(NSString *)text onStatusWithTime:(NSTimeInterval)duration {
    UIWindow *statusWindow = [[UIWindow alloc] initWithFrame:CGRectZero];
    statusWindow.backgroundColor = [UIColor clearColor];
    statusWindow.windowLevel = UIWindowLevelStatusBar + 1;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.backgroundColor = [UIColor blackColor];
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.font = [UIFont systemFontOfSize:12.0f];
    [statusWindow addSubview:statusLabel];
    [statusLabel release];
    statusLabel.text = text;
    [statusLabel sizeToFit];
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
//    CGFloat width = rect.size.width/3;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
//    rect.origin.x = rect.size.width - width;
    rect.origin.x = 0;
    rect.size.width = width;
    statusWindow.frame = rect;
//    statusLabel.frame = CGRectMake(0, 0, width-3, height);
    statusLabel.frame = CGRectMake(0, 0, width, height);
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    [mainWindow performSelector:@selector(makeKeyAndVisible) withObject:nil afterDelay:duration];
    [statusWindow performSelector:@selector(release) withObject:nil afterDelay:duration];
    [statusWindow makeKeyAndVisible];
}

+ (void)ShowMessage:(NSString *)text onView:(UIView *)view withTime:(NSUInteger)duration
{
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	label.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont systemFontOfSize:13];
	label.text = text;
	label.numberOfLines = 0;
	label.textAlignment = NSTextAlignmentCenter;
	[view addSubview:label];
	
	CGRect frame2;
	CGRect frame = view.frame;
	frame2.size.width = frame.size.width * 3 / 4;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(frame2.size.width, 1000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
	frame2.size.height = 30 + size.height;
	frame2.origin.x = (frame.size.width - frame2.size.width) / 2;
	frame2.origin.y = (frame.size.height - frame2.size.height) / 2;
	label.frame = frame2;
	label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
	CALayer *layer = label.layer;
	layer.cornerRadius = 8;
	layer.masksToBounds = YES;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelay:duration];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationDelegate:label];
	[UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
	label.alpha = 0;
	[UIView commitAnimations];
}

//显示类似安卓的小的提示效果
+ (void)ShowMessageInView:(NSString *)text onWindowWithTime:(NSTimeInterval)duration {
    UIWindow *statusWindow = [[UIWindow alloc] initWithFrame:CGRectZero];
    statusWindow.backgroundColor = [UIColor clearColor];
    statusWindow.windowLevel = UIWindowLevelStatusBar + 1;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.backgroundColor = [UIColor blackColor];
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.font = [UIFont systemFontOfSize:12.0f];
    [statusWindow addSubview:statusLabel];
    [statusLabel release];
    statusLabel.text = text;
    [statusLabel sizeToFit];
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
    CGFloat width = rect.size.width/3;
    CGFloat height = rect.size.height;
    rect.origin.x = rect.size.width - width*2 - 30;
    rect.size.width = width;
    statusWindow.frame = rect;
    statusLabel.frame = CGRectMake(0, 350, width-3, height);
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    [mainWindow performSelector:@selector(makeKeyAndVisible) withObject:nil afterDelay:duration];
    [statusWindow performSelector:@selector(release) withObject:nil afterDelay:duration];
    [statusWindow makeKeyAndVisible];
}

/*!
 *  类似安卓的Toast提示效果。可以设置提示语和展示时间
 *
 *  @param text     提示语
 *  @param duration 展示时间
 */
+ (void)showToast:(NSString *)text duration:(NSInteger) duration
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //    UIWindow *toast = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenPixWidth, kScreenPixHeight)];
    //    toast.backgroundColor = [UIColor clearColor];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
    CGSize size = [text boundingRectWithSize:CGSizeMake(280, 260) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(15+(280.0-size.width)/2, SCREEN_HEIGHT - 110 - size.height, size.width+10, size.height+15)];
    tView.userInteractionEnabled = NO;
    tView.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.95];
    tView.layer.cornerRadius = 2.0;
    tView.layer.shadowColor = [UIColor blackColor].CGColor;
    tView.layer.shadowOffset = CGSizeMake(2, 2);
    tView.layer.shadowRadius = 2.0;
    [window addSubview:tView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 7.5, size.width, size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = text;
    [tView addSubview:label];
    [label release];
    //    [toast makeKeyAndVisible];
    //    [window performSelector:@selector(makeKeyAndVisible) withObject:nil afterDelay:duration];
    //    [toast performSelector:@selector(release) withObject:nil afterDelay:duration];
    [tView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:duration];
}

+ (void)showToast:(NSString *)text duration:(NSInteger) duration upKeyBoard:(BOOL)isUp
{
    if (!isUp) {
        [self showToast:text duration:duration];
    } else {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        //    UIWindow *toast = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenPixWidth, kScreenPixHeight)];
        //    toast.backgroundColor = [UIColor clearColor];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
        CGSize size = [text boundingRectWithSize:CGSizeMake(280, 260) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(15+(280.0-size.width)/2, SCREEN_HEIGHT - 300 - size.height, size.width+10, size.height+15)];
        tView.userInteractionEnabled = NO;
        tView.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.95];
        tView.layer.cornerRadius = 2.0;
        tView.layer.shadowColor = [UIColor blackColor].CGColor;
        tView.layer.shadowOffset = CGSizeMake(2, 2);
        tView.layer.shadowRadius = 2.0;
        [window addSubview:tView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 7.5, size.width, size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = text;
        [tView addSubview:label];
        [label release];
        //    [toast makeKeyAndVisible];
        //    [window performSelector:@selector(makeKeyAndVisible) withObject:nil afterDelay:duration];
        //    [toast performSelector:@selector(release) withObject:nil afterDelay:duration];
        [tView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:duration];
    }
}

+ (float)getSystemVersion {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

+ (NSString*)stringWithDate:(NSDate*)date andFormat:(NSString*)dateFormat {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormat];
    NSString* datestr = [formatter stringFromDate:date];
    [formatter release];
    return datestr;

}

+ (NSDate*)dateWithString:(NSString*)dateStr andFormat:(NSString*)dateFormat {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormat];
    NSDate* date = [formatter dateFromString:dateStr];
    [formatter release];
    return date;
}

+ (NSString*) dateFromTimeInterval:(NSString *)dateInterval withFormat:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSString *dateStr = [dateInterval substringToIndex:10];
    long long val = [dateStr longLongValue];
    NSDate *d1 = [NSDate dateWithTimeIntervalSince1970:val];
    NSLog(@"Data1 is %@",[formatter stringFromDate:d1]);
    NSString *time = [formatter stringFromDate:d1];
    if ([time hasPrefix:@"AM"]) {
        time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"上午"];
    }
    if ([time hasPrefix:@"PM"]) {
        time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"下午"];
    }
    [formatter release];
    return time;
}

+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format
{
    // format可以形如： @"yyyy-MM-dd"
    NSDate *today = [NSDate date];
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    
    // 时分秒转为00:00:00
    NSDate *today2 = [formatter dateFromString:[formatter stringFromDate:today]];
    NSDate *d1 = [NSDate dateWithTimeIntervalSince1970:[time longLongValue]];
    NSDate *newDate = [formatter dateFromString:[formatter stringFromDate:d1]];
    
    // 时分秒转为00:00:00
    NSDate *newDate2 = [formatter dateFromString:[formatter stringFromDate:newDate]];
    double dToday = [today2 timeIntervalSince1970];
    double dNewDate = [newDate2 timeIntervalSince1970];
    NSInteger nSecs = (NSInteger)(dNewDate - dToday);
    NSInteger oneDaySecs = 24*3600;
    [formatter release];
    return nSecs / oneDaySecs;
}

+ (NSString *) getWeekDay:(NSString *) weekString
{
    if (nil == weekString) {
        return @"";
    }
    
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *date = [Utils dateWithString:weekString andFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (nil == date) {
        return @"";
    }
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    
    NSString *weekStr = nil;
    if(week == 1)
    {
        weekStr= @"星期天";
    }else if(week==2){
        weekStr= @"星期一";
    }else if(week==3){
        weekStr= @"星期二";
    }else if(week==4){
        weekStr= @"星期三";
    }else if(week==5){
        weekStr= @"星期四";
    }else if(week==6){
        weekStr= @"星期五";
    }else if(week==7){
        weekStr= @"星期六";
    }
    [comps release];
    return weekStr;
}


@end


@implementation NSString (extend)

- (NSString *) trimming
{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (NSString *)urlEncodedString
{
    NSString * encodedString = (NSString*) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return [encodedString autorelease];
}

- (NSString *)urlDecodedString
{
    NSString * decodedString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; ;
    return decodedString;
}


- (NSString *)stringByDecodingXMLEntities {
    
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            return result;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            if (gotNumber) {
                [result appendFormat:@"%c", charCode];
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
        }
        else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    }
    while (![scanner isAtEnd]);
    return result;
}

- (NSString *)stringRemoveWhiteAndEnter {
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}



+ (NSData*) base64Decode:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    if (string == nil) {
        return [NSData data];
    }
    ixtext = 0;
    tempcstring = (const unsigned char *)[string UTF8String];
    lentext = [string length];
    theData = [NSMutableData dataWithCapacity: lentext];
    ixinbuf = 0;
    while (true) {
        if (ixtext >= lentext){
            break;
        }
        ch = tempcstring [ixtext++];
        flignore = false;
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                if ((ixinbuf == 1) || (ixinbuf == 2)) {  
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                ixinbuf = 3;
                flbreak = true;
            }
            inbuf [ixinbuf++] = ch;
            if (ixinbuf == 4) {
                ixinbuf = 0;
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            if (flbreak) {
                break;
            }
        }
    }
    return theData;
}



+ (NSString*) base64Encode:(NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    int length = [data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0; 
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) 
            break;
        for (i = 0; i < 3; i++) { 
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1: 
                ctcopy = 2; 
                break;
            case 2:
                ctcopy = 3; 
                break;
        }
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        ixtext += 3;
        charsonline += 4;
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    } 
    return result;
}

+ (NSString*) lationEncode:(NSString*)string
{
    const char *c = [string cStringUsingEncoding:NSISOLatin1StringEncoding];
    return [NSString stringWithCString:c encoding:NSUTF8StringEncoding];

}

@end
