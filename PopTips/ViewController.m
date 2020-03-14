//
//  ViewController.m
//  PopTips
//
//  Created by alpha on 2020/3/13.
//  Copyright © 2020 alpha. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"
#import "AAPopoverViewInWindow.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *popoverBtn;
@property (weak, nonatomic) IBOutlet UIButton *customPopoverBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickPopoverBtn:(id)sender {
    PopViewController *testVC = [[PopViewController alloc] init];
    testVC.preferredContentSize = CGSizeMake(150, 150);
    testVC.modalPresentationStyle = UIModalPresentationPopover;
    testVC.popoverPresentationController.delegate = self;
    testVC.popoverPresentationController.sourceView = self.popoverBtn;
    testVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    testVC.popoverPresentationController.backgroundColor = [UIColor redColor];
    testVC.popoverPresentationController.canOverlapSourceViewRect = NO;
    [self presentViewController:testVC animated:YES completion:nil];
}

- (IBAction)clickCustomPopoverBtn:(UIButton *)aBtn {
    AAPopoverViewInWindow *popTipsView = [AAPopoverViewInWindow new];
    popTipsView.sourceView = aBtn;
    popTipsView.arrowDirection = AAPopTipsViewArrowDirectionLeft;
    [popTipsView setContentViewSize:CGSizeMake(100, 100)];
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:popTipsView.contentView.bounds];
    [tipsLabel setText:@"TIPS"];
    [tipsLabel setTextAlignment:NSTextAlignmentCenter];
    [popTipsView.contentView addSubview:tipsLabel];
    [popTipsView showPopInNormalRect];
}


#pragma mark - <UIPopoverPresentationControllerDelegate>
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
