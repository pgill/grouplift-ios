//
//  ViewController.m
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/14/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)init {
    self = [super init];
    
    if (self) {
     //
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    if ([PFUser currentUser] &&
         [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        PFQuery *query = [PFQuery queryWithClassName:@"Group"];
        [query whereKey:@"members" containedIn:@[[PFUser currentUser]]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *groups, NSError *error) {
            NSLog(@"error: %@", error);
            NSLog(@"%@", groups);
        }];
    } else {
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"public_profile", @"user_friends", @"email", nil]];
        [logInViewController setFields:PFLogInFieldsFacebook | PFLogInFieldsDismissButton];
        logInViewController.delegate = self;
        [self presentViewController:logInViewController animated:YES completion:nil];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{

}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    // After logging in with Facebook
    if (!user.email) {
        if ([FBSDKAccessToken currentAccessToken]) {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSDictionary *r = (NSDictionary *)result;
                     user.email = [r objectForKey:@"email"];
                     [user setObject:[r objectForKey:@"name"] forKey:@"name"];
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                         NSLog(@"success: %d", succeeded);
                     }];
                 }
             }];
        }
    }
    
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults setObject:user forKey:@"current_user"];
    
    
//    PFObject *group = [PFObject objectWithClassName:@"Group"];
//    group[@"members"] = [NSArray arrayWithObjects:user, nil];
//    
//    [group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"success; %d", succeeded);
//    }];
    

//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    self.view.backgroundColor = [UIColor redColor];

}


- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
