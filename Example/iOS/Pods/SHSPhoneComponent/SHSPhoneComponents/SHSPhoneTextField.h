//
//  SHSPhoneTextField.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLogic.h"
#import "SHSPhoneNumberFormatter.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

/**
 Simple UITextField subclass to handle phone numbers formats
 ARC enabled.
*/
@interface SHSPhoneTextField : UITextField
{
    SHSPhoneLogic *logicDelegate;
}

/**
 SHSPhoneNumberFormatter instance.
 Use is to configure format properties.
*/
@property (readonly, strong) SHSPhoneNumberFormatter *formatter;

/**
 Formate a text and set it to a textfield.
*/
-(void) setFormattedText:(NSString *)text;

/**
 Return phone number without format. Ex: 89201235678
*/
-(NSString *) phoneNumber;

/**
 Block will be called when text changed
 */
typedef void (^SHSTextBlock)(UITextField *textField);
@property (nonatomic, copy) SHSTextBlock textDidChangeBlock;
@end

