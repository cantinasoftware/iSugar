//
//  UIActionSheet+iSugar.h
//  Radiomarais
//
//  Created by Stephane JAIS on 6/11/13.
//  Copyright (c) 2013 RADIOMARAIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (iSugar)

- (id)initWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesArray:(NSArray *)otherButtonTitles;

+ (id)actionSheetWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (id)actionSheetWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger clickedButtonIndex))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesArray:(NSArray *)otherButtonTitles;

@end
