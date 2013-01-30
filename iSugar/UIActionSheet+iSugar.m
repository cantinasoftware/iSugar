//
//  UIActionSheet+iSugar.m
//  iSugar
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import "UIActionSheet+iSugar.h"

@interface _UIActionSheetDelegate : NSObject<UIActionSheetDelegate>
@property (nonatomic, strong) void(^onClick)(NSInteger index);
@end

@implementation _UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.onClick)
        self.onClick(buttonIndex);
}
@end


@implementation UIActionSheet (iSugar)

+ (id) actionSheetWithTitle:(NSString *)title onClick:(void (^)(UIActionSheet *, NSInteger))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    _UIActionSheetDelegate *delegate = [[_UIActionSheetDelegate alloc] init];
    
    // Init passing the destruct title, not the cancel or other buttons, which will be added later
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    if (!actionSheet)
        return nil;
    
    // Create a retain cycle so the delegate doesn't get deallocated
    delegate.onClick = ^(NSInteger index) {
        onClick(actionSheet, index);
        
        // Break the retain cycle here, delegate gets deallocated
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        delegate.onClick = nil;
#pragma clang diagnostic pop
    };
    
    // Add other buttons
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        [actionSheet addButtonWithTitle:arg];
    }
    va_end(args);
    
    // Add Cancel button
    if (cancelButtonTitle) {
        [actionSheet addButtonWithTitle:cancelButtonTitle];
        [actionSheet setCancelButtonIndex:actionSheet.numberOfButtons - 1];
    }
    return actionSheet;
    
}

- (id) initWithTitle:(NSString *)title onClick:(void (^)(UIActionSheet *, NSInteger))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    _UIActionSheetDelegate *delegate = [[_UIActionSheetDelegate alloc] init];
    
    // Init passing the destruct title, not the cancel or other buttons, which will be added later
    if (self = [self initWithTitle:title delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil]) {
        
        // Create a retain cycle so the delegate doesn't get deallocated
        delegate.onClick = ^(NSInteger index) {
            onClick(self, index);
            
            // Break the retain cycle here, delegate gets deallocated
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
            delegate.onClick = nil;
#pragma clang diagnostic pop
        };
        
        // Add other buttons
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self addButtonWithTitle:arg];
        }
        va_end(args);
        
        // Add Cancel button
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            [self setCancelButtonIndex:self.numberOfButtons - 1];
        }
    }
    return self;
    
}
@end
