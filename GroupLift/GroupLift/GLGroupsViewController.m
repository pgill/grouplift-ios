//
//  ViewController.m
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/14/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLGroupsViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "GLCollectionViewCell.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface GLGroupsViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *groupItems;
@property (nonatomic, strong) NSArray *groupImages;
@end

static NSString *CellIdentifier = @"GroupCell";

@implementation GLGroupsViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        // Create dummy titles
        _groupItems = @[@"Me",
                        @"Weight Lifting",
                        @"Squat Club",
                        @"Umano",
                        @"Ian, Yuna",
                        @"Ian, Patrick",
                        @"Get Huge Crew"
                        ];
        
        // Create dummy images
        NSMutableArray *groupImages = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < _groupItems.count; ++i) {
            UIImage *image = [UIImage imageWithColor:[UIColor greenColor]];
            UIImage *roundedImage = [UIImage createRoundedThumbnailFromImage:image size:CGSizeMake(50.0, 50.0)];
            [groupImages addObject:roundedImage];
        }
        
        _groupImages = [NSArray arrayWithArray:groupImages];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup collection view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    // Register cell
    [_collectionView registerClass:[GLCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
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
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"email", @"public_profile",  @"user_friends", nil]];
        [logInViewController setFields:PFLogInFieldsFacebook | PFLogInFieldsDismissButton];
        logInViewController.delegate = self;
        [self presentViewController:logInViewController animated:YES completion:nil];
    }
    
    // Add subviews
    [self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login

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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _groupItems.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Set title
    cell.titleLabel.text = [_groupItems objectAtIndex:indexPath.row];
    
    // Set image
    cell.imageView.image = [_groupImages objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){.width = self.view.frame.size.width, .height = 75.0};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

@end
