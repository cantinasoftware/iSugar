//
//  UIAlertViewExampleController.m
//  iSugar
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import "UIAlertViewExampleController.h"
#import "UIAlertView+iSugar.h"

@interface UIAlertViewExampleController ()

@end

@implementation UIAlertViewExampleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.label.text = @"";
    [[UIAlertView alertViewWithTitle:@"Sample Alert" message:@"Sample Message" cancelButtonTitle:@"Cancel" onClick:^(UIAlertView *alertView, NSInteger index) {
        self.label.text = [NSString stringWithFormat:@"Clicked button at index %i with label %@", index, [alertView buttonTitleAtIndex:index]];
    } otherButtonTitles:@"Sample Choice 1", @"Sample Choice 2", nil] show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
