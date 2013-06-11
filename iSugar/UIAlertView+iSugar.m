//
//  UIAlertView+iSugar.m
//  iSugar
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import "UIAlertView+iSugar.h"

@interface _UIAlertViewDelegate : NSObject<UIAlertViewDelegate>
@property (nonatomic, strong) void(^onClick)(NSInteger clickedButtonIndex);
@end

@implementation _UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.onClick)
        self.onClick(buttonIndex);
}

@end

@implementation UIAlertView (iSugar)
+ (id) alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void (^)(UIAlertView *, NSInteger))onClick otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    NSArray *otherButtons = @[];
    va_list args;
    va_start(args, otherButtonTitles);
    
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        otherButtons = [otherButtons arrayByAddingObject:arg];
    }
    va_end(args);
    return [self alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle onClick:onClick otherButtonTitlesArray:otherButtons];
}

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    NSArray *otherButtons = @[];
    va_list args;
    va_start(args, otherButtonTitles);
    
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        otherButtons = [otherButtons arrayByAddingObject:arg];
    }
    va_end(args);
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle onClick:onClick otherButtonTitlesArray:otherButtons];
}

+ (id) alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitlesArray:(NSArray *)otherButtonTitles
{
    return [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle onClick:onClick otherButtonTitlesArray:otherButtonTitles];
}

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitlesArray:(NSArray *)otherButtonTitles
{
    
    _UIAlertViewDelegate *delegate = [[_UIAlertViewDelegate alloc] init];
    NSString *firstOtherButton = otherButtonTitles.count ? [otherButtonTitles objectAtIndex:0] : nil;
    
    if (firstOtherButton)
        self = [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:firstOtherButton ,nil];
    else
        self = [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];

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
    }
    return self;
    
    
}

@end
