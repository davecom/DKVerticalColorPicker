//
//  ViewController.h
//  DKVerticalColorPicker
//
//  Created by David Kopec on 1/6/15.
//  Copyright (c) 2015 Oak Snow Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKVerticalColorPicker.h"

@interface ViewController : UIViewController <DKVerticalColorPickerDelegate>

- (void)colorPicked:(UIColor *)aColor withTouchType:(DKColorPickerTouchType)aTouchType;

@end

