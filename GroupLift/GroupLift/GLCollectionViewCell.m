//
//  GLCollectionViewCell.m
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import "GLCollectionViewCell.h"
@interface GLCollectionViewCell()
@property (nonatomic, strong) UIView *borderView;
@end

@implementation GLCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {        
        // Title
        _titleLabel = [[UILabel alloc] init];
        
        // Image View
        _imageView = [[UIImageView alloc] init];
        
        // Border view
        _borderView = [[UIView alloc] init];
        _borderView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:_titleLabel];
        [self addSubview:_imageView];
        [self addSubview:_borderView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Set frames
    CGSize imageViewSize = CGSizeMake(50.0, 50.0);
    CGFloat imageTextSpacing = 10.0;
    CGFloat imageLeftMargin = 10.0;
    CGFloat borderHeight = 0.5;
    
    _imageView.frame = (CGRect){.origin = (CGPoint){.x = imageLeftMargin, .y = GLCenterY(self.frame.size, imageViewSize)}, .size = imageViewSize};
    
    [_titleLabel sizeToFit];
    _titleLabel.frame = (CGRect){.origin = (CGPoint){.x = GLLeft(_imageView.frame) + imageTextSpacing, .y = GLCenterY(self.frame.size, _titleLabel.frame.size)}, .size = _titleLabel.frame.size};
    
    _borderView.frame = (CGRect){.origin = (CGPoint){.y = self.frame.size.height - borderHeight}, .size = (CGSize){.width = self.frame.size.width, .height = borderHeight}};
}

@end
