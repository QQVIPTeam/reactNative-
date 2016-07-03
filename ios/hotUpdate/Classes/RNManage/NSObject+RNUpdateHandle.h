//
//  NSObject+RNUpdateHandle.h
//  hotUpdate
//
//  Created by erickchen on 16/6/27.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RCTRootView.h>
#import <RCTBridge.h>
#import "SLFileManager.h"
#import "SLNetworkManager.h"

#define APP_VERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

@interface NSObject (RNUpdateHandle)
@property (nonatomic, strong) NSString *NewAppVersion;

/**
 * 拷贝JS到指定路径
 */
- (BOOL)copyBundleFileToURL:(NSURL *)url;

/**
 * 判断要读取的JS是否已经存在Documents内
 */
- (BOOL)hasCodeInDocumentsDirectory;

/**
 * 获取JS在Documents的路径
 */
- (NSString *)pathForCodeInDocumentsDirectory;

/**
 * 获取JS在项目上的URL
 */
- (NSURL *)URLForCodeInBundle;

/**
 * 获取JS在Documents的URL
 */
- (NSURL *)URLForCodeInDocumentsDirectory;

/**
 * 重置（删除原路径上的文件，重新创建）
 */
- (BOOL)resetJSBundlePath;

/**
 * 初始化rootView
 */
- (RCTRootView *)getRootViewModuleName:(NSString *)moduleName
                         launchOptions:(NSDictionary *)launchOptions;

/**
 * 下载操作
 */
- (void)downloadCodeFrom:(NSString *)srcURLString
                   toURL:(NSURL *)dstURL
         completeHandler:(CompletionBlock)complete;
@end
