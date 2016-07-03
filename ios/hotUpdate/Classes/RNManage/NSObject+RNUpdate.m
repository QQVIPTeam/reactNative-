//
//  NSObject+RNUpdate.m
//  hotUpdate
//
//  Created by erickchen on 16/6/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "NSObject+RNUpdate.h"

@implementation NSObject (RNUpdate)
-(void)download{
  NSLog(@"download");
}

- (NSString *)pathForCodeInDocumentsDirectory {
  NSString *version = APP_VERSION;
  NSString *fileName = [[@"main" stringByAppendingString:version] stringByAppendingPathExtension:@"jsbundle"];
  
  NSString *filePath = [[self JSBundlePath] stringByAppendingPathComponent:fileName];
  return filePath;
}

- (NSURL *)URLForCodeInDocumentsDirectory {
  return [NSURL fileURLWithPath:[self pathForCodeInDocumentsDirectory]];
}

- (BOOL)hasCodeInDocumentsDirectory {
  return [SLFileManager isFileExistAtPath:[self pathForCodeInDocumentsDirectory]];
}

- (BOOL)copyBundleFileToURL:(NSURL *)url {
  NSURL *bundleFileURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  return [SLFileManager copyFileAtURL:bundleFileURL toURL:url];
}



- (NSString *)JSBundlePath {
  NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *bundlePath = [docPath stringByAppendingPathComponent:@"JSBundle"];
  
  if(![SLFileManager isFileExistAtPath:bundlePath]) {
    NSError *error = nil;
    [SLFileManager createDirectory:@"JSBundle" inDirectory:docPath error:&error];
  }
  return bundlePath;
}

- (BOOL)resetJSBundlePath {
  [SLFileManager deleteFileWithPath:[self JSBundlePath] error:nil];
  
  BOOL(^createBundle)(BOOL) = ^(BOOL retry) {
    NSError *error;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    [SLFileManager createDirectory:@"JSBundle" inDirectory:docPath error:&error];
    if (error) {
      if (retry) {
        createBundle(NO);
      } else {
        return NO;
      }
    }
    
    return YES;
  };
  return createBundle(YES);
}


- (NSURL *)URLForCodeInBundle {
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
}

- (RCTBridge *)createBridgeWithBundleURL:(NSURL *)bundleURL {
  return [[RCTBridge alloc] initWithBundleURL:bundleURL moduleProvider:nil launchOptions:nil];
}

- (RCTRootView *)createRootViewWithModuleName:(NSString *)moduleName
                                       bridge:(RCTBridge *)bridge {
  return [[RCTRootView alloc] initWithBridge:bridge moduleName:moduleName initialProperties:nil];
}

- (RCTRootView *)createRootViewWithURL:(NSURL *)url
                            moduleName:(NSString *)moduleName
                         launchOptions:(NSDictionary *)launchOptions {
  return [[RCTRootView alloc] initWithBundleURL:url
                                     moduleName:moduleName
                              initialProperties:nil
                                  launchOptions:launchOptions];
}

//- (RCTRootView *)getRootViewModuleName:(NSString *)moduleName
//                         launchOptions:(NSDictionary *)launchOptions {
//  NSURL *jsCodeLocation = nil;
//  RCTRootView *rootView = nil;
//  jsCodeLocation = [self URLForCodeInDocumentsDirectory];
//  if (![self hasCodeInDocumentsDirectory]) {
//    [self resetJSBundlePath];
//    
//    BOOL copyResult = [self copyBundleFileToURL:jsCodeLocation];
//    if (!copyResult) {
//      jsCodeLocation = [self URLForCodeInBundle];
//    }
//  }
//  RCTBridge *bridge = [self createBridgeWithBundleURL:jsCodeLocation];
//  rootView = [self createRootViewWithModuleName:moduleName bridge:bridge];
//  return rootView;
//  
//}

- (RCTRootView *)getRootViewModuleName:(NSString *)moduleName
                         launchOptions:(NSDictionary *)launchOptions {
  NSURL *jsCodeLocation = nil;
  RCTRootView *rootView = nil;
#if DEBUG
#if TARGET_OS_SIMULATOR
  //debug simulator
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=false"];
  
#else
  //debug device
  NSString *serverIP = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SERVER_IP"];
  NSString *jsCodeUrlString = [NSString stringWithFormat:@"http://%@:8081/index.ios.bundle?platform=ios&dev=true", serverIP];
  NSString *jsBundleUrlString = [jsCodeUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  jsCodeLocation = [NSURL URLWithString:jsBundleUrlString];
#endif
  rootView = [self createRootViewWithURL:jsCodeLocation moduleName:moduleName launchOptions:launchOptions];
  
#else
  //production
  jsCodeLocation = [self URLForCodeInDocumentsDirectory];
  
  NSLog(@"%@",jsCodeLocation);
  if (![self hasCodeInDocumentsDirectory]) {
    [self resetJSBundlePath];
    
    BOOL copyResult = [self copyBundleFileToURL:jsCodeLocation];
    if (!copyResult) {
      jsCodeLocation = [self URLForCodeInBundle];
    }
  }
  RCTBridge *bridge = [self createBridgeWithBundleURL:jsCodeLocation];
  rootView = [self createRootViewWithModuleName:moduleName bridge:bridge];
  
#endif
  
#if 0 && DEBUG
  NSLog(@"xxxx");
  jsCodeLocation = [self URLForCodeInDocumentsDirectory];
  if (![self hasCodeInDocumentsDirectory]) {
    [self resetJSBundlePath];
    
    BOOL copyResult = [self copyBundleFileToURL:jsCodeLocation];
    if (!copyResult) {
      jsCodeLocation = [self URLForCodeInBundle];
    }
  }
  RCTBridge *bridge = [self createBridgeWithBundleURL:jsCodeLocation];
  rootView = [self createRootViewWithModuleName:moduleName bridge:bridge];
#endif
  return rootView;
}

@end
