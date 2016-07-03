//
//  RNHandle.m
//  hotUpdate
//
//  Created by erickchen on 16/6/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <RCTRootView.h>
#import "RNHandle.h"
#import <RCTBridge.h>
//#import "NSObject+RNUpdate.h"
#import "NSObject+RNUpdateHandle.h"

@implementation RNHandle

@synthesize bridge = _bridge;



RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(updateVersion:(NSString *)newVersion currentVersion:(NSString *)currentVersion downloadUrl:(NSString *)downloadUrl callback:(RCTResponseSenderBlock)callback) {
  
   [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeNameNotification" object:self userInfo:@{@"newVersion":newVersion}];
  
  
  //与app version进行对比
//  NSString *app_Version = APP_VERSION;
//  NSLog(@"%@",app_Version);
//  NSLog(@"%@",newVersion);
  
//  if(app_Version < newVersion){
//    AppVersion = newVersion;
  
    
//    NSString *base = [downloadUrl stringByAppendingString:AppVersion];
//    NSString *uRLStr = [base stringByAppendingString:@"/main.json"];
//    NSURL *dstURL = [self URLForCodeInDocumentsDirectory];
    
//    NSLog(@"main.json--%@",uRLStr);
//    NSLog(@"dstURL--%@",dstURL);
    
//    NSURL *jsCodeLocation = [self URLForCodeInDocumentsDirectory];
//    BOOL copyResult = [self copyBundleFileToURL:jsCodeLocation];
//    if (!copyResult) {
//      jsCodeLocation = [self URLForCodeInBundle];
//    }
//    
//    NSLog(@"jsCodeLocation--%@",jsCodeLocation);
//    [self downloadCodeFrom:uRLStr toURL:dstURL completeHandler:^(BOOL result) {
////              NSLog(@"%@",AppVersion);
//        
//    }];
    

    
//  }
  
  
  //    if (!newVersion) {
  //        callback(@[[NSNull null]]);
  //    } else {
  //        callback(@[newVersion]);
  //    }
  
  [self.bridge.eventDispatcher sendAppEventWithName:@"updateProgressEvent" body:@"i am from native"];
}

//- (void)downloadCodeFrom:(NSString *)srcURLString
//                   toURL:(NSURL *)dstURL
//         completeHandler:(CompletionBlock)complete {
//  //下载JS
//  [SLNetworkManager sendWithRequestMethor:(RequestMethodGET) URLString:srcURLString parameters:nil error:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
//    if (connectionError) {
//      NSLog(@"下载JS");
//      return;
//    }
//    
//    NSLog(@"%@",srcURLString);
//    
//    NSLog(@"%@",dstURL);
//    
//    NSError *error = nil;
//    [data writeToURL:dstURL options:(NSDataWritingAtomic) error:&error];
//    if (error) {
//      NSLog(@"error");
//      !complete ?: complete(NO);
//      //写入失败，删除
//      [SLFileManager deleteFileWithURL:dstURL error:nil];
//    } else {
//      NSLog(@"写入成功");
//      !complete ?: complete(YES);
//    }
//  }];
//  
//}


//- (BOOL)copyBundleFileToURL:(NSURL *)url {
//  NSURL *bundleFileURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//  return [SLFileManager copyFileAtURL:bundleFileURL toURL:url];
//}
//
//
//
//- (NSURL *)URLForCodeInBundle {
//  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//}


@end

