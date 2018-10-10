//
//  ViewController.m
//  CodeInputViewDemo
//
//  Created by coolerting on 2018/10/10.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import "ViewController.h"
#import "CodeInputView.h"

@interface ViewController ()<CodeInputViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CodeInputView *view = [[CodeInputView alloc]initWithFrame:CGRectMake(0, 100, IPHONE_WIDTH, 60) Space:40 Margin:10 Count:6];
    view.inputType = inputTypeSecurity;
    view.delegate = self;
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
