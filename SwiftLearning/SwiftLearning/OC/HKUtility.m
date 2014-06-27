//
//  HKUtility.m
//  commasoftware.framework
//
//  Created by Han Kui on 12-6-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HKUtility.h"
#import "HKDefines.h"

@implementation HKUtility

static HKUtility * _sharedInstance = nil;

+ (HKUtility *)sharedUtility
{
    @synchronized (self) 
	{
        if (_sharedInstance == nil) 
		{
            _sharedInstance = [[self alloc] init];
		}
    }
    return _sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        //init code
    }
    return self;
}


#pragma mark - 日期操作相关函数
+(NSString *)dateline
{
	NSDate *date = [NSDate date];
	NSTimeInterval dateline = [date timeIntervalSince1970];
	return [NSString stringWithFormat:@"%.0f",dateline];
}

+(NSString *)datelineToString:(NSString *)aDateline
{
	NSScanner *scanner = [NSScanner scannerWithString:aDateline];
	double d;
	[scanner scanDouble:&d];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:d];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [dateFormatter stringFromDate:date];
}

+(NSString *)datelineToString:(NSString *)aDateline Format:(NSString *)aFormat
{
	NSScanner *scanner = [NSScanner scannerWithString:aDateline];
	double d;
	[scanner scanDouble:&d];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:d];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:aFormat];
	return [dateFormatter stringFromDate:date];
}

+(NSString*) dateline2ViewDate:(NSString *)aDateline;
{
    
	if (aDateline==nil) 
    {
		return @"";
	}
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:[aDateline doubleValue]];
    
	NSDate *today = [NSDate date];
	NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
	NSDate *beforYesterday = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*2];
	
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy年MM月dd日"];
	
	NSString *strToday = [format stringFromDate:today];
	NSString *strYesterday = [format stringFromDate:yesterday];
	NSString *strBeforeYesterday = [format stringFromDate:beforYesterday];
	NSString *strMsgDay= [format stringFromDate:msgDate];
	
	NSString *ret = nil;
	if([strMsgDay compare:strToday] == NSOrderedSame){
	 	[format setDateFormat:@"HH:mm"];
		NSTimeInterval interval = [today timeIntervalSinceDate:msgDate];
        NSInteger minute = interval/60;
        NSInteger hour = interval/3600;
        if (hour == 0 && minute <= 0)
        {
            ret = @"刚刚";
        }
        else if(hour == 0 && minute > 0)
        {
            ret = [NSString stringWithFormat:@"%d分钟前",minute];
        }
        else if(hour != 0)
        {
            ret = [NSString stringWithFormat:@"%d小时前",hour];
        }
        else
        {
            
        }
	}
	else if([strMsgDay compare:strYesterday] == NSOrderedSame){
		ret = @"昨天";
	}
	else if([strMsgDay compare:strBeforeYesterday] == NSOrderedSame){
		ret = @"前天";
	}else{
		[format setDateFormat:@"MM-dd"];
		ret = [format stringFromDate:msgDate];
	}	
	
	return ret;
}

+(NSString *)dateStrWithFormat:(NSString *)aFormat
{
	NSDate *date = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:aFormat];
	return [dateFormatter stringFromDate:date];
}

+(NSString *)dateStrWithFormat:(NSString *)aFormat date:(NSDate *)aDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:aFormat];
	return [dateFormatter stringFromDate:aDate];
}

#pragma mark - 目录操作相关函数
+(NSString *)documentsDirectory
{
	NSString *ret = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
	//[self createDirectoryIfNotExist:ret];
	return ret;
}

+(NSString *)documentsDirectoryAppendWith:(NSString *)aFolder
{
	NSString *ret = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),aFolder];
	[self createDirectoryIfNotExist:ret];
	return ret;
}

+(NSString *)dataFolder {
    return [HKUtility libraryDirectoryAppendWith:@"data"];
}

+(NSString *)libraryDirectory
{
	NSString *ret = [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()];
	[self createDirectoryIfNotExist:ret];
	return ret;
}

+(NSString *)libraryDirectoryAppendWith:(NSString *)aFolder
{
	NSString *ret = [NSString stringWithFormat:@"%@/Library/Caches/%@",NSHomeDirectory(),aFolder];
	[self createDirectoryIfNotExist:ret];
	return ret;
}

+(NSString *)resourceDirectory
{
	NSString *tmp = [[NSBundle mainBundle] resourcePath];
	NSString *ret = [NSString stringWithFormat:@"%@/",tmp];
	return ret;
}

+(void)createDirectoryIfNotExist:(NSString *)aDir
{
	if(![[NSFileManager defaultManager] fileExistsAtPath:aDir])
	{
		//Create Directory
		[[NSFileManager defaultManager] 
		 createDirectoryAtPath:aDir 
		 withIntermediateDirectories:YES 
		 attributes:nil 
		 error:nil
		 ];
	}
}

