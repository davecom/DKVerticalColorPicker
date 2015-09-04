//  DKVerticalColorPicker.m

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

#import "DKVerticalColorPicker.h"

@interface DKVerticalColorPicker ()

@property(nonatomic) CGFloat currentSelectionY;

@end

@implementation DKVerticalColorPicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.currentSelectionY = 0.0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// for when coming out of a nib
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.currentSelectionY = 0.0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];

    //draw wings
    [[UIColor blackColor] set];
    CGFloat tempYPlace = self.currentSelectionY;
    if (tempYPlace < 0.0)
    {
        tempYPlace = 0.0;
    } else if (tempYPlace >= self.frame.size.height)
    {
        tempYPlace = self.frame.size.height - 1.0;
    }
    CGRect temp = CGRectMake(0.0, tempYPlace, self.frame.size.width, 1.0);
    UIRectFill(temp);

    //draw central bar over it
    CGFloat cbxbegin = self.frame.size.width * 0.2;
    CGFloat cbwidth = self.frame.size.width * 0.6;
    for (int y = 0; y < self.frame.size.height; y++)
    {
        UIColor *theColor = [self getColor:y];
        [theColor set];
        CGRect theColorRect = CGRectMake(cbxbegin, y, cbwidth, 1.0);
        UIRectFill(theColorRect);
    }
}

- (UIColor *)getColor:(CGFloat)aY
{
    CGFloat theMinY = 0;
    CGFloat theMaxY = self.frame.size.height;

    if (aY < END_OF_GRAYSCALE_SECTION)
    {
        return [self getGrayscaleColor:aY
                              fromMinY:theMinY
                                toMaxY:END_OF_GRAYSCALE_SECTION];
    }
    else if (aY < END_OF_WHITE_SECTION)
    {
        return [self getWhiteColor];
    }
    else
    {
        return [self getRainbowHueColor:aY fromMinY:END_OF_WHITE_SECTION toMaxY:theMaxY];
    }
}

- (UIColor *)getWhiteColor
{
    return [UIColor colorWithHue:0 saturation:0 brightness:1 alpha:1.0];
}

- (UIColor *)getGrayscaleColor:(CGFloat)aY fromMinY:(CGFloat)aMinY toMaxY:(CGFloat)aMaxY
{
    CGFloat hue = 0;
    CGFloat s = 0;
    CGFloat b = mapInputToRange(aY, aMinY, aMaxY, 0, 1);
    UIColor *theColor = [UIColor colorWithHue:hue saturation:s brightness:b alpha:1.0];
    return theColor;
}

- (UIColor *)getRainbowHueColor:(CGFloat)aY fromMinY:(CGFloat)aMinY toMaxY:(CGFloat)aMaxY
{
    CGFloat hue = mapInputToRange(aY, aMinY, aMaxY, 0, 1);
    CGFloat s = COLOR_SATURATION;
    CGFloat b = 1;
    UIColor *theColor = [UIColor colorWithHue:hue saturation:s brightness:b alpha:1.0];
    return theColor;
}

CGFloat projectNormal(CGFloat n, CGFloat start, CGFloat end)
{
    return start + (n * (end - start));
}

CGFloat normalize(CGFloat value, CGFloat startValue, CGFloat endValue)
{
    return (value - startValue) / (endValue - startValue);
}

CGFloat mapInputToRange(CGFloat input, CGFloat startValue, CGFloat endValue, CGFloat outputStart, CGFloat outputEnd)
{
    return projectNormal(MAX(0, MIN(1, normalize(input, startValue, endValue))), outputStart, outputEnd);
}

/*!
 Changes the selected color, updates the UI, and notifies the delegate.
 */
- (void)setSelectedColor:(UIColor *)selectedColor
{
    if (selectedColor != _selectedColor)
    {
        CGFloat hue = 0.0, temp = 0.0;
        if ([selectedColor getHue:&hue saturation:&temp brightness:&temp alpha:&temp])
        {
            self.currentSelectionY = floorf(hue * self.frame.size.height);
            [self setNeedsDisplay];
        }
        _selectedColor = selectedColor;
        if ([self.delegate respondsToSelector:@selector(colorPicked:withTouchType:)])
        {
            [self.delegate colorPicked:_selectedColor withTouchType:nil];
        }
    }
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateColor:touches];
    [self notifyDelegate:DKColorPickerTouchTypeTouchesBegan];
    [self setNeedsDisplay];
}

- (void)updateColor:(const NSSet *)touches
{
    self.currentSelectionY = [((UITouch *) [touches anyObject]) locationInView:self].y;
    _selectedColor = [self getColor:self.currentSelectionY];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateColor:touches];
    [self notifyDelegate:DKColorPickerTouchTypeTouchesMoved];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateColor:touches];

    [self notifyDelegate:DKColorPickerTouchTypeTouchesEnded];
    [self setNeedsDisplay];
}

- (void)notifyDelegate:(DKColorPickerTouchType)aTouchType
{
    if ([self.delegate respondsToSelector:@selector(colorPicked:withTouchType:)])
    {
        [self.delegate colorPicked:self.selectedColor withTouchType:aTouchType];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}
@end
