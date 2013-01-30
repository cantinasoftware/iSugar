iSugar
======

UIKit additions that aim at replacing delegates with blocks.

Example:

   UIActionSheet *sheet = [UIActionSheet actionSheetWithTitle:@"Sample Title" onClick:^(UIActionSheet *actionSheet, NSInteger index) {
       self.textView.text = [actionSheet buttonTitleAtIndex:index];
   } cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destruct" otherButtonTitles:@"Sample Choice 1", @"Sample Choice 2", nil];

