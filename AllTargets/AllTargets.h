//
//  AllTargets.h
//  AllTargets
//
//  Created by Jobs on 15/2/22.
//  Copyright (c) 2015年 Jobs. All rights reserved.
//

#import <AppKit/AppKit.h>

@class ATSavedData;

@interface AllTargets : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle *bundle;
@property (nonatomic, strong, readonly) ATSavedData *savedData;

@end