//  DKVerticalColorPicker.h

/*
DKVerticalColorPicker
Copyright (c) 2015 David Kopec

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DKColorPickerTouchType) {
    DKColorPickerTouchTypeTouchesBegan,
    DKColorPickerTouchTypeTouchesMoved,
    DKColorPickerTouchTypeTouchesEnded
};

static const int END_OF_GRAYSCALE_SECTION = 30;

static const int END_OF_WHITE_SECTION = END_OF_GRAYSCALE_SECTION + 5;

static const double COLOR_SATURATION = 0.8;

/*!
 A delegate that gets notifications when the color picked changes.
 */
@protocol DKVerticalColorPickerDelegate <NSObject>
@optional
- (void)colorPicked:(UIColor *)aColor withTouchType:(DKColorPickerTouchType)aTouchType;
@end

IB_DESIGNABLE

@interface DKVerticalColorPicker : UIView

@property(nonatomic, weak) IBOutlet id <DKVerticalColorPickerDelegate> delegate;  //set after inited
@property(nonatomic) IBInspectable UIColor *selectedColor;  //setting this will update the UI & notify the delegate

- (UIColor *)getColor:(CGFloat)aY;
@end
