//
//  GLGeometry.h
//  GroupLift
//
//  Created by Ian Mendiola on 4/16/15.
//  Copyright (c) 2015 SoThree. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>

#ifndef GroupLift_GLGeometry_h
#define GroupLift_GLGeometry_h

CG_INLINE CGFloat
GLCenterY(CGSize containerSize, CGSize size)
{
    return containerSize.height / 2.0 - size.height / 2.0;
}

CG_INLINE CGFloat
GLLeft(CGRect frame)
{
    return frame.origin.x + frame.size.width;
}

#endif
