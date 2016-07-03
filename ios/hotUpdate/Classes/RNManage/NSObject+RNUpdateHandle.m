//
//  NSObject+RNUpdateHandle.m
//  hotUpdate
//
//  Created by erickchen on 16/6/27.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "NSObject+RNUpdateHandle.h"
#import "RNHandle.h"
#import <objc/runtime.h>
static const void *IndieBandNameKey = &IndieBandNameKey;
@implementation NSObject (RNUpdateHandle)

@dynamic NewAppVersion;

+ (void)load{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"ChangeNameNotification" object:nil];
  NSLog(@"initinitinitinitinit");
}

- (NSString *)NewAppVersion {
  return objc_getAssociatedObject(self, IndieBandNameKey);
}

-(void)setAppVersion:(NSString *)NewAppVersion{
  objc_setAssociatedObject(self, IndieBandNameKey, NewAppVersion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)ChangeNameNotification:(NSNotification*)notification{
  NSDictionary *nameDictionary = [notification userInfo];
  [self setAppVersion:[nameDictionary objectForKey:@"newVersion"]];
  NSLog(@"version----%@",self.NewAppVersion);
}


//start
- (RCTRootView *)getRootViewModuleName:(NSString *)moduleName
                         launchOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation = nil;
  RCTRootView *rootView = nil;
#if DEBUG
  //debug版本
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
  
#else
  //release版本
  //获取document中main.jsboundle文件路径
  jsCodeLocation = [self URLForCodeInDocumentsDirectory];
  
  
  //检测jsCodeLocation目录中是否存在main.jsboundle
  BOOL isFileExit = [self hasCodeInDocumentsDirectory];
  if (!isFileExit) {
    //重新创建jsboundle目录
    [self resetJSBundlePath];
    //如果document目录中不存在jsboundle文件，从项目中拷贝一份
//    BOOL copyResult = [self copyBundleFileToURL:jsCodeLocation];
//    if (!copyResult) {
//      jsCodeLocation = [self URLForCodeInBundle];
//    }
    jsCodeLocation = [self URLForCodeInBundle];
    
  }
  NSLog(@"%@",jsCodeLocation);
#endif
  RCTBridge *bridge = [self createBridgeWithBundleURL:jsCodeLocation];
  rootView = [self createRootViewWithModuleName:moduleName bridge:bridge];
  return rootView;
}




- (NSString *)pathForCodeInDocumentsDirectory {
//  NSString *version = self.NewAppVersion==nil ? APP_VERSION : self.NewAppVersion;
//  NSLog(@"version----%@",version);
//  NSString *fileName = [[@"main" stringByAppendingString:version] stringByAppendingPathExtension:@"jsbundle"];
   NSString *fileName = [@"main" stringByAppendingPathExtension:@"jsbundle"];
  
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

@end
