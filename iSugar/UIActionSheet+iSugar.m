//
//  UIActionSheet+iSugar.m
//  Radiomarais
//
//  Created by Stephane JAIS on 6/11/13.
//  Copyright (c) 2013 RADIOMARAIS. All rights reserved.
//

#import "UIActionSheet+iSugar.h"

@interface _UIActionSheetDelegate : NSObject<UIActionSheetDelegate>
@property (nonatomic, strong) void(^onClick)(NSInteger clickedButtonIndex);
@end

@implementation _UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.onClick)
        self.onClick(buttonIndex);
}

@end

@implementation UIActionSheet (iSugar)

+ (id)actionSheetWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    NSArray *buttons = @[];
    va_list args;
    va_start(args, otherButtonTitles);
    
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        buttons = [buttons arrayByAddingObject:arg];
    }
    va_end(args);
    return [[UIActionSheet alloc] initWithTitle:title onClick:onClick cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitlesArray:buttons];
}

+ (id) actionSheetWithTitle:(NSString *)title onClick:(void (^)(UIActionSheet *, NSInteger))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesArray:(NSArray *)otherButtonTitles
{
    return [[self alloc] initWithTitle:title onClick:onClick cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitlesArray:otherButtonTitles];
}

- (id)initWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    NSArray *buttons = @[];
    va_list args;
    va_start(args, otherButtonTitles);
    
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        buttons = [buttons arrayByAddingObject:arg];
    }
    va_end(args);
    return [self initWithTitle:title onClick:onClick cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitlesArray:buttons];
}

- (id)initWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesArray:(NSArray *)otherButtonTitles
{
    _UIActionSheetDelegate *delegate = [[_UIActionSheetDelegate alloc] init];
    NSString *firstOtherButton = otherButtonTitles.count ? [otherButtonTitles objectAtIndex:0] : nil;
    
    if (firstOtherButton)
        self = [self initWithTitle:title delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:firstOtherButton,nil];
    else
        self = [self initWithTitle:title delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    if (self) {
        
        
        // We use a retain cycle to make sure delegate is not deallocated
        delegate.onClick = ^(NSInteger i) {
            onClick(self, i);
            
            // Break the retain cycle here, delegate gets deallocated
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
            delegate.onClick = nil;
#pragma clang diagnostic pop
        };
        
        
        otherButtonTitles = otherButtonTitles.count > 1 ? [otherButtonTitles subarrayWithRange:NSMakeRange(1, otherButtonTitles.count - 1)] : @[];
        for (NSString *button in otherButtonTitles) {
            [self addButtonWithTitle:button];
        }
        
        // Add Cancel button
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            [self setCancelButtonIndex:self.numberOfButtons - 1];
        }
    }
    return self;
}

@end
