//
//  Xcode3TargetMembershipDataSource+HookAllTargets.m
//  AllTargets
//
//  Created by Jobs on 15/6/21.
//  Copyright (c) 2015年 Jobs. All rights reserved.
//

#import "Xcode3TargetMembershipDataSource+HookAllTargets.h"
#import "Xcode3TargetWrapper.h"
#import "AllTargets.h"
#import "ATSavedData.h"

static NSString * const WrappedTargetsKey        = @"wrappedTargets";
static NSString * const ProductTypeKey           = @"productType";

static NSString * const ProductApplicationKey    = @"PBXApplicationProductType";
static NSString * const ProductTestBundleKey     = @"PBXXCTestBundleProductType";
static NSString * const ProductBundleKey         = @"PBXBundleProductType";
static NSString * const ProductFrameworkKey      = @"PBXFrameworkProductType";
static NSString * const ProductStaticLibraryKey  = @"PBXStaticLibraryProductType";
static NSString * const ProductDynamicLibraryKey = @"PBXDynamicLibraryProductType";

@implementation Xcode3TargetMembershipDataSource (HookAllTargets)

+ (void)hookAllTargets
{
    [self jr_swizzleMethod:@selector(updateTargets)
                withMethod:@selector(allTargets_updateTargets)
                     error:NULL];
}

- (void)allTargets_updateTargets
{
    // We first call the original method
    [self allTargets_updateTargets];
    
    // Run our custom code
    NSMutableArray *wrappedTargets = [self valueForKey:WrappedTargetsKey];
    ATSavedData *savedData = [[AllTargets sharedPlugin] savedData];
    
    for (Xcode3TargetWrapper *targetWrapper in wrappedTargets) {
        // Select the targets depending of the ATSavedData configuration
        
        if (savedData.allTargetSelected) {
            targetWrapper.selected = YES;
        } else {
            id pbxTarget = targetWrapper.pbxTarget;
            id productType = [pbxTarget valueForKey:ProductTypeKey];
            NSString *className = NSStringFromClass([productType class]);
            
            if ([className isEqualToString:ProductApplicationKey]) {
                targetWrapper.selected = savedData.allAppsSelected;
            } else if ([self.extensionKeys containsObject:className]) {
                targetWrapper.selected = savedData.allExtensionsSelected;
            } else if ([className isEqualToString:ProductTestBundleKey]) {
                targetWrapper.selected = savedData.allTestsSelected;
            } else {
                targetWrapper.selected = NO;
            }
            
        }
    }
}

- (NSArray *)extensionKeys
{
    return @[
        ProductBundleKey,
        ProductFrameworkKey,
        ProductStaticLibraryKey,
        ProductDynamicLibraryKey,
    ];
}

@end
