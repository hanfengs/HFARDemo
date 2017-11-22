//
//  SettingViewController.m
//  HFARKit
//
//  Created by hanfeng on 2017/11/22.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation SettingViewController

- (instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//没有这个方法，那么控制器只是普通的Present
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark-
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
