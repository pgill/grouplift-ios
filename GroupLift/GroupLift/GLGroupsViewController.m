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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "GLCollectionViewCell.h"
#import "GLGroupViewController.h"
#import "GLGroupsManager.h"


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
        self.navigationItem.title = @"GroupLift";
        self.backButtonTitle = @"Back";
        

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup collection view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    // Register cell
    [_collectionView registerClass:[GLCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    if ([PFUser currentUser] &&
         [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
       [GLGroupsManager loadGroupsForUserWithSuccess:^(NSArray *groups) {
           
           // Create dummy titles
           _groupItems = groups;
           
           // Create dummy images
           NSMutableArray *groupImages = [[NSMutableArray alloc] init];
           for (NSInteger i = 0; i < _groupItems.count; ++i) {
               UIImage *image = [UIImage imageWithColor:[UIColor lightGrayColor]];
               UIImage *roundedImage = [UIImage createRoundedThumbnailFromImage:image size:CGSizeMake(50.0, 50.0)];
               [groupImages addObject:roundedImage];
           }
           
           _groupImages = [NSArray arrayWithArray:groupImages];
           
           [_collectionView reloadData];

       } failure:^(NSError *error) {
           NSLog(@"failure: %@", error);
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
                     NSLog(@"request: %@", r);
                     user.email = [r objectForKey:@"email"];
                     [user setObject:[r objectForKey:@"name"] forKey:@"name"];
                     [user setObject:[r objectForKey:@"id"] forKey:@"facebookId"];
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                         NSLog(@"success: %d", succeeded);
                     }];
                 }
             }];
        }
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });
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
    GLGroup *group = [_groupItems objectAtIndex:indexPath.row];
    cell.titleLabel.text = group.name;
    
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
    return 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLGroupViewController *vc = [[GLGroupViewController alloc] init];
    vc.groupTitle = [_groupItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
