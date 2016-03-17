//
//  RegisterOrLoginViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/8/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "RegisterOrLoginViewController.h"
#import "UIColor+UIColor_SynergoColors.h"
#import <AWSCore/AWSCore.h>
#import "AWSIdentityManager.h"

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    [tap addTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.createAccountButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.createAccountButton.layer.cornerRadius = 4.0;
    self.createAccountButton.layer.borderWidth = 1.0;
    self.createAccountButton.layer.shadowColor = [UIColor synergoLightGrayColor].CGColor;
    self.createAccountButton.backgroundColor = [UIColor synergoLightGrayColor];
    self.createAccountButton.layer.shadowOpacity = 0.8;
    self.createAccountButton.layer.shadowRadius = 12;
    self.createAccountButton.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    
    self.loginButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.loginButton.layer.cornerRadius = 4.0;
    self.loginButton.layer.borderWidth = 1.0;
    self.loginButton.layer.shadowColor = [UIColor synergoLightGrayColor].CGColor;
    self.loginButton.backgroundColor = [UIColor synergoLightGrayColor];
    self.loginButton.layer.shadowOpacity = 0.8;
    self.loginButton.layer.shadowRadius = 12;
    self.loginButton.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    
    
    
    // Do any additional setup after loading the view.
}
-(BOOL)shouldAutorotate
{
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleCreateAccountButtonTapped:(id)sender {
    BOOL fieldsAreValid = false;
//    PFUser *user = [PFUser user];
//    
//    user.username = self.usernameTextField.text;
//    user.password = self.passwordTextField.text;
//    user.email = self.emailTextField.text;
    NSArray *array = @[self.usernameTextField.text, self.passwordTextField.text, self.emailTextField.text];
    for (NSString *string in array) {
        if (string.length >=4) {
            fieldsAreValid = true;
        }else{
            fieldsAreValid = false;
        }
    }
    if (fieldsAreValid){
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            if (succeeded) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"UserLoggedIn" object:nil];
//                [self dismissViewControllerAnimated:true completion:nil];
//            }else{
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
//                [alert addAction:okay];
//                [self presentViewController:alert animated:true completion:^{
//                    self.usernameTextField.text = nil;
//                    self.emailTextField.text = nil;
//                }];
//            }
//        }];
    }
    
}

- (IBAction)handleCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.usernameTextField) {
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField){
        [textField resignFirstResponder];
        [self.emailTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return true;
}
-(void)dismissKeyboard{
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
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
