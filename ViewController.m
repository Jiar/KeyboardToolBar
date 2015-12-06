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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.first.textColor = [UIColor greenColor];
    self.first.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.first.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
}

- (IBAction)registerFirst:(id)sender {
    [KeyboardToolBar registerKeyboardToolBarWithTextField:self.first];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)unregisterFirst:(id)sender {
    [KeyboardToolBar unregisterKeyboardToolBarWithTextField:self.first];
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
