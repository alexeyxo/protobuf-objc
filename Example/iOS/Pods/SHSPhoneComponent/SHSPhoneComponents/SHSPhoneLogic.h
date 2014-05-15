//
//  SHSPhoneLogicDelegate.h
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSPhoneNumberFormatter.h"
@class SHSPhoneTextField;

/**
 Incapsulate number formatting and caret positioning logics. Also used as inner delegate.
*/
@interface SHSPhoneLogic : NSObject <UITextFieldDelegate>

/**
  Incapsulate number formatting and caret positioning logics.
*/
+(BOOL)logicTextField:(SHSPhoneTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 Formate a text and set it to a textfield.
*/
+(void) applyFormat:(SHSPhoneTextField *)textField forText:(NSString *)text;

@property(nonatomic, weak) id<UITextFieldDelegate> delegate;
@end
