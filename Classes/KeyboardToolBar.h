//
//  KeyboardToolBar.h
//  KeyboardToolBar
//
//  Created by Jiar on 15/10/14.
//  Copyright © 2015年 Jiar. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  KeyboardToolBar 已支持runtime。
 *  如果你想使用KeyboardToolBar，你只需要在项目中使用
 *  #import "KeyboardToolBar.h" 即可。
 *  https://github.com/Jiar/KeyboardToolBar/
 *  author:   Jiar
 */
@interface KeyboardToolBar : UIToolbar

/// 为UITextField注册使用KeyboardToolBar
+ (void)registerKeyboardToolBarWithTextField:(UITextField *)textField;
/// 为UITextView注册使用KeyboardToolBar
+ (void)registerKeyboardToolBarWithTextView:(UITextView *)textView;
/// 为UISearchBar注册使用KeyboardToolBar
+ (void)registerKeyboardToolBarWithSearchBar:(UISearchBar *)searchBar;

/// 为UITextField移除KeyboardToolBar
+ (void)unregisterKeyboardToolBarWithTextField:(UITextField *)textField;
/// 为UITextView移除KeyboardToolBar
+ (void)unregisterKeyboardToolBarWithTextView:(UITextView *)textView;
/// 为UISearchBar移除KeyboardToolBar
+ (void)unregisterKeyboardToolBarWithSearchBar:(UISearchBar *)searchBar;

@end

@interface UITextField (KeyboardToolBar)

@end

@interface UITextView (KeyboardToolBar)

@end

@interface UISearchBar (KeyboardToolBar)

@end