+(NSString *)encodeUrl:(NSString *)org_url {
    return [org_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - UUID
+ (NSString*) createUUID
{
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark - 字符串和整形互转
+(NSInteger)str2int:(NSString *)aString
{
	NSInteger retVal;
	NSScanner *scanner = [NSScanner scannerWithString:aString];
	[scanner scanInteger:&retVal];
	return retVal;
}

+(NSString *)int2str:(NSInteger)aInt
{
    return [NSString stringWithFormat:@"%d",aInt];
}

+(NSString *)trimString:(NSString *)orgString
{
    return [orgString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)usernameFromDeviceName
{
    NSString *theStr = [UIDevice currentDevice].name;
    NSString *userName = nil;
    if ([theStr length] != 0)
    {
        //将”“去掉
        theStr = [theStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        theStr = [theStr stringByReplacingOccurrencesOfString:@"”" withString:@""];
        theStr = [theStr stringByReplacingOccurrencesOfString:@"“" withString:@""];
        //NSLog(@"theStr = %@",theStr);
        //找到最后一个"的"或最后一个"‘s"
        userName = [theStr substringToIndex:[self findTheLastCharacter:theStr]];
        //NSLog(@"userName = %@",userName);
        if ([userName length] == 0)
        {
            userName = [[UIDevice currentDevice] name];
        }
    }
    if (userName == nil) {
        userName = @"guest";
    }
    return userName;
}

+ (int)findTheLastCharacter :(NSString *)theStr
{
    int location = 0;
    
    for (int i = [theStr length] -1; i >= 0; i--)
    {
        NSRange theStrRange = NSMakeRange(i, 1);
        if ([[theStr substringWithRange:theStrRange] isEqualToString:@"的"])
        {
            location = i;
            break;
        }
        else if ([[theStr substringWithRange:theStrRange] isEqualToString:@"s"])
        {
            if (i > 1)
            {
                NSRange sRange = NSMakeRange(i-1, 1);
                if ([[theStr substringWithRange:sRange] isEqualToString:@"'"])
                {
                    location = i -1;
                    break;
                }
            }
        }
    }
    return location;
}


#pragma mark - 检查邮箱地址和手机号

+(BOOL)isEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:candidate];
}

+(BOOL)isMobileNumber: (NSString *) candidate
{
    NSString *emailRegex = @"1[358][0-9]{9}$"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:candidate];
}

+(BOOL)hasOrderIndex:(NSString *) candidate {
    NSArray *arr = [candidate componentsSeparatedByString:@"."];
    if ([arr count]>0) {
        if ([arr count] == 1) {
            return NO;
        }
        NSString *head = [arr objectAtIndex:0];
        if ([head isEqualToString:@"0"]) {
            return YES;
        }
        NSInteger headValue = 0;
        @try {
            headValue = [head integerValue];
        }
        @catch (NSException *exception) {
            return NO;
        }
        @finally {
            
        }
        if (headValue > 0) {
            return YES;
        }
    }
    return NO;
}

+(NSString *)removeOrderString:(NSString *) candidate {
    if ([HKUtility hasOrderIndex:candidate]) {
        NSArray *arr = [candidate componentsSeparatedByString:@"."];
        NSString *head = [arr objectAtIndex:0];
        return [candidate substringFromIndex:([head length]+1)];
    }
    return candidate;
}

+(NSString *)removeFuncString:(NSString *) candidate {
    NSArray *arr = [candidate componentsSeparatedByString:@"."];
    NSString *funcStr = arr[0];
    if ([[funcStr substringToIndex:1] isEqualToString:@"_"]) {
        return [candidate substringFromIndex:([funcStr length]+1)];
    }
    return candidate;
}

+(NSString *)removeExtString:(NSString *) candidate {
    NSArray *arr = [candidate componentsSeparatedByString:@"."];
    NSString *extStr = [arr lastObject];
    if ([extStr isEqualToString:[candidate pathExtension]]) {
        return [candidate substringToIndex:[candidate length]-[extStr length]-1];
    }
    return candidate;
}

+(NSString *)getFuncString:(NSString *) candidate {
    NSArray *arr = [candidate componentsSeparatedByString:@"."];
    NSString *funcStr = arr[0];
    if ([[funcStr substringToIndex:1] isEqualToString:@"_"]) {
        return [funcStr substringFromIndex:1];
    }
    return nil;
}

+(NSMutableDictionary *)parseURLQuery:(NSString *)queryString {
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    NSArray *arr = [queryString componentsSeparatedByString:@"&"];
    if ([arr count]>0) {
        for (NSString *q in arr) {
            NSArray *lst = [q componentsSeparatedByString:@"="];
            if ([lst count]>1) {
                [ret setObject:lst[1] forKey:lst[0]];
            }
        }
    }
    
    return ret;
}


#pragma mark - 显示UIAlertView提示框
+(void)showMessageBoxWithTitle:(NSString *)aTitle 
                      ButtonOK:(NSString *)aStringOK 
                  ButtonCancel:(NSString *)aStringCancel
             MessageWithFormat:(NSString *)format, ...
{
    NSString *msg = nil;
    
    if ( format )
	{
		va_list args;
		va_start( args, format );
        
		msg = [[ NSString alloc ] initWithFormat: format arguments: args ];
		va_end( args );
	}
    if(msg == nil)
	{
		msg = @"input message is nil";
	}
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
													message:msg
												   delegate:nil
										  cancelButtonTitle:aStringCancel
										  otherButtonTitles:aStringOK,nil];
	[alert show];
    
}

+(void)showMessageBoxWithFormat:(NSString *)format,...
{
    NSString *msg = nil;
    
    if ( format )
	{
		va_list args;
		va_start( args, format );
        
		msg = [[ NSString alloc ] initWithFormat: format arguments: args ];
		va_end( args );
	}
    if(msg == nil)
	{
		msg = @"input message is nil";
	}
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:HKLocalizedString(@"Alert")
													message:msg
												   delegate:nil
										  cancelButtonTitle:nil
										  otherButtonTitles:HKLocalizedString(@"OK"),nil];
	[alert show];
}

