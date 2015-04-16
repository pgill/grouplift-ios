//
//  GLUser.m
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLUser.h"

@interface GLUser()
@property (nonatomic, strong) PFUser *user;
@end

@implementation GLUser
- (void)initWithPFUser:(PFUser *)u
{
    self.user = u;
}
@end
