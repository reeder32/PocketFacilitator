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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    [tap addTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    //apply button styles
    self.loginButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.loginButton.layer.cornerRadius = 4.0;
    self.loginButton.layer.borderWidth = 1.0;
    self.loginButton.layer.shadowColor = [UIColor synergoLightGrayColor].CGColor;
    self.loginButton.layer.shadowOpacity = 0.8;
    self.loginButton.layer.shadowRadius = 12;
    self.loginButton.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);

    [self.view endEditing:true];
    // Do any additional setup after loading the view.
}
-(void)dismissKeyboard{
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    
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
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UserLoggedIn" object:nil];
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:true completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}
- (IBAction)hanldeCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.usernameTextField) {
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return true;
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
