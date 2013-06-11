//
//  UIAlertView+iSugar.h
//  iSugar
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (iSugar)
+ (id) alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (id) alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitlesArray:(NSArray *)otherButtonTitles;

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle onClick:(void(^)(UIAlertView *alertView, NSInteger clickedButtonIndex))onClick otherButtonTitlesArray:(NSArray *)otherButtonTitles;
@end
