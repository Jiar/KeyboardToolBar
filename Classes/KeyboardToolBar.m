//
//  KeyboardToolBar.m
//  KeyboardToolBar
//
//  Created by Jiar on 15/10/14.
//  Copyright © 2015年 Jiar. All rights reserved.
//

#import "KeyboardToolBar.h"
#import <objc/runtime.h>

@implementation UITextField (KeyboardToolBar)

+ (void)load {
    [self swizzleSelector:@selector(init) withSelector:@selector(init_KeyboardToolBar)];
    [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_KeyboardToolBar)];
    [self swizzleSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_KeyboardToolBar:)];
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (id)init_KeyboardToolBar {
    self = [self init_KeyboardToolBar];
    [self addInputAccessoryView_UITextField];
    return self;
}

- (void)awakeFromNib_KeyboardToolBar {
    [self addInputAccessoryView_UITextField];
}

- (id)initWithFrame_KeyboardToolBar:(CGRect)frame {
    self = [self initWithFrame_KeyboardToolBar:frame];
    [self addInputAccessoryView_UITextField];
    return self;
}

- (void)addInputAccessoryView_UITextField {
    [KeyboardToolBar registerKeyboardToolBarWithTextField:self];
}

@end

@implementation UITextView (KeyboardToolBar)

+ (void)load {
    [self swizzleSelector:@selector(init) withSelector:@selector(init_KeyboardToolBar)];
    [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_KeyboardToolBar)];
    [self swizzleSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_KeyboardToolBar:)];
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (id)init_KeyboardToolBar {
    self = [self init_KeyboardToolBar];
    [self addInputAccessoryView_UITextView];
    return self;
}

- (void)awakeFromNib_KeyboardToolBar {
    [self addInputAccessoryView_UITextView];
}

- (id)initWithFrame_KeyboardToolBar:(CGRect)frame {
    self = [self initWithFrame_KeyboardToolBar:frame];
    [self addInputAccessoryView_UITextView];
    return self;
}

- (void)addInputAccessoryView_UITextView {
    [KeyboardToolBar registerKeyboardToolBarWithTextView:self];
}

@end

@implementation UISearchBar (KeyboardToolBar)

+ (void)load {
    [self swizzleSelector:@selector(init) withSelector:@selector(init_KeyboardToolBar)];
    [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_KeyboardToolBar)];
    [self swizzleSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_KeyboardToolBar:)];
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (id)init_KeyboardToolBar {
    self = [self init_KeyboardToolBar];
    [self addInputAccessoryView_UISearchBar];
    return self;
}

- (void)awakeFromNib_KeyboardToolBar {
    [self addInputAccessoryView_UISearchBar];
}

- (id)initWithFrame_KeyboardToolBar:(CGRect)frame {
    self = [self initWithFrame_KeyboardToolBar:frame];
    [self addInputAccessoryView_UISearchBar];
    return self;
}

- (void)addInputAccessoryView_UISearchBar {
    [KeyboardToolBar registerKeyboardToolBarWithSearchBar:self];
}

@end

#define KeyboardToolBarWidth      [UIScreen mainScreen].bounds.size.width
#define KeyboardToolBarHeight     44
#define KeyboardScrollViewWidth   (KeyboardToolBarWidth-80)

@interface KeyboardToolBar()<UITextViewDelegate, UISearchBarDelegate>

@property(nonatomic, strong)UITextField *toolBarTextField;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, retain)NSMutableDictionary *allRegisters;

@end

@implementation KeyboardToolBar

static KeyboardToolBar *keyboardToolBar = nil;

