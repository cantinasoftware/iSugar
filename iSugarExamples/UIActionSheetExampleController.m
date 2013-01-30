//
//  UIActionSheetExampleController.m
//  iSugar
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import "UIActionSheetExampleController.h"
#import <iSugar/UIActionSheet+iSugar.h>

@interface UIActionSheetExampleController ()

@end

@implementation UIActionSheetExampleController

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
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    UIActionSheet *sheet = [UIActionSheet actionSheetWithTitle:@"Sample Title" onClick:^(UIActionSheet *actionSheet, NSInteger index) {
        self.textView.text = [actionSheet buttonTitleAtIndex:index];
    } cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destruct" otherButtonTitles:@"Sample Choice 1", @"Sample Choice 2", nil];

    
    [sheet showInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
