//
//  ViewController.m
//  DKVerticalColorPicker
//
//  Created by David Kopec on 1/6/15.
//  Copyright (c) 2015 Oak Snow Consulting. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet DKVerticalColorPicker *vertPicker;
@property(nonatomic, weak) IBOutlet UIView *sampleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.vertPicker.selectedColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)colorPicked:(UIColor *)aColor withTouchType:(NSString *)aTouchType
{
    self.sampleView.backgroundColor = aColor;
}

@end
