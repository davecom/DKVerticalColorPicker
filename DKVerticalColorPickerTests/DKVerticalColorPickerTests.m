//
//  DKVerticalColorPickerTests.m
//  DKVerticalColorPickerTests
//
//  Created by David Kopec on 1/6/15.
//  Copyright (c) 2015 Oak Snow Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DKVerticalColorPicker.h"

@interface DKVerticalColorPickerTests : XCTestCase

@end

@implementation DKVerticalColorPickerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlack
{
    int theHeight = 100;
    int theY = 0;
    DKVerticalColorPicker *thePicker = [[DKVerticalColorPicker alloc] initWithFrame:CGRectMake(0, 0, 50, theHeight)];
    UIColor *theBlackColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:1];
    XCTAssertTrue([self isColor:theBlackColor
                   equalToColor:[thePicker getColor:theY]], @"should start with black");
}

- (void)testWhite
{
    int theHeight = 100;
    int theY = END_OF_GRAYSCALE_SECTION + 2.0f;
    DKVerticalColorPicker *thePicker = [[DKVerticalColorPicker alloc] initWithFrame:CGRectMake(0, 0, 50, theHeight)];
    UIColor *theWhiteColor = [UIColor colorWithHue:0 saturation:0 brightness:1 alpha:1];
    XCTAssertTrue([self isColor:theWhiteColor
                   equalToColor:[thePicker getColor:theY]], @"should start with white");
}

- (void)testColor
{
    int theHeight = 100;
    int theY = 100;
    DKVerticalColorPicker *thePicker = [[DKVerticalColorPicker alloc] initWithFrame:CGRectMake(0, 0, 50, theHeight)];
    UIColor *theColor = [UIColor colorWithHue:1 saturation: 0.8 brightness:1 alpha:1];
    XCTAssertTrue([self isColor:theColor
                   equalToColor:[thePicker getColor:theY]], @"should end with color");
}

- (void)testGetYFromColor
{
    DKVerticalColorPicker* thePicker = [self createTestColorPicker];

    UIColor *theBlackColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:1];
    XCTAssertEqual( 0, [ thePicker getYFromColor: theBlackColor], @"should start with black at zero");

    UIColor *theWhiteColor = [UIColor colorWithHue:0 saturation:0 brightness:1 alpha:1];
    XCTAssertEqual( END_OF_GRAYSCALE_SECTION, [ thePicker getYFromColor: theWhiteColor], @"should show white");

    UIColor *theColor = [UIColor colorWithHue:1 saturation: 0.8 brightness:1 alpha:1];
    XCTAssertEqual( 100, [ thePicker getYFromColor: theColor], @"should end with red");
}

- (DKVerticalColorPicker*)createTestColorPicker
{
    int theHeight = 100;
    return [[DKVerticalColorPicker alloc] initWithFrame:CGRectMake(0, 0, 50, theHeight)];
}


- (BOOL)isColor:(UIColor *)aColor equalToColor:(UIColor *)otherColor
{
    return CGColorEqualToColor(aColor.CGColor, otherColor.CGColor);
}

@end
