//
//  GLGroupViewController.m
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLGroupViewController.h"

@implementation GLGroupViewController
- (id)init
{
    self = [super init];
    
    if (self) {
    
    }
    
    return self;
}

- (void)setGroupTitle:(NSString *)groupTitle
{
    self.navigationItem.title = groupTitle;
}

@end
