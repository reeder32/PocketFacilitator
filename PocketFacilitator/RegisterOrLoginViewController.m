//
//  RegisterOrLoginViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/8/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "RegisterOrLoginViewController.h"
#import <Parse/Parse.h>
#import "UIColor+UIColor_SynergoColors.h"

@interface RegisterOrLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation RegisterOrLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createAccountButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.createAccountButton.layer.cornerRadius = 4.0;
    self.createAccountButton.layer.borderWidth = 1.0;
    
    self.loginButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.loginButton.layer.cornerRadius = 4.0;
    self.loginButton.layer.borderWidth = 1.0;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleCreateAccountButtonTapped:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:true completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okay];
            [self presentViewController:alert animated:true completion:^{
                self.usernameTextField.text = nil;
                self.emailTextField.text = nil;
            }];
        }
    }];
}

- (IBAction)handleCancelButtonPressed:(id)sender {
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
