//
//  GLGroupsManager.m
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLGroupsManager.h"

#import <Parse/Parse.h>

@implementation GLGroupsManager


+ (void)loadGroupsForUserWithSuccess:(void(^)(NSArray *))success
                             failure:(void(^)(NSError *error))failure;
{
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    [query whereKey:@"members" containedIn:@[[PFUser currentUser]]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *groups, NSError *error) {
        if (error) {
            return failure(error);
        }
        
        NSMutableArray *results = [[NSMutableArray alloc] init];
        for (PFObject *g in groups) {
            [results addObject:[GLGroup readFromPFObject:g]];
        }
        
        return success([results copy]);
    }];
}

@end
