//
//  HNavController.m
//  huanxinTest
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "HNavController.h"

@interface HNavController ()

@end

@implementation HNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
     NSDictionary * textattributes = nil;
     [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
     textattributes = @{
                        NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                        NSForegroundColorAttributeName:[UIColor whiteColor],
                        };
     self.navigationBar.titleTextAttributes = textattributes;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
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
