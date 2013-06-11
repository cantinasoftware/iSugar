//
//  iSugarTests.m
//  iSugarTests
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import "iSugarTests.h"
#import "UIAlertView+iSugar.h"
#import "UIActionSheet+iSugar.h"

@implementation iSugarTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAlert
{
    UIAlertView *alert = [UIAlertView alertWithTitle:@"title" message:@"message" cancelButtonTitle:@"cancel" onClick:^(UIAlertView *alert, NSInteger clickedButtonIndex) {} otherButtonTitles:@"firstother", @"secondother", nil];
    STAssertEqualObjects(@"cancel", [alert buttonTitleAtIndex:alert.cancelButtonIndex], @"Cancel button title is right");
    STAssertEqualObjects(@"firstother", [alert buttonTitleAtIndex:alert.firstOtherButtonIndex], @"Other button title is right");
    STAssertEqualObjects(@"secondother", [alert buttonTitleAtIndex:2], @"Second other button title is right");
}

- (void)testActionSheet
{
    UIActionSheet *actionSheet = [UIActionSheet actionSheetWithTitle:@"title" onClick:^(UIActionSheet *actionSheet, NSInteger index) {} cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destruct" otherButtonTitles:@"firstother", @"secondother", nil];

    UIActionSheet *actionSheet1 = [[UIActionSheet alloc] initWithTitle:@"title" delegate:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destruct" otherButtonTitles:@"firstother", @"secondother", nil];

    for (int i = 0; i < actionSheet.numberOfButtons; i++)
        NSLog(@"%@", [actionSheet buttonTitleAtIndex:i]);
    NSLog(@"first:%i cancel:%i destruct:%i total:%i", actionSheet.firstOtherButtonIndex, actionSheet.cancelButtonIndex,actionSheet.destructiveButtonIndex, actionSheet.numberOfButtons);
    for (int i = 0; i < actionSheet1.numberOfButtons; i++)
        NSLog(@"%@", [actionSheet1 buttonTitleAtIndex:i]);
    NSLog(@"first:%i cancel:%i destruct:%i total:%i", actionSheet1.firstOtherButtonIndex, actionSheet1.cancelButtonIndex,actionSheet1.destructiveButtonIndex, actionSheet.numberOfButtons);
    STAssertEquals(actionSheet.firstOtherButtonIndex, actionSheet1.firstOtherButtonIndex, @"First button");
    STAssertEquals(actionSheet.cancelButtonIndex, actionSheet1.cancelButtonIndex, @"Cancel button");
    STAssertEquals(actionSheet.destructiveButtonIndex, actionSheet1.destructiveButtonIndex, @"Destruct button");
}


@end
