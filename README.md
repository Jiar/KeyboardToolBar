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
#### import
	/// do not forget import
	#import "KeyboardToolBar.h"
#### registerKeyboardToolBar
	/// register the UITextField to use the KeyboardToolBar.
	[KeyboardToolBar registerKeyboardToolBar:self.textField]; // self.textField is a UITextField
#### unregisterKeyboardToolBar
	/// you must unregister the UITextField when you never use the KeyboardToolBar again.
	[KeyboardToolBar unregisterKeyboardToolBar:self.textField];
#### unregisterAllKeyboardToolBar
	/// you can use unregisterAllKeyboardToolBar to unregister the all UITextFields you have registed.
	[KeyboardToolBar unregisterAllKeyboardToolBar];
### License
KeyboardToolBar is released under the MIT license.