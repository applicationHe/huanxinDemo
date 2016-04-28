//
//  LoginViewController.m
//  huanxinTest
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "LoginViewController.h"
#import <EMSDK.h>
#import "HBarController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loginDidClicked:(id)sender {
    EMError * error = [[EMClient sharedClient] loginWithUsername:self.usernameTF.text password:self.passwordTF.text];
    if (error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:error.errorDescription message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else
    {
        HBarController * barVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HBar"];
        [self presentViewController:barVC animated:NO completion:nil];
    }
}

- (IBAction)registDidClicked:(id)sender {
    EMError * error = [[EMClient sharedClient] registerWithUsername:self.usernameTF.text password:self.passwordTF.text];
    NSString * str = nil;
    if (!error) {
        str = @"注册成功";
    }else
    {
        str = error.errorDescription;
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
@end