+ (void)registerKeyboardToolBarWithTextField:(UITextField *)textField {
    if([KeyboardToolBar shareKeyboardToolBar].allRegisters == nil) {
        keyboardToolBar.allRegisters = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    [textField setInputAccessoryView:keyboardToolBar];
    [textField addTarget:keyboardToolBar action:@selector(textFieldDidBeginWithTextField:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:keyboardToolBar action:@selector(textFieldDidChangeWithTextField:) forControlEvents:UIControlEventEditingChanged];
    [keyboardToolBar.allRegisters setValue:textField forKey:[NSString stringWithFormat:@"%p",textField]];
}

+ (void)registerKeyboardToolBarWithTextView:(UITextView *)textView {
    if([KeyboardToolBar shareKeyboardToolBar].allRegisters == nil) {
        keyboardToolBar.allRegisters = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    [textView setInputAccessoryView:keyboardToolBar];
    textView.delegate = keyboardToolBar;
    [keyboardToolBar.allRegisters setValue:textView forKey:[NSString stringWithFormat:@"%p",textView]];
}

+ (void)registerKeyboardToolBarWithSearchBar:(UISearchBar *)searchBar {
    if([KeyboardToolBar shareKeyboardToolBar].allRegisters == nil) {
        keyboardToolBar.allRegisters = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    [searchBar setInputAccessoryView:keyboardToolBar];
    searchBar.delegate = keyboardToolBar;
    [keyboardToolBar.allRegisters setValue:searchBar forKey:[NSString stringWithFormat:@"%p",searchBar]];
}

+ (void)unregisterKeyboardToolBarWithTextField:(UITextField *)textField {
    if(keyboardToolBar == nil || keyboardToolBar.allRegisters.count == 0) {
        return;
    }
    UITextField *tempTextField = [keyboardToolBar.allRegisters objectForKey:[NSString stringWithFormat:@"%p",textField]];
    [tempTextField setInputAccessoryView:nil];
    [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidBeginWithTextField:) forControlEvents:UIControlEventEditingDidBegin];
    [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidChangeWithTextField:) forControlEvents:UIControlEventEditingChanged];
    [keyboardToolBar.allRegisters removeObjectForKey:[NSString stringWithFormat:@"%p",textField]];
    if(keyboardToolBar.allRegisters.count == 0) {
        keyboardToolBar.allRegisters = nil;
        keyboardToolBar = nil;
    }
}

+ (void)unregisterKeyboardToolBarWithTextView:(UITextView *)textView {
    if(keyboardToolBar == nil || keyboardToolBar.allRegisters.count == 0) {
        return;
    }
    UITextView *tempTextView = [keyboardToolBar.allRegisters objectForKey:[NSString stringWithFormat:@"%p",textView]];
    [tempTextView setInputAccessoryView:nil];
    textView.delegate = nil;
    [keyboardToolBar.allRegisters removeObjectForKey:[NSString stringWithFormat:@"%p",textView]];
    if(keyboardToolBar.allRegisters.count == 0) {
        keyboardToolBar.allRegisters = nil;
        keyboardToolBar = nil;
    }
}

+ (void)unregisterKeyboardToolBarWithSearchBar:(UISearchBar *)searchBar {
    if(keyboardToolBar == nil || keyboardToolBar.allRegisters.count == 0) {
        return;
    }
    UISearchBar *tempSearchBar = [keyboardToolBar.allRegisters objectForKey:[NSString stringWithFormat:@"%p",searchBar]];
    [tempSearchBar setInputAccessoryView:nil];
    searchBar.delegate = nil;
    
    [keyboardToolBar.allRegisters removeObjectForKey:[NSString stringWithFormat:@"%p",searchBar]];
    if(keyboardToolBar.allRegisters.count == 0) {
        keyboardToolBar.allRegisters = nil;
        keyboardToolBar = nil;
    }
}

/*
+ (void)unregisterAllKeyboardToolBar {
    if(keyboardToolBar == nil || keyboardToolBar.allRegisters.count == 0) {
        return;
    }
    NSEnumerator *enumeratorValue = [keyboardToolBar.allRegisters objectEnumerator];
    for(id temp in enumeratorValue) {
        if([temp isMemberOfClass:[UITextField class]]) {
            UITextField *tempTextField = (UITextField *)temp;
            [tempTextField setInputAccessoryView:nil];
            [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidBeginWithTextField:) forControlEvents:UIControlEventEditingDidBegin];
            [tempTextField removeTarget:keyboardToolBar action:@selector(textFieldDidChangeWithTextField:) forControlEvents:UIControlEventEditingChanged];
        } else if([temp isMemberOfClass:[UITextView class]]) {
            UITextView *tempTextView = (UITextView *)temp;
            [tempTextView setInputAccessoryView:nil];
            tempTextView.delegate = nil;
            [keyboardToolBar.allRegisters removeObjectForKey:[NSString stringWithFormat:@"%p",tempTextView]];
        } else if([temp isMemberOfClass:[UISearchBar class]]) {
            UISearchBar *tempSearchBar = (UISearchBar *)temp;
            [tempSearchBar setInputAccessoryView:nil];
            tempSearchBar.delegate = nil;
            [keyboardToolBar.allRegisters removeObjectForKey:[NSString stringWithFormat:@"%p",tempSearchBar]];
        }
    }
    [keyboardToolBar.allRegisters removeAllObjects];
    keyboardToolBar.allRegisters = nil;
    keyboardToolBar = nil;
}
*/

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

// UITextField
- (void)textFieldDidBeginWithTextField:(UITextField *)textField {
    [self reSetTextField:textField];
}

- (void)textFieldDidChangeWithTextField:(UITextField *)textField {
    [self reSetTextField:textField];
}

// UITextView
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self reSetTextView:textView];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self reSetTextView:textView];
}


// UISearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self reSetSearchBar:searchBar];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self reSetSearchBar:searchBar];
}

- (void)reSetTextField:(UITextField *)textField {
    UITextField *tempTextField = [keyboardToolBar.allRegisters objectForKey:[NSString stringWithFormat:@"%p",textField]];
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

- (void)reSetTextView:(UITextView *)textView {
    UITextView *tempTextView = [keyboardToolBar.allRegisters objectForKey:[NSString stringWithFormat:@"%p",textView]];
    CGFloat textWidth = [KeyboardToolBar widthForString:tempTextView.text withFont:keyboardToolBar.toolBarTextField.font];
    if(textWidth > KeyboardScrollViewWidth) {
        keyboardToolBar.toolBarTextField.frame = CGRectMake(0,0,textWidth,KeyboardToolBarHeight);
        keyboardToolBar.scrollView.contentSize = CGSizeMake(textWidth, KeyboardToolBarHeight);
        [self.scrollView scrollRectToVisible:CGRectMake(textWidth-KeyboardScrollViewWidth,0,KeyboardScrollViewWidth,KeyboardToolBarHeight) animated:YES];
    } else {
        keyboardToolBar.toolBarTextField.frame = CGRectMake(0, 0, KeyboardScrollViewWidth, KeyboardToolBarHeight);
        keyboardToolBar.scrollView.contentSize = CGSizeMake(KeyboardScrollViewWidth, KeyboardToolBarHeight);
    }
    keyboardToolBar.toolBarTextField.text = tempTextView.text;
    keyboardToolBar.toolBarTextField.textColor = tempTextView.textColor;
    keyboardToolBar.toolBarTextField.attributedPlaceholder = nil;
}

- (void)reSetSearchBar:(UISearchBar *)searchBar {
    UISearchBar *tempSearchBar = [keyboardToolBar.allRegisters objectForKey:[NSString stringWithFormat:@"%p",searchBar]];
    CGFloat textWidth = [KeyboardToolBar widthForString:tempSearchBar.text withFont:keyboardToolBar.toolBarTextField.font];
    if(textWidth > KeyboardScrollViewWidth) {
        keyboardToolBar.toolBarTextField.frame = CGRectMake(0,0,textWidth,KeyboardToolBarHeight);
        keyboardToolBar.scrollView.contentSize = CGSizeMake(textWidth, KeyboardToolBarHeight);
        [self.scrollView scrollRectToVisible:CGRectMake(textWidth-KeyboardScrollViewWidth,0,KeyboardScrollViewWidth,KeyboardToolBarHeight) animated:YES];
    } else {
        keyboardToolBar.toolBarTextField.frame = CGRectMake(0, 0, KeyboardScrollViewWidth, KeyboardToolBarHeight);
        keyboardToolBar.scrollView.contentSize = CGSizeMake(KeyboardScrollViewWidth, KeyboardToolBarHeight);
    }
    keyboardToolBar.toolBarTextField.text = tempSearchBar.text;
    keyboardToolBar.toolBarTextField.attributedPlaceholder = nil;
    keyboardToolBar.toolBarTextField.placeholder = tempSearchBar.placeholder;
}

- (void)resignKeyboard {
    keyboardToolBar.toolBarTextField.text = @"";
    keyboardToolBar.toolBarTextField.placeholder = @"";
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (CGFloat)widthForString:(NSString *)str withFont:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.width;
}


@end
