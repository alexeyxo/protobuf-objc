//
//  SHSPhoneNumberFormatter+UserConfig.h
//  PhoneComponentExample
//
//  Created by Willy on 24.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSPhoneNumberFormatter.h"

@interface SHSPhoneNumberFormatter (UserConfig)

/**
 Remove all patterns and apply clear format style.
 Default format is @"#############", imagePath is nil.
*/
-(void) resetFormats;

/**
 Apply default format style and image.
 Symbol '#' assumes all digits.
 Example is "+# (###) ###-##-##", imagePath is "flag_ru".
*/
-(void) setDefaultOutputPattern:(NSString *)pattern imagePath:(NSString *)imagePath;

/**
 Apply default format style.
 Symbol '#' assumes all digits.
 Example is "+# (###) ###-##-##"
*/
-(void) setDefaultOutputPattern:(NSString *)pattern;

/**
 All number matched your regexp will formatted with your style and image
 Symbol '#' assumes all digits.
 Example: pattern is "+# (###) ###-##-##", imagePath is "flag_ru", regexp is "^375\\d*$"
*/
-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp imagePath:(NSString *)imagePath;

/**
 All number matched your regexp will formatted with your style.
 Symbol '#' assumes all digits.
 Example: pattern is "+# (###) ###-##-##", regexp is "^375\\d*$"
*/
-(void) addOutputPattern:(NSString *)pattern forRegExp:(NSString *)regexp;

@end
