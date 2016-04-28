//
//  AppDelegate.m
//  huanxinTest
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import <EMSDK.h>

@interface AppDelegate ()<EMContactManagerDelegate,UIAlertViewDelegate>
{
    NSString * _username;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    LoginViewController * loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    _window.rootViewController = loginVC;
    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    EMOptions * options = [EMOptions optionsWithAppkey:@"hwm403#hwmtest"];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EMClient sharedClient].contactManager removeDelegate:self];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - EMContactManagerDelegate
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    _username = aUsername;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@想要添加你为好友(备注:%@)",aUsername,aMessage] delegate:self cancelButtonTitle:@"同意" otherButtonTitles:@"拒绝", nil];
    alert.tag = 1;
    [alert show];
}
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@同意添加你为好友",aUsername] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@拒绝添加你为好友",aUsername] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:_username];
            if (!error) {
                NSLog(@"发送同意成功");
            }
        }else
        {
            EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:_username];
            if (!error) {
                NSLog(@"发送拒绝成功");
            }
        }
    }
}
@end
