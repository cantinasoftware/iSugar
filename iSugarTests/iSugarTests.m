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
    return;
    UIActionSheet *actionSheet = [UIActionSheet actionSheetWithTitle:@"title" onClick:^(UIActionSheet *actionSheet, NSInteger index) {} cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destruct" otherButtonTitles:@"firstother", @"secondother", nil];
    STAssertEqualObjects(@"cancel", [actionSheet buttonTitleAtIndex:actionSheet.cancelButtonIndex], @"Cancel button title is right");
    STAssertEqualObjects(@"destruct", [actionSheet buttonTitleAtIndex:actionSheet.destructiveButtonIndex], @"Destructive button title is right");
    STAssertEqualObjects(@"firstother", [actionSheet buttonTitleAtIndex:actionSheet.firstOtherButtonIndex], @"Other button title is right");
    STAssertEqualObjects(@"secondother", [actionSheet buttonTitleAtIndex:2], @"Second other button title is right");
}


@end
