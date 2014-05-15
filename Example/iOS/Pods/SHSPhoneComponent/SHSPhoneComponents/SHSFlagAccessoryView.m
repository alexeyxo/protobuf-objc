//
//  SHSFlagAccessoryView.m
//  PhoneComponentExample
//
//  Created by Willy on 14.07.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSFlagAccessoryView.h"

#define ICON_SIZE 18.0
#define MIN_SHIFT 5.0
#define FONT_CORRECTION 1.0

@implementation SHSFlagAccessoryView

- (id)initWithTextField:(UITextField *)textField
{
    CGRect fieldRect = [textField textRectForBounds:textField.bounds];
  
    self = [super initWithFrame:CGRectMake(0, 0, [self viewWidth:fieldRect], textField.frame.size.height)];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake([self leftShift:fieldRect], fieldRect.origin.y + (fieldRect.size.height - ICON_SIZE)/2.0, ICON_SIZE, ICON_SIZE)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
    }
    return self;
}

-(float) leftShift:(CGRect)textFieldRect
{
    float x = CGRectGetMinX(textFieldRect);
    float result = x < MIN_SHIFT ? MIN_SHIFT : x;
    return result + FONT_CORRECTION;
}


-(float) viewWidth:(CGRect )textFieldRect
{
    float x = CGRectGetMinX(textFieldRect);
    if (x < MIN_SHIFT)
        return MIN_SHIFT + ICON_SIZE + MIN_SHIFT - x;
    else
        return x + ICON_SIZE;
}

-(void) setImage:(UIImage *) image
{
    imageView.image = image;
}

@end
