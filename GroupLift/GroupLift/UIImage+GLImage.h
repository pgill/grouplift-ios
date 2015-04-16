//
//  UIImage+GLImage.h
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GLImage)

/**
 * Creates a thumbnail of an image
 */

+ (UIImage *) createThumbnailFromImage:(UIImage *)image size:(CGSize)size cornerRadius:(CGFloat)radius;

/**
 * Creates a circle image
 */

+ (UIImage *)createRoundedThumbnailFromImage:(UIImage *)image size:(CGSize)size;

/**
 * Creates an image from a color
 */

+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * Creates an image from a view
 */
+ (UIImage *)imageFromView:(UIView *)view;

@end
