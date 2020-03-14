//
//  PopViewController.m
//  PopTips
//
//  Created by alpha on 2020/3/13.
//  Copyright © 2020 alpha. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *bbb  = [[UIButton alloc] initWithFrame:CGRectMake(13, 13, 100, 100)];
    [bbb setTitle:@"dismiss" forState:UIControlStateNormal];
    [bbb setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:bbb];
    [bbb addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn:(UIButton *)aBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"fuck touch");
}

@end
