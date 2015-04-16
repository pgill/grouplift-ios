//
//  GLCollectionViewCell.m
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLCollectionViewCell.h"

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
    CGSize imageViewSize = CGSizeMake(50.0, 50.0);
    CGFloat imageTextSpacing = 10.0;
    CGFloat imageLeftMargin = 10.0;
    
    _imageView.frame = (CGRect){.origin = (CGPoint){.x = imageLeftMargin, .y = GLCenterY(self.frame.size, imageViewSize)}, .size = imageViewSize};
    
    [_titleLabel sizeToFit];
    _titleLabel.frame = (CGRect){.origin = (CGPoint){.x = GLLeft(_imageView.frame) + imageTextSpacing, .y = GLCenterY(self.frame.size, _titleLabel.frame.size)}, .size = _titleLabel.frame.size};
}

@end
