//
//  SHSPhoneNumberFormatter.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHSPhoneTextField;
/**
 Formatter class that converts input string to phone format.
*/
@interface SHSPhoneNumberFormatter : NSFormatter
{
    NSMutableDictionary *config;
}

/**
 Converts input string to dictionary.
 Return value format {text: "FORMATTED_PHONE_NUMBER", image: "PATH_TO_IMAGE"}
 Image path can be nil
*/
-(NSDictionary *) valuesForString:(NSString *)aString;

/**
 Remove required number of digits in phone text.
*/
+(NSString *) formattedRemove:(NSString *)string AtIndex:(NSRange)range;

/**
 Check if a chas is valuable symbol(part of number).
 Valuable chars are all digits.
*/
+(BOOL) isValuableChar:(unichar)ch;

/**
 Returns a count of valuable symbols in string.
*/
+(NSInteger) valuableCharCountIn:(NSString *)string;

/**
 If you want to use leftView or leftViewMode property set this property to NO.
 Default is NO.
*/
@property (readwrite) BOOL canAffectLeftViewByFormatter;

/**
 Prefix for all formats.
*/
@property (copy, nonatomic) NSString *prefix;
@property (weak) SHSPhoneTextField *textField;

/**
 Returns all digits from string.
*/
+(NSString *) digitOnlyString:(NSString *)aString;
-(NSString *) digitOnlyString:(NSString *)aString;

@end