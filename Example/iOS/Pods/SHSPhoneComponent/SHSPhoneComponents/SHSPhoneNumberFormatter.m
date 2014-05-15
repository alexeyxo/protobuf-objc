//
//  SHSPhoneNumberFormatter.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneNumberFormatter.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"
#import "SHSPhoneLogic.h"
#import "SHSPhoneTextField.h"

@implementation SHSPhoneNumberFormatter

-(id) init
{
    self = [super init];
    if (self) {
        _canAffectLeftViewByFormatter = NO;
        [self resetFormats];
        self.prefix = @"";
    }
    return self;
}

#pragma mark -
#pragma mark Filtering Input String

+(NSString *) digitOnlyString:(NSString *)aString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [regex stringByReplacingMatchesInString:aString options:0 range:NSMakeRange(0, [aString length]) withTemplate:@""];
}

-(NSString *) digitOnlyString:(NSString *)aString
{
    return [SHSPhoneNumberFormatter digitOnlyString:aString];
}

-(NSString *) stringWithoutFormat:(NSString *)aString
{
    NSDictionary *dict = [self configForSequence:aString];
    
    NSArray *removeRanges = @[];
    NSString *format = dict[@"format"];
    for (NSInteger i = 0; i < MIN(format.length, [aString length]); i++)
    {
        unichar formatCh = [format characterAtIndex:i];
        if (formatCh != [aString characterAtIndex:i])
        {
            break;
        }
        
        if ([SHSPhoneNumberFormatter isValuableChar:formatCh])
        {
            removeRanges = [removeRanges arrayByAddingObject:[NSValue valueWithRange:NSMakeRange(i, 1)]];
        }
    }
    
    for (NSInteger i = removeRanges.count -1; i >= 0; i--) {
        NSValue *value = removeRanges[i];
        aString = [aString stringByReplacingCharactersInRange:[value rangeValue] withString:@""];
    }
    
    return [self digitOnlyString:aString];
}



#pragma mark -
#pragma mark Find Matched Dictionary

-(BOOL) matchString:(NSString *)aString withPattern:(NSString *)pattern
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
    return match ? YES : NO;
}

-(NSDictionary *) configForSequence:(NSString *)aString
{
    for (NSString *format in [config allKeys]) {
        if ([self matchString:aString withPattern:format])
        {
            return config[format];
        }
    }
    return config[@"default"];
}


#pragma mark -
#pragma mark Getting Formatted String And Image Path

-(BOOL) isRequireSubstitute:(unichar)ch
{
    return ( ch == '#') ? YES : NO;
}

-(NSString *) applyFormat:(NSString *)format forFormattedString:(NSString *)formattedDigits
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSInteger charIndex = 0;
    for (NSInteger i = 0; i < [format length] && charIndex < [formattedDigits length]; i++) {
        
        unichar ch = [format characterAtIndex:i];
        if ([self isRequireSubstitute:ch])
        {
            unichar sp = [formattedDigits characterAtIndex:charIndex++];
            [result appendString:[NSString stringWithCharacters:&sp length:1]];
        }
        else
        {
            [result appendString:[NSString stringWithCharacters:&ch length:1]];
        }
    }
    return [NSString stringWithFormat:@"%@%@", self.prefix, result];
}

-(NSDictionary *) valuesForString:(NSString *)aString
{
    NSString *nonPrefix = aString;
    if ([aString hasPrefix:self.prefix]) nonPrefix = [aString substringFromIndex:self.prefix.length];
    NSString *formattedDigits = [self stringWithoutFormat:nonPrefix];
    NSDictionary *configDict = [self configForSequence:formattedDigits];
    NSString *result = [self applyFormat: configDict[@"format"] forFormattedString:formattedDigits];
    
//    result = [self.prefix stringByAppendingString:result];
    return @{ @"image": configDict[@"image"], @"text": result };
}

#pragma mark -
#pragma mark Formatted Remove

+(NSInteger) valuableCharCountIn:(NSString *)string
{
    NSInteger count = 0;
    for (NSInteger i = 0; i< [string length]; i++) {
        unichar ch = [string characterAtIndex:i];
        if ([self isValuableChar:ch]) count++;
    }
    return count;
}

+(BOOL) isValuableChar:(unichar)ch
{
    return (ch >= '0' && ch <= '9') ? YES : NO;
}

+(NSString *) formattedRemove:(NSString *)string AtIndex:(NSRange)range
{
    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
    NSInteger removeCount = [self valuableCharCountIn:[newString substringWithRange:range]];
    if (range.length == 1) removeCount = 1;
    
    for (NSInteger wordCount = 0 ; wordCount < removeCount; wordCount++) {
        
        for (NSInteger i = range.location + range.length - wordCount -1; i >= 0; i--) {
            unichar ch = [newString characterAtIndex:i];
            if ( [self isValuableChar:ch] )
            {
                [newString deleteCharactersInRange:NSMakeRange(i, 1)];
                break;
            }
        }
    }
    
    return newString;
}

#pragma mark -
#pragma mark NSFormatter requirements

-(BOOL) getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    *obj = [self digitOnlyString:string];
    return YES;
}

-(NSString *) stringForObjectValue:(id)anObject
{
    if (![anObject isKindOfClass:[NSString class]]) return nil;
    return [self valuesForString:anObject][@"text"];
}

#pragma mark -

-(void) setPrefix:(NSString *)prefix
{
    _prefix = (prefix ? prefix : @"");
    [SHSPhoneLogic applyFormat:self.textField forText:[self.textField text]];
}

@end