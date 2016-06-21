//
//  Xcode3TargetMembershipDataSource+HookAllTargets.m
//  AllTargets
//
//  Created by Jobs on 15/6/21.
//  Copyright (c) 2015年 Jobs. All rights reserved.
//

#import "Xcode3TargetMembershipDataSource+HookAllTargets.h"
#import "Xcode3TargetWrapper.h"

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
    NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
    
    for (Xcode3TargetWrapper *targetWrapper in wrappedTargets) {
        
        // Don't select the test targets
        id pbxTarget = targetWrapper.pbxTarget;
        id productType = [pbxTarget valueForKey:@"productType"];
        if ([productType isMemberOfClass:NSClassFromString(@"PBXXCTestBundleProductType")]) {
            continue;
        }
        
        targetWrapper.selected = YES;
    }
}

@end
