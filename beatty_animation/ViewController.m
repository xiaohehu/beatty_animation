//
//  ViewController.m
//  beatty_animation
//
//  Created by Xiaohe Hu on 7/16/15.
//  Copyright (c) 2015 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"
#import "IPadFactsView.h"
#import "animationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)viewDidAppear:(BOOL)animated {
//    IPadFactsView *animation = [[IPadFactsView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview: animation];
//    [animation performSelector:@selector(loadInAnimation) withObject:nil afterDelay:1.0];
    
    animationView *animation = [[animationView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: animation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
