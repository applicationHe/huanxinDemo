//
//  HFirendViewController.m
//  huanxinTest
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "HFirendViewController.h"
#import "Header.h"
#import <EMSDK.h>

@interface HFirendViewController ()<UITextFieldDelegate>
{
    UITextField * _nameTF;
    UIButton * _addBtn;
    UIView * _addView;
    UITableView * _tableView;
}
@end

@implementation HFirendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友";
    [self uiInit];
}

#pragma mark - UI初始化
-(void)uiInit
{
    UIButton * rightBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 7, 30, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"AddGroupMemberBtn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addFirend) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _addView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _addView.alpha = 0.0f;
    [self.view addSubview:_addView];
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 0, 70, 40)];
    _addBtn.backgroundColor = [UIColor redColor];
    [_addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [_addView addSubview:_addBtn];
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-70, 40)];
    _nameTF.placeholder = @"请输入好友的昵称";
    _nameTF.delegate = self;
    [_addView addSubview:_nameTF];
    [self.view bringSubviewToFront:_addView];
    
    
    
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Event
-(void)addFirend
{
    [UIView animateWithDuration:0.2f animations:^{
        _addView.alpha = 1.0f;
        [_nameTF becomeFirstResponder];
    }];
}
-(void)addBtnDidClicked
{
    [UIView animateWithDuration:0.2f animations:^{
        _addView.alpha = 0.0f;
        [_nameTF resignFirstResponder];
        dispatch_async(dispatch_get_main_queue(), ^{
            EMError *error = [[EMClient sharedClient].contactManager addContact:_nameTF.text message:@"我想加您为好友"];
            NSString * str = nil;
            if (!error) {
                str = @"添加成功";
            }else
            {
                str = error.errorDescription;
            }
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        });
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_addView.alpha == 1) {
        [UIView animateWithDuration:0.2f animations:^{
            _addView.alpha = 0.0f;
            [_nameTF resignFirstResponder];
            dispatch_async(dispatch_get_main_queue(), ^{
                EMError *error = [[EMClient sharedClient].contactManager addContact:_nameTF.text message:@"我想加您为好友"];
                NSString * str = nil;
                if (!error) {
                    str = @"添加成功";
                }else
                {
                    str = error.errorDescription;
                }
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            });
        }];
    }
}
@end
