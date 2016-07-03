//
//  NSObject+RNUpdate.h
//  hotUpdate
//
//  Created by erickchen on 16/6/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RCTRootView.h>
#import <RCTBridge.h>
#import "SLFileManager.h"
#import "SLNetworkManager.h"

#define APP_VERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

@interface NSObject (RNUpdate)

- (NSURL *)URLForCodeInDocumentsDirectory;
- (RCTRootView *)getRootViewModuleName:(NSString *)moduleName
                         launchOptions:(NSDictionary *)launchOptions;
@end
