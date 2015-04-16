//
//  GLViewController.m
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLViewController.h"

@implementation GLViewController
- (id)init
{
    self = [super init];
    
    if (self) {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    if (self.backButtonTitle) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:self.backButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
    }
}

@end
