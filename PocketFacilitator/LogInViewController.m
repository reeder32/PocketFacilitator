//
//  LogInViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/8/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import "UIColor+UIColor_SynergoColors.h"
#import "SVProgressHUD.h"
#import "RegisterOrLoginViewController.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.loginButton.layer.cornerRadius = 4.0;
    self.loginButton.layer.borderWidth = 1.0;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleLoginButtonPressed:(id)sender {
    [SVProgressHUD showWithStatus:@"Logging in"];
    
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser * user, NSError * error) {
        if (!error) {
            [SVProgressHUD dismiss];
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:true completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}
- (IBAction)hanldeCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
