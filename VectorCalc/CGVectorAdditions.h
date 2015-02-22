//
//  CGVectorAdditions.h
//  SMG
//
//  Created by Sam Green on 3/25/14.
//  Copyright (c) 2014 Sam Green. All rights reserved.
//

#ifndef __CG_VECTOR_ADDITIONS_H
#define __CG_VECTOR_ADDITIONS_H

//@import CoreGraphics;
//@import Foundation;
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

#include <math.h>

#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
#include <arm_neon.h>
#endif


#pragma mark -
#pragma mark Prototypes
#pragma mark -

/* Create a vector from the given point */
CG_INLINE CGVector CGVectorFromPoint(CGPoint pt);

/* Add two vectors */
CG_INLINE CGVector CGVectorSum(CGVector vector1, CGVector vector2);

/* Subtract two vectors */
CG_INLINE CGVector CGVectorDifference(CGVector vector1, CGVector vector2);

/* Multiply two vectors */
CG_INLINE CGVector CGVectorMultiply(CGVector vector1, CGVector vector2);

/* Cross Product of two vectors */
CG_INLINE CGFloat CGVectorCrossProduct(CGVector vector1, CGVector vector2);

/* Cross Product of two vectors */
CG_INLINE CGFloat CGVectorCrossProductPolar(CGVector vector1, CGVector vector2);

/* Multiply a vector by a single scalar */
CG_INLINE CGVector CGVectorMultiplyByScalar(CGVector vector, CGFloat scalar);

/* Dot Product Polar */
CG_INLINE CGFloat CGVectorDotProductScalarPolar(CGVector vector, CGVector vector2);

/* Normalize a vector. This scales the length of the vector to 1 */
CG_INLINE CGVector CGVectorNormalize(CGVector vector);

/* Creates a vector perpendicular to `vector` */
CG_INLINE CGVector CGVectorMakePerpendicular(CGVector vector);

/* Calculate the angle of between two vectors */
CG_INLINE CGFloat CGVectorAngleBetween(CGVector vector1, CGVector vector2);

/* Calculate the angle of `vector` */
CG_INLINE CGFloat CGVectorAngle(CGVector vector);

/* Calculate the angle of `vector` for use with a SpriteKit zRotation property */
CG_INLINE CGFloat CGVectorAngleSK(CGVector vector);

/* Calculate the dot product of two vectors */
CG_INLINE CGFloat CGVectorDotProduct(CGVector vector1, CGVector vector2);

/* Calculate the magnitude (length) of a vector */
CG_INLINE CGFloat CGVectorLength(CGVector vector);

/* Calculate the distance between two vectors */
CG_INLINE CGFloat CGVectorDistance(CGVector vectorStart, CGVector vectorEnd);

/* Determine if two vectors are equal */
CG_INLINE bool __CGVectorEqualToVector(CGVector vector1, CGVector vector2);

/* Determine if two vectors are perpendicular */
CG_INLINE bool __CGVectorPerpendicularToVector(CGVector vector1, CGVector vector2);


#pragma mark -
#pragma mark Implementations
#pragma mark -

CG_INLINE CGVector
CGVectorFromPoint(CGPoint pt)
{
    return CGVectorMake(pt.x, pt.y);
}

CG_INLINE CGVector
CGVectorSum(CGVector vector1, CGVector vector2)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vadd_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    return *(CGVector *)&v;
#else
    return CGVectorMake(vector1.dx + vector2.dx, vector1.dy + vector2.dy);
#endif
}

CG_INLINE CGVector
CGVectorDifference(CGVector vector1, CGVector vector2)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vsub_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    return *(CGVector *)&v;
#else
    return CGVectorMake(vector1.dx - vector2.dx, vector1.dy - vector2.dy);
#endif
}

CG_INLINE CGVector
CGVectorMultiply(CGVector vector1, CGVector vector2)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    return *(CGVector *)&v;
#else
    return CGVectorMake(vector1.dx * vector2.dx, vector1.dy * vector2.dy);
#endif
}

CG_INLINE CGVector
CGVectorMultiplyByScalar(CGVector vector, CGFloat value)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector,
                             vdup_n_f32((float32_t)value));
    return *(CGVector *)&v;
#else
    return CGVectorMake(vector.dx * value, vector.dy * value);
#endif
}

CG_INLINE CGVector
CGVectorNormalize(CGVector vector)
{
    CGFloat length = CGVectorLength(vector);
    
    if (length == 0) {
        return CGVectorMake(0, 0);
    }
    
    CGFloat scale = 1.0f / length;
    return CGVectorMultiplyByScalar(vector, scale);
}

