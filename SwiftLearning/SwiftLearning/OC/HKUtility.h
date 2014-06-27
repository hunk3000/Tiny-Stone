//
//  HKUtility.h
//  commasoftware.framework
//
//  Created by Han Kui on 12-6-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface HKUtility : NSObject
<UIAlertViewDelegate,UIActionSheetDelegate>
{
    AVAudioPlayer *_myPlayer;               //用于播放音频文件
}

//单例
+(HKUtility *)sharedUtility;

#pragma mark - 日期操作相关函数
+(NSString *)dateline;
+(NSString *)datelineToString:(NSString *)aDateline;
+(NSString *)datelineToString:(NSString *)aDateline Format:(NSString *)aFormat;
+(NSString *)dateline2ViewDate:(NSString *)aDateline;
+(NSString *)dateStrWithFormat:(NSString *)aFormat date:(NSDate *)aDate;
+(NSString *)dateStrWithFormat:(NSString *)aFormat;

#pragma mark - 目录操作相关函数
+(NSString *)dataFolder; //数据保存目录
+(NSString *)documentsDirectory;
+(NSString *)documentsDirectoryAppendWith:(NSString *)aFolder;
+(NSString *)libraryDirectory;
+(NSString *)libraryDirectoryAppendWith:(NSString *)aFolder;
+(NSString *)resourceDirectory;
+(NSString *)encodeUrl:(NSString *)org_url;

+ (NSString*) createUUID;

#pragma mark - 字符串和整形互转
+(NSInteger)str2int:(NSString *)aString;
+(NSString *)int2str:(NSInteger)aInt;
+(NSString *)trimString:(NSString *)orgString;
+(NSString *)usernameFromDeviceName;

#pragma mark - 检查邮箱和手机号格式
+(BOOL)isEmail: (NSString *) candidate;
+(BOOL)isMobileNumber: (NSString *) candidate;
+(BOOL)hasOrderIndex:(NSString *) candidate;
+(NSString *)removeOrderString:(NSString *) candidate;
+(NSString *)removeFuncString:(NSString *) candidate;
+(NSString *)removeExtString:(NSString *) candidate;
+(NSString *)getFuncString:(NSString *) candidate;
+(NSMutableDictionary *)parseURLQuery:(NSString *)queryString;

#pragma mark - 显示UIAlertView提示框
+(void)showMessageBoxWithTitle:(NSString *)aTitle 
                      ButtonOK:(NSString *)aStringOK 
                  ButtonCancel:(NSString *)aStringCancel
             MessageWithFormat:(NSString *)format, ...;
+(void)showMessageBoxWithFormat:(NSString *)format,...;
+(void)showMessageBox:(NSString *)aMessage;
+(void)showMessageBox:(NSString *)aMessage withTitle:(NSString *)aTitle;

#pragma mark - 播放音频相关
+(void)playVibrate;
+(void)playSound:(NSString *)filename;
-(void)playFileWithAudioPlayer:(NSString *)filename;
+(void)playMediaFileWithContentURL:(NSURL *)contentURL fromViewController:(UIViewController *)vc;

#pragma mark - Others
+(NSString *)getDeviceInfo;

@end
