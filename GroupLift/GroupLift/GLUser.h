//
//  GLUser.h
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface GLUser : NSObject

- (void)initWithPFUser:(PFUser *)user;

@property (nonatomic, strong) NSString *uniqueId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *facebookId;

@end
