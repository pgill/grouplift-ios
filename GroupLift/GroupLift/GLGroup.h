//
//  GLGroup.h
//  GroupLift
//
//  Created by Prabhdeep Gill on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface GLGroup : NSObject

+ (GLGroup *)readFromPFObject:(PFObject *)obj;

@property (nonatomic, strong) NSString *uniqueId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) UIImage *image;

@end
