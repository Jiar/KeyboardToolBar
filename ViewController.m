//
//  ViewController.m
//  KeyboardToolBar
//
//  Created by Jiar on 15/11/13.
//  Copyright © 2015年 Jiar. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardToolBar.h"

@interface ViewController ()


@property(nonatomic, weak) IBOutlet UITextField *first;
@property(nonatomic, weak) IBOutlet UITextField *second;
@property(nonatomic, weak) IBOutlet UITextField *third;
@property(nonatomic, weak) IBOutlet UITextField *fourth;
@property(nonatomic, weak) IBOutlet UITextField *fifth;
@property(nonatomic, weak) IBOutlet UITextField *sixth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.first.textColor = [UIColor greenColor];
    self.first.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.first.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    
    [KeyboardToolBar registerKeyboardToolBar:self.first];
    [KeyboardToolBar registerKeyboardToolBar:self.second];
    [KeyboardToolBar registerKeyboardToolBar:self.third];
    [KeyboardToolBar registerKeyboardToolBar:self.fourth];
    [KeyboardToolBar registerKeyboardToolBar:self.fifth];
    [KeyboardToolBar registerKeyboardToolBar:self.sixth];
}

- (IBAction)unregisterAll:(id)sender {
    [KeyboardToolBar unregisterAllKeyboardToolBar];
    [self thenToDo];
}

- (IBAction)register1:(id)sender {
    [KeyboardToolBar registerKeyboardToolBar:self.first];
    [self thenToDo];
}

- (IBAction)unregister1:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBar:self.first];
    [self thenToDo];
}

- (IBAction)register2:(id)sender {
    [KeyboardToolBar registerKeyboardToolBar:self.second];
    [self thenToDo];
}

- (IBAction)unregister2:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBar:self.second];
    [self thenToDo];
}

- (IBAction)register3:(id)sender {
    [KeyboardToolBar registerKeyboardToolBar:self.third];
    [self thenToDo];
}

- (IBAction)unregister3:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBar:self.third];
    [self thenToDo];
}

- (IBAction)register4:(id)sender {
    [KeyboardToolBar registerKeyboardToolBar:self.fourth];
    [self thenToDo];
}

- (IBAction)unregister4:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBar:self.fourth];
    [self thenToDo];
}

- (IBAction)register5:(id)sender {
    [KeyboardToolBar registerKeyboardToolBar:self.fifth];
    [self thenToDo];
}

- (IBAction)unregister5:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBar:self.fifth];
    [self thenToDo];
}

- (IBAction)register6:(id)sender {
    [KeyboardToolBar registerKeyboardToolBar:self.sixth];
    [self thenToDo];
}

- (IBAction)unregister6:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBar:self.sixth];
    [self thenToDo];
}

- (void)thenToDo {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)toMyGithub:(id)sender {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/Jiar/KeyboardToolBar/"]]];
    UIViewController *viewCro = [[UIViewController alloc] init];
    [viewCro.view addSubview:webView];
    [self presentViewController:viewCro animated:YES completion:nil];
}

@end
