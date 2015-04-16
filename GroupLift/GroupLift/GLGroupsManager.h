//
//  GLGroupsManager.h
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLGroup.h"

@interface GLGroupsManager : NSObject

+ (void)loadGroupsForUserWithSuccess:(void(^)(NSArray *))success
                             failure:(void(^)(NSError *error))failure;

@end
