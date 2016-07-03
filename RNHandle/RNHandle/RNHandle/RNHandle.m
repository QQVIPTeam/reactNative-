//
//  RNHandle.m
//  hotUpdate
//
//  Created by erickchen on 16/6/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNHandle.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation RNHandle

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

//RCT_EXPORT_METHOD(download:(NSString *)source targetPath:(NSString *)targetPath downloadFileName:(NSString *)fileName headers:(NSDictionary *)headers callback:(RCTResponseSenderBlock)callback) {
//
//}

RCT_EXPORT_METHOD(updateVersion:(NSString *)newVersion currentVersion:(NSString *)currentVersion callback:(RCTResponseSenderBlock)callback) {
    
    //  [self updatehandleProgressEvent:0 total:1];
    
    //  NSLog(@"newVersion is -%p",newVersion);
    //  if(!newVersion)
    //    callback(@[@"newVersion need to be not null"]);
    
    //  BOOL success = !newVersion ? YES : NO;
    
    //  [self updatehandleProgressEvent:1 total:1];
    
    //  [self.bridge.eventDispatcher sendAppEventWithName:@"updateProgressEvent" body:@{@"progress": @"done"}];
    [self.bridge.eventDispatcher sendAppEventWithName:@"updateProgressEvent"
                                                 body:@{@"name": @"erickchen"}];
    
    if (!newVersion) {
        callback(@[[NSNull null]]);
    } else {
        callback(@[newVersion]);
    }
}

//- (void)updatehandleProgressEvent:(NSInteger)loaded total:(NSInteger)total {
//  if (total == 0) {
//    return;
//  }
//
//  // TODO: should send the filename, just like the Android version
//  [self.bridge.eventDispatcher sendAppEventWithName:@"updateProgressEvent" body:@{@"progress": @"done"}];
//}

//[self.bridge.eventDispatcher sendAppEventWithName:[@"RNFileDownloadProgress" stringByAppendingString:downloadTask.originalRequest.URL.absoluteString]
//                                             body:@{
//                                                    @"filename": self.downloadFileName,
//                                                    @"sourceUrl": downloadTask.originalRequest.URL.absoluteString,
//                                                    @"targetPath": self.targetPath,
//                                                    @"bytesWritten": @(bytesWritten),
//                                                    @"totalBytesWritten": @(totalBytesWritten),
//                                                    @"totalBytesExpectedToWrite": @(totalBytesExpectedToWrite),
//                                                    }];

//RCT_EXPORT_METHOD(unzip:(NSString *)zipPath destinationPath:(NSString *)destinationPath callback:(RCTResponseSenderBlock)callback) {
//
//  [self zipArchiveProgressEvent:0 total:1]; // force 0%
//
//  BOOL success = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath delegate:self];
//
//  [self zipArchiveProgressEvent:1 total:1]; // force 100%
//
//  if (success) {
//    callback(@[[NSNull null]]);
//  } else {
//    callback(@[@"unzip error"]);
//  }
//}
//
//- (void)zipArchiveProgressEvent:(NSInteger)loaded total:(NSInteger)total {
//  if (total == 0) {
//    return;
//  }
//
//  // TODO: should send the filename, just like the Android version
//  [self.bridge.eventDispatcher sendAppEventWithName:@"zipArchiveProgressEvent" body:@{
//                                                                                      @"progress": @( (float)loaded / (float)total )
//                                                                                      }];
//}

@end

