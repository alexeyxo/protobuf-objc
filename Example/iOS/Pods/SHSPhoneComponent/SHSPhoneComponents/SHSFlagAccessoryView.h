//
//  SHSFlagAccessoryView.h
//  PhoneComponentExample
//
//  Created by Willy on 14.07.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Accessory view that shows flag images.
*/
@interface SHSFlagAccessoryView : UIView
{
    UIImageView *imageView;
}

- (id)initWithTextField:(UITextField *)textField;
/**
 Set image for accessory view.
*/
-(void) setImage:(UIImage *) image;

@end
