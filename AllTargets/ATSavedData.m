//
//  ATSavedData.m
//  AllTargets
//
//  Created by Francisco Trujillo on 23/08/2016.
//  Copyright © 2016 Jobs. All rights reserved.
//

#import "ATSavedData.h"

static NSString * const ATSavedDataAllTargetsKey = @"allTargets";
static NSString * const ATSavedDataAllAppsKey = @"allApps";
static NSString * const ATSavedDataAllExtensionsKey = @"allExtensions";
static NSString * const ATSavedDataAllTestsKey = @"allTests";

@interface ATSavedData ()

@property (nonatomic, strong) NSDictionary *encodedDictionary;

@end

@implementation ATSavedData

- (BOOL)allAppsSelected
{
    return self.allTargetSelected || _allAppsSelected;
}

- (BOOL)allExtensionsSelected
{
    return self.allTargetSelected || _allExtensionsSelected;
}

- (BOOL)allTestsSelected
{
    return self.allTargetSelected || _allTestsSelected;
}

#pragma mark - NSCoding
//This NSCoding method are necessary because we are saving this objects in the NSUsersDefaults

- (instancetype)initWithPayload:(NSDictionary *)payload
{
    self = [super init];

    if (self) {
        _allTargetSelected = [payload[ATSavedDataAllTargetsKey] boolValue];
        _allAppsSelected = [payload[ATSavedDataAllAppsKey] boolValue];
        _allExtensionsSelected = [payload[ATSavedDataAllExtensionsKey] boolValue];
        _allTestsSelected = [payload[ATSavedDataAllTestsKey] boolValue];
    }

    return self;
}

- (NSDictionary *)encodedDictionary
{
    return @{
               ATSavedDataAllTargetsKey : @(self.allTargetSelected),
               ATSavedDataAllAppsKey : @(_allAppsSelected),
               ATSavedDataAllExtensionsKey : @(_allExtensionsSelected),
               ATSavedDataAllTestsKey : @(_allTestsSelected),
    };
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSDictionary *backup = [aDecoder decodeObjectForKey:NSStringFromClass([self class])];

    self = [self initWithPayload:backup];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.encodedDictionary forKey:NSStringFromClass([self class])];
}

@end
