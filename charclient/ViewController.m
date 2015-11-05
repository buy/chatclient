//
//  ViewController.m
//  charclient
//
//  Created by Chang Liu on 11/5/15.
//  Copyright © 2015 Chang Liu. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "ChatViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
- (IBAction)signupAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupAction:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.usernameLabel.text;
    user.password = self.passwordLabel.text;
    user.email = self.emailLabel.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            NSLog(@"signup was successful");
        } else {
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
        }
    }];
}

- (IBAction)loginAction:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameLabel.text password:self.passwordLabel.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"login was successful");
                                            UIViewController *chatViewController = [[ChatViewController alloc] init];
                                            [self presentViewController:chatViewController animated:YES completion:^{
                                                [self createObject];
                                            }];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"%@", error);
                                        }
                                    }];
}

- (void)createObject {
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = @"yayayaya!";
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"YES");
        } else {
            // There was a problem, check error.description
            NSLog(@"ERROR!!!");
        }
    }];
}

@end