CG_INLINE CGVector
CGVectorMakePerpendicular(CGVector vector)
{
    return CGVectorMake(-vector.dy, vector.dx);
}

CG_INLINE CGFloat
CGVectorAngleBetween(CGVector vector1, CGVector vector2)
{
    CGFloat dot = CGVectorDotProduct(vector1, vector2);
    CGFloat magnitude = CGVectorLength(vector1) * CGVectorLength(vector2);
    
    if (magnitude == 0) {
        return 0;
    }
    
    CGFloat tmp = dot / magnitude;
    
    if (tmp > 1.0f) {
        tmp = 1.0f;
    } else if (tmp < -1.0f) {
        tmp = -1.0f;
    }
    
    return acosf( tmp );
}

CG_INLINE CGFloat
CGVectorAngle(CGVector vector)
{
    return atan2(vector.dy, vector.dx);
}

CG_INLINE CGFloat
CGVectorAngleSK(CGVector vector)
{
    return fmod(M_PI * 2.f - atan2(vector.dy, vector.dx) + M_PI_2, M_PI * 2.f);
}

CG_INLINE CGFloat
CGVectorDotProduct(CGVector vector1, CGVector vector2)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    v = vpadd_f32(v, v);
    return vget_lane_f32(v, 0);
#else
    return vector1.dx * vector2.dx + vector1.dy * vector2.dy;
#endif
}

CG_INLINE CGFloat
CGVectorDotProductScalarPolar(CGVector v1, CGVector v2){
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    v = vpadd_f32(v, v);
    return vget_lane_f32(v, 0);
#else

    float vectorOneX = v1.dx * cos((v1.dy)*M_PI/180);
    float vectorOneY = v1.dx * sin((v1.dy)*M_PI/180);
    float vectorTwoX = v2.dx * cos((v2.dy)*M_PI/180);
    float vectorTwoY = v2.dx * sin((v2.dy)*M_PI/180);
    
    double answerCrossPolar = vectorOneX * vectorTwoX + vectorOneY * vectorTwoY;
    
    
    
    return answerCrossPolar;
#endif
}


CG_INLINE CGFloat
CGVectorCrossProduct(CGVector vector1, CGVector vector2)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    v = vpadd_f32(v, v);
    return vget_lane_f32(v, 0);
#else
    return (vector1.dx * vector2.dy - (vector2.dx * vector1.dy));
#endif
}

CG_INLINE CGFloat
CGVectorCrossProductPolar(CGVector v1, CGVector v2)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector1,
                             *(float32x2_t *)&vector2);
    v = vpadd_f32(v, v);
    return vget_lane_f32(v, 0);
#else

    float vectorOneX = v1.dx * cos((v1.dy)*M_PI/180);
    float vectorOneY = v1.dx * sin((v1.dy)*M_PI/180);
    float vectorTwoX = v2.dx * cos((v2.dy)*M_PI/180);
    float vectorTwoY = v2.dx * sin((v2.dy)*M_PI/180);
    
    double answerCrossPolar = vectorOneX*vectorTwoY - (vectorOneY * vectorTwoX);
    
    
    
    return answerCrossPolar;
    
   // return (vector1.dx * vector2.dy - (vector2.dx * vector1.dy));
#endif
}



CG_INLINE CGFloat
CGVectorLength(CGVector vector)
{
#if defined(__ARM_NEON__) && !CGFLOAT_IS_DOUBLE
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector,
                             *(float32x2_t *)&vector);
    v = vpadd_f32(v, v);
    return sqrt(vget_lane_f32(v, 0));
#else
    return hypotf(vector.dx, vector.dy);
#endif
}

CG_INLINE CGFloat
CGVectorDistance(CGVector vectorStart, CGVector vectorEnd)
{
    return CGVectorLength(CGVectorDifference(vectorEnd, vectorStart));
}

CG_INLINE bool
__CGVectorEqualToVector(CGVector vector1, CGVector vector2)
{
    return vector1.dx == vector2.dx && vector1.dy == vector2.dy;
}
#define CGVectorEqualToVector __CGVectorEqualToVector

CG_INLINE bool
__CGVectorPerpendicularToVector(CGVector vector1, CGVector vector2)
{
    return CGVectorDotProduct(vector1, vector2) == 0;
}
#define CGVectorPerpendicularToVector __CGVectorPerpendicularToVector
#define CGVectorOrthogonalToVector __CGVectorPerpendicularToVector

#endif /* __CG_VECTOR_ADDITIONS_H */
