//
//  SHSPhoneLogicDelegate.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneLogic.h"
#import "SHSPhoneTextField.h"
#import "SHSFlagAccessoryView.h"

@implementation SHSPhoneLogic
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Logic Method

+(void) setImageLeftView:(UITextField *)textField image:(UIImage *)image
{
    if (![textField.leftView isKindOfClass:[SHSFlagAccessoryView class]])
    {
        textField.leftView = [[SHSFlagAccessoryView alloc] initWithTextField:textField];
    }
    textField.leftViewMode = UITextFieldViewModeAlways;
    ((SHSFlagAccessoryView *)textField.leftView).image = image;
}

+(void) updateLeftImageView:(UITextField *)textField imagePath:(NSString *)imagePath
{
    if (imagePath == (id)[NSNull null]) imagePath = nil;
    if (imagePath)
    {
        UIImage *givenImage = [UIImage imageNamed:imagePath];
        [self setImageLeftView:textField image:givenImage];
    }
    else
       textField.leftViewMode = UITextFieldViewModeNever; 
}

+(void) applyFormat:(SHSPhoneTextField *)textField forText:(NSString *)text
{
    if (!text) text = @"";
    NSDictionary *result = [textField.formatter valuesForString:text];
    textField.text = result[@"text"];
    
    if ( textField.formatter.canAffectLeftViewByFormatter )
        [self updateLeftImageView:textField imagePath:result[@"image"]];
}

+(BOOL)logicTextField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString;
    BOOL isDeleting = (string.length == 0);
    NSInteger caretPosition = [self pushCaretPosition:textField range:range];
    
    if (isDeleting)
        newString = [SHSPhoneNumberFormatter formattedRemove:textField.text AtIndex:range];
    else
        newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self applyFormat:textField forText:newString];
    [self popCaretPosition:textField range:range caretPosition:caretPosition];
    
    if (textField.textDidChangeBlock) textField.textDidChangeBlock(textField);
    return NO;
}

#pragma mark -
#pragma mark Caret Control

+(NSInteger) pushCaretPosition:(UITextField *)textField range:(NSRange)range
{
    NSString *subString = [textField.text substringFromIndex:range.location + range.length];
    return [SHSPhoneNumberFormatter valuableCharCountIn:subString];
}

+(void) popCaretPosition:(UITextField *)textField range:(NSRange)range caretPosition:(NSInteger)caretPosition
{
    if (range.length == 0) range.length = 1;
    
    NSString *text = textField.text;
    NSInteger lasts = caretPosition;
    NSInteger start = [text length];
    for (NSInteger index = [text length] - 1; index >= 0 && lasts > 0; index--) {
        unichar ch = [text characterAtIndex:index];
        if ([SHSPhoneNumberFormatter isValuableChar:ch]) lasts--;
        if (lasts <= 0)
        {
            start = index;
            break;
        }
    }

    [self selectTextForInput:textField atRange:NSMakeRange(start, 0)];
}

+ (void)selectTextForInput:(UITextField *)input atRange:(NSRange)range {
    UITextPosition *start = [input positionFromPosition:[input beginningOfDocument]
                                                 offset:range.location ];
    UITextPosition *end = [input positionFromPosition:start
                                               offset:range.length];
    [input setSelectedTextRange:[input textRangeFromPosition:start toPosition:end]];
}

#pragma mark -
#pragma mark UITextField Delegate

-(BOOL)textField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [SHSPhoneLogic logicTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    return NO;
}

- (BOOL)textFieldShouldClear:(SHSPhoneTextField *)textField
{
    if ( textField.formatter.canAffectLeftViewByFormatter) textField.leftViewMode = UITextFieldViewModeNever;
    
    if ([_delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [_delegate textFieldShouldClear:textField];

    if (textField.formatter.prefix.length > 0)
    {
        [textField setFormattedText:@""];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [_delegate textFieldShouldBeginEditing:textField];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [_delegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [_delegate textFieldShouldEndEditing:textField];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [_delegate textFieldDidEndEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [_delegate textFieldShouldReturn:textField];
    
    return YES;
}

@end