//
//  GLCollectionViewCell.m
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLCollectionViewCell.h"

#define IMAGEVIEW_SIZE CGSizeMake(50.0, 50.0)

@implementation GLCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Setup
        self.backgroundColor = [UIColor redColor];
        
        // Title
        _titleLabel = [[UILabel alloc] init];
        
        // Image View
        _imageView = [[UIImageView alloc] init];
        
        [self addSubview:_titleLabel];
        [self addSubview:_imageView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    _imageView.frame = (CGRect){.origin = (CGPoint){.x = 0.0, .y = GLCenterY(self.frame.size, IMAGEVIEW_SIZE)}, .size = IMAGEVIEW_SIZE};
    
    [_titleLabel sizeToFit];
    _titleLabel.frame = (CGRect){.origin = (CGPoint){.x = GLLeft(_imageView.frame), .y = GLCenterY(self.frame.size, _titleLabel.frame.size)}, .size = _titleLabel.frame.size};
}

@end
