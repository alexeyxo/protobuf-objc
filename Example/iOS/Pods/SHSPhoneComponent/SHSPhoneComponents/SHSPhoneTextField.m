//
//  SHSPhoneTextField.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneTextField.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSPhoneTextField

-(void) logicInitialization
{
    _formatter = [[SHSPhoneNumberFormatter alloc] init];
    _formatter.textField = self;
    
    logicDelegate = [[SHSPhoneLogic alloc] init];
    
    [super setDelegate:logicDelegate];
    self.keyboardType = UIKeyboardTypeNumberPad;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

#pragma mark -
#pragma mark Delegates

-(void) setDelegate:(id<UITextFieldDelegate>)delegate
{
    logicDelegate.delegate = delegate;
}

-(id<UITextFieldDelegate>) delegate
{
    return logicDelegate.delegate;
}

#pragma mark -
#pragma mark Additional Text Setter

-(void) setFormattedText:(NSString *)text
{
    [SHSPhoneLogic applyFormat:self forText:text];
}

-(NSString *) phoneNumber
{
    return [self.formatter digitOnlyString:self.text];
}

@end


