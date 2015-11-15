//
//  KeyboardToolBar.m
//  cdd
//
//  Created by Jiar on 15/10/14.
//  Copyright © 2015年 unisoft. All rights reserved.
//

#import "KeyboardToolBar.h"

#define KeyboardToolBarWidth      [UIScreen mainScreen].bounds.size.width
#define KeyboardToolBarHeight     44
#define KeyboardScrollViewWidth   (KeyboardToolBarWidth-80)

@interface KeyboardToolBar()

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UITextField *toolBarTextField;
@property(nonatomic, retain)NSMutableDictionary *allRegisterTextFields;

@end

@implementation KeyboardToolBar

static KeyboardToolBar *keyboardToolBar = nil;

+ (void)registerKeyboardToolBar:(UITextField *)textField {
    if([KeyboardToolBar shareKeyboardToolBar].allRegisterTextFields == nil) {
        keyboardToolBar.allRegisterTextFields = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    [textField setInputAccessoryView:keyboardToolBar];
    [textField addTarget:keyboardToolBar action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:keyboardToolBar action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [keyboardToolBar.allRegisterTextFields setValue:textField forKey:[NSString stringWithFormat:@"%p",textField]];
}

+ (void)unregisterKeyboardToolBar:(UITextField *)textField {
    if(keyboardToolBar == nil || keyboardToolBar.allRegisterTextFields.count == 0) {
        return;
    }
    UITextField *tempTextField = [keyboardToolBar.allRegisterTextFields objectForKey:[NSString stringWithFormat:@"%p",textField]];
    [tempTextField setInputAccessoryView:nil];
    [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [keyboardToolBar.allRegisterTextFields removeObjectForKey:[NSString stringWithFormat:@"%p",textField]];
    if(keyboardToolBar.allRegisterTextFields.count == 0) {
        keyboardToolBar.allRegisterTextFields = nil;
        keyboardToolBar = nil;
    }
}

+ (void)unregisterAllKeyboardToolBar {
    if(keyboardToolBar == nil || keyboardToolBar.allRegisterTextFields.count == 0) {
        return;
    }
    NSEnumerator *enumeratorValue = [keyboardToolBar.allRegisterTextFields objectEnumerator];
    for(UITextField *tempTextField in enumeratorValue) {
        [tempTextField setInputAccessoryView:nil];
        [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    [keyboardToolBar.allRegisterTextFields removeAllObjects];
    keyboardToolBar.allRegisterTextFields = nil;
    keyboardToolBar = nil;
}

+ (instancetype)shareKeyboardToolBar {
    if (keyboardToolBar == nil) {
        keyboardToolBar = [[KeyboardToolBar alloc]initWithFrame:CGRectMake(0, 0, KeyboardToolBarWidth, KeyboardToolBarHeight)];
        [keyboardToolBar setBarStyle:UIBarStyleDefault];
        keyboardToolBar.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KeyboardScrollViewWidth, KeyboardToolBarHeight)];
        keyboardToolBar.scrollView.backgroundColor = [UIColor clearColor];
        keyboardToolBar.scrollView.contentSize = CGSizeMake(KeyboardScrollViewWidth, KeyboardToolBarHeight);
        keyboardToolBar.scrollView.bounces = NO;
        
        keyboardToolBar.toolBarTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, KeyboardScrollViewWidth, KeyboardToolBarHeight)];
        keyboardToolBar.toolBarTextField.textAlignment = NSTextAlignmentLeft;
        keyboardToolBar.toolBarTextField.userInteractionEnabled = NO;
        
        [keyboardToolBar.scrollView addSubview:keyboardToolBar.toolBarTextField];
        UIBarButtonItem *textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:keyboardToolBar.scrollView];
        UIBarButtonItem *finishBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:keyboardToolBar action:@selector(resignKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:textFieldItem,finishBtnItem,nil];
        [keyboardToolBar setItems:buttonsArray];

    }
    return keyboardToolBar;
}

- (void)textFieldDidBegin:(UITextField *)textField {
    [self reSetTextField:textField];
}

- (void)textFieldDidChange:(UITextField *)textField {
    [self reSetTextField:textField];
}

- (void)reSetTextField:(UITextField *)textField {
    UITextField *tempTextField = [keyboardToolBar.allRegisterTextFields objectForKey:[NSString stringWithFormat:@"%p",textField]];
    CGFloat textWidth = [KeyboardToolBar widthForString:tempTextField.text withFont:keyboardToolBar.toolBarTextField.font];
    if(textWidth > KeyboardScrollViewWidth) {
        keyboardToolBar.toolBarTextField.frame = CGRectMake(0,0,textWidth,KeyboardToolBarHeight);
        keyboardToolBar.scrollView.contentSize = CGSizeMake(textWidth, KeyboardToolBarHeight);
        [self.scrollView scrollRectToVisible:CGRectMake(textWidth-KeyboardScrollViewWidth,0,KeyboardScrollViewWidth,KeyboardToolBarHeight) animated:YES];
    } else {
        keyboardToolBar.toolBarTextField.frame = CGRectMake(0, 0, KeyboardScrollViewWidth, KeyboardToolBarHeight);
        keyboardToolBar.scrollView.contentSize = CGSizeMake(KeyboardScrollViewWidth, KeyboardToolBarHeight);
    }
    keyboardToolBar.toolBarTextField.text = tempTextField.text;
    keyboardToolBar.toolBarTextField.textColor = tempTextField.textColor;
    if(tempTextField.placeholder != nil) {
        NSAttributedString *attribute = textField.attributedPlaceholder;
        NSDictionary *dictionary = [attribute attributesAtIndex:0 effectiveRange:nil];
        keyboardToolBar.toolBarTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:tempTextField.placeholder attributes:@{NSForegroundColorAttributeName: [dictionary valueForKey:NSForegroundColorAttributeName]}];
    }
}

- (void)resignKeyboard {
    keyboardToolBar.toolBarTextField.text = @"";
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (CGFloat)widthForString:(NSString *)str withFont:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.width;
}


@end
