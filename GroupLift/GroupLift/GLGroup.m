//
//  GLGroup.m
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLGroup.h"

@implementation GLGroup

+ (GLGroup *)readFromPFObject:(PFObject *)obj
{
    if (obj == nil || obj == NULL) return nil;
 
//    NSLog(@"%@", obj);
    
    GLGroup *group = [[GLGroup alloc] init];
    group.uniqueId = obj.objectId;
    group.name = [obj objectForKey:@"name"];
    
    NSArray *members = [obj objectForKey:@"members"];
    
    
    NSMutableArray *memberList = [[NSMutableArray alloc] init];
    for (PFUser *user in members) {
        [memberList addObject:user];
    }
    
    group.members = [memberList copy];

    return group;
}

@end