+(void)showMessageBox:(NSString *)aMessage
{
	[self showMessageBoxWithFormat:aMessage];
}

+(void)showMessageBox:(NSString *)aMessage withTitle:(NSString *)aTitle
{
	[self showMessageBoxWithTitle:aTitle ButtonOK:HKLocalizedString(@"OK") ButtonCancel:nil MessageWithFormat:aMessage];
}

#pragma mark - 音频播放相关
+(void)playVibrate
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

+(void)playSound:(NSString *)filename
{
	NSString *path = nil;
    NSString *name = [filename substringToIndex:([filename length]-4)];
	path =  [[NSBundle mainBundle] pathForResource:name ofType:[filename pathExtension]];
    
    CFURLRef soundFileURLRef = (__bridge CFURLRef)[NSURL URLWithString:path];
	SystemSoundID sid;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&sid);
    AudioServicesPlaySystemSound(sid);
}

-(void)playFileWithAudioPlayer:(NSString *)filename
{
    if (filename == nil) {
        [_myPlayer stop];
        return;
    }
    
    //支持后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    UInt32 category = kAudioSessionCategory_AmbientSound;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    NSURL *musicURL = nil;
    NSArray *pathComponents = [filename pathComponents];
    if ([pathComponents count] == 1) {
        NSString *name = [filename substringToIndex:([filename length]-4)];
        NSString *path =  [[NSBundle mainBundle] pathForResource:name ofType:[filename pathExtension]];
        musicURL = [[NSURL alloc] initFileURLWithPath:path];
        
    } else if([pathComponents count] > 1) {
        
        musicURL = [[NSURL alloc] initFileURLWithPath:filename];
        
    }
    
    NSError *err;
    AVAudioPlayer *thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&err];
    _myPlayer = nil;
    _myPlayer = thePlayer;
    
    [_myPlayer prepareToPlay];
    [_myPlayer setVolume:1.0];   //设置音量大小
    _myPlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
    [_myPlayer play];
}

+(void)playMediaFileWithContentURL:(NSURL *)contentURL fromViewController:(UIViewController *)vc {
    
    //支持后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version >= 3.0 && version < 3.2)
	{
		MPMoviePlayerController *myPlayer=[[MPMoviePlayerController alloc] initWithContentURL:contentURL];
		myPlayer.repeatMode = YES;
		[myPlayer play];
	}
	else if(version >= 3.2)
	{
		MPMoviePlayerViewController *thePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:contentURL];
		thePlayer.moviePlayer.repeatMode = NO;
        thePlayer.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        thePlayer.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [thePlayer.moviePlayer play];
		[vc presentMoviePlayerViewControllerAnimated:thePlayer];
	}
    
}

//+(void)playAudioFile:(NSString *)aFilePath Object:(id)aObject
//{
//	if (![[NSFileManager defaultManager] fileExistsAtPath:aFilePath])
//	{
//		[Utility showMessageBox:@"Audio file does not exist."];
//		return;
//	}
//	
//	NSURL *url = [NSURL fileURLWithPath:aFilePath];
//
//}

#pragma mark - Others

+(NSString *)getDeviceInfo {
    NSString *retValue = nil;
    
    UIDevice *d = [UIDevice currentDevice];
    
    retValue = [NSString stringWithFormat:@"\n\n\nOSVer:%@ \nModel:%@ \n",d.systemVersion,d.model];
    
    return retValue;
}

@end
