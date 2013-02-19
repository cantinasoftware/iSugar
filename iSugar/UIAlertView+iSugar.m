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

@interface _UIAlertView : UIAlertView
- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
@implementation _UIAlertView

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    _UIAlertViewDelegate *delegate = [[_UIAlertViewDelegate alloc] init];
    if (self = [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil]) {
        
        
        // We use a retain cycle to make sure delegate is not deallocated
        delegate.onClick = ^(NSInteger i) {
            onClick(self, i);
            
            // Break the retain cycle here, delegate gets deallocated
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
            delegate.onClick = nil;
#pragma clang diagnostic pop
        };
        
        
        va_list args;
        va_start(args, otherButtonTitles);
        
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self addButtonWithTitle:arg];
        }
        va_end(args);
    }
    return self;
    
    
}

- (NSInteger)firstOtherButtonIndex
{
    if (-1 != self.cancelButtonIndex && 1 < self.numberOfButtons) {
        return 1;
    }
    return [super firstOtherButtonIndex];
}
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
    id result = [[_UIAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle onClick:onClick otherButtonTitles:nil];
    va_list args;
    va_start(args, otherButtonTitles);
    
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        [result addButtonWithTitle:arg];
    }
    va_end(args);
    return result;
}


@end
