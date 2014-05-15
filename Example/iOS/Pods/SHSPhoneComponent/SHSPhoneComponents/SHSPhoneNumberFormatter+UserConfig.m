//
//  SHSPhoneNumberFormatter+UserConfig.m
//  PhoneComponentExample
//
//  Created by Willy on 24.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSPhoneNumberFormatter (UserConfig)

#pragma mark Predefined Configs

-(NSDictionary *) resetConfig
{
    return @{ @"default": @{ @"format": @"#############", @"image": [NSNull null]} };
}

#pragma mark -
#pragma mark Format Setters

-(void) resetFormats
{
    config = [[NSMutableDictionary alloc]initWithDictionary:[self resetConfig]];
}

-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath
{
    if (imagePath)
        self.canAffectLeftViewByFormatter = YES;
    else
        imagePath = (id)[NSNull null];
    [config setObject:@{@"format": pattern, @"image": imagePath} forKey:@"default"];
}

-(void) setDefaultOutputPattern:(NSString *)pattern
{
    [config setObject:@{@"format": pattern, @"image": [NSNull null]} forKey:@"default"];
}

-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath
{
    if (imagePath)
        self.canAffectLeftViewByFormatter = YES;
    else
        imagePath = (id)[NSNull null];
    
    [config setObject:@{@"format": pattern, @"image": imagePath} forKey:regexp];
}

-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp
{
    [config setObject:@{@"format": pattern, @"image": [NSNull null]} forKey:regexp];
}

#pragma mark -

@end


