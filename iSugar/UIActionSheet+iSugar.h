//
//  UIActionSheet+iSugar.h
//  iSugar
//
//  Created by Stephane JAIS on 1/30/13.
//  Copyright (c) 2013 Cantina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (iSugar)
+ (id) actionSheetWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger index))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (id) initWithTitle:(NSString *)title onClick:(void(^)(UIActionSheet *actionSheet, NSInteger index))onClick cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
@end
