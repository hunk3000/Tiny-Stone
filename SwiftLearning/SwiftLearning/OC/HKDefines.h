//
//  HKDefines.h
//  superHDPaper
//
//  Created by Hunk on 14-4-2.
//  Copyright (c) 2014年 your company. All rights reserved.
//

#ifndef superHDPaper_HKDefines_h
#define superHDPaper_HKDefines_h

//------------------ Application Configuration ------------------

#define kAppVer     @"1.0"
#define kAppID      @"860481364"
#define kAppBundle  @"com.tiny-stone.superpaper"
#define kAppName    @"虫虫壁纸"
#define kAdmobID    @"a15347a977c5df7"
#define kUmengAppKey @"5347a71056240bb3170286cd"

#define url_base    @"http://superpaper.sinaapp.com"
#define url_store   @"http://superpaper-images.stor.sinaapp.com"
#define url_api     [NSString stringWithFormat:@"%@/api.php",url_base]
#define url_about   [NSString stringWithFormat:@"%@/doc/about.php",url_base]

#define KEY_DIC     @"com.tiny-stone.superpaper.dic"
#define KEY_UDID    @"com.tiny-stone.superpaper.udid"

#define MENU_BAR_HEIGHT 34      // 菜单栏高度设置
#define kFeedbackEmail @"code637@gmail.com"

#define kSettingNeverRate @"neverRate"
#define kSettingLastShowSoftRemindDate @"lastSoftRemindDate"
#define kSoftRemindDuration (3600 * 12)


//------------------ Debug/Release ------------------
#ifdef DEBUG

#else
//屏蔽NSLog
#define NSLog(...) {};

#endif

//------------------ Simulator/Device ------------------
//区分模拟器和真机
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//------------------ ARC/no RAC ------------------
//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//------------------ System ------------------
#define PasteString(string)   [[UIPasteboard generalPasteboard] setString:string];
#define PasteImage(image)     [[UIPasteboard generalPasteboard] setImage:image];

//转换
#define I2S(number) [NSString stringWithFormat:@"%d",number]
#define UI2S(number) [NSString stringWithFormat:@"%lu",number]
#define F2S(number) [NSString stringWithFormat:@"%f",number]


//color
#define RGB(r, g, b) [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:(a)]

#define ScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth    ([UIScreen mainScreen].bounds.size.width)

//Device
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] intValue]==7)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>=4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>=5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>=6)
#define isAfterIOS7 ([[[UIDevice currentDevice] systemVersion] intValue]>=7)


#define isRetina ([[UIScreen mainScreen] scale]==2)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define HKLocalizedString(r) NSLocalizedStringFromTable(r, @"Locale", @"")

//拨打电话
#define canTel                 ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)       ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])

//打开URL
#define canOpenURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define openURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])

#endif
