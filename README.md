# KeyboardToolBar
-------------------
### What's the KeyboardToolBar
No longer have to worry about keyboard cover input box, that is the KeyboardToolBar's keynote. It's easy to be used for iPhone and iPad.  
![KeyboardToolBar show](/images/KeyboardToolBar.gif)  
### How To Get Started

- Download KeyboardToolBar and try out the include iPhone example apps.

### Installation with CocoaPods
[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like KeyboardToolBar in your projects.
#### Podfile
	platform :ios, '7.0'
	pod "KeyboardToolBar"
### Usage
#####Now, KeyboardToolBar Has supported the runtime, you can just to import "KeyboardToolBar.h" to use it.
#### import
	/// import is use
	#import "KeyboardToolBar.h"
#### registerKeyboardToolBar
	/// register the UITextField to use the KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBarWithTextField:self.textField]; // self.textField is a UITextField
	/// register the UITextView to use the KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBarWithTextView:self.textView]; // self.textView is a UITextView
	/// register the UISearchBar to use the KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBarWithSearchBar:self.searchBar]; // self.searchBar is a UISearchBar
#### unregisterKeyboardToolBar
	/// you can unregister the UITextField when you never use the KeyboardToolBar again.
	[KeyboardToolBar unregisterKeyboardToolBarWithTextField:self.textField];
	/// you can unregister the UITextView when you never use the KeyboardToolBar again.
	[KeyboardToolBar unregisterKeyboardToolBarWithTextView:self.textView];
	/// you can unregister the UISearchBar when you never use the KeyboardToolBar again.
	[KeyboardToolBar unregisterKeyboardToolBarWithSearchBar:self.searchBar];

### KeyboardToolBar 是什么
#####KeyboardToolBar的主旨：从此不再担心键盘遮住输入框。目前是V2版本，如果想了解V1版本，请移步[V1版本](http://www.jianshu.com/p/48993ff982c1)。

### 如何开始使用

- 下载KeyboardToolBar并尝试在你的iPhone上运行DEMO。

###  使用CocoaPods安装

#### Podfile
	platform :ios, '7.0'
	pod "KeyboardToolBar"
### Usage
#####现在，KeyboardToolBar支持UITextField、UITextView和UISearchBar。并且支持运行时(runtime)，你只要在项目中导入"KeyboardToolBar.h"即可开始使用，无需额外代码。
#### import
	/// 导入就是使用
	/// 导入后，将自动为UITextField、UITextView和UISearchBar注册使用KeyboardToolBar
	#import "KeyboardToolBar.h"
#### 注册使用KeyboardToolBar
	/// 以下均为可选方法，你可以不使用。
	/// 为UITextField注册使用KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBarWithTextField:self.textField];
	/// 为UITextView注册使用KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBarWithTextView:self.textView];
	/// 为UISearchBar注册使用KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBarWithSearchBar:self.searchBar];
#### 反注册取消KeyboardToolBar
	/// 以下均为可选方法，你可以不使用。
	/// 你可以为目标UITextField反注册取消使用KeyboardToolBar
	[KeyboardToolBar unregisterKeyboardToolBarWithTextField:self.textField];
	/// 你可以为目标UITextView反注册取消使用KeyboardToolBar
	[KeyboardToolBar unregisterKeyboardToolBarWithTextView:self.textView];
	/// 你可以为目标UISearchBar反注册取消使用KeyboardToolBar
	[KeyboardToolBar unregisterKeyboardToolBarWithSearchBar:self.searchBar];
	
### License
KeyboardToolBar is released under the MIT license.