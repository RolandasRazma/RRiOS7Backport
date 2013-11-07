//
//  UIView.m
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 13/06/2013.
//  Copyright (c) 2013 Rolandas Razma.
//
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UIView (RRiOS7Backport)


+ (void)load {
    
    if( ![[UIView class] respondsToSelector:@selector(performWithoutAnimation:)] ){
        RR_ADD_CLASS_METHOD([UIView class], @selector(performWithoutAnimation:),    @selector(rr_performWithoutAnimation:));
    }

    if( ![UIView instancesRespondToSelector:@selector(drawViewHierarchyInRect:)] ){
        RR_ADD_INSTANCE_METHOD([UIView class], @selector(drawViewHierarchyInRect:afterScreenUpdates:), @selector(rr_drawViewHierarchyInRect:afterScreenUpdates:));
    }
    
}


+ (void)rr_performWithoutAnimation:(void (^)(void))actionsWithoutAnimation {
    
    BOOL areAnimationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];

    actionsWithoutAnimation();
    
    [UIView setAnimationsEnabled:areAnimationsEnabled];
    
}


- (BOOL)rr_drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates {
    #warning as stated by https://github.com/RolandasRazma/RRiOS7Backport/issues/1 this method doesn't work in all situations
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    CGRect clipBoundingBox = CGContextGetClipBoundingBox(contextRef);

    // Is rects same?
    if( !CGRectEqualToRect(clipBoundingBox, rect) ){
        CGContextSaveGState(contextRef);
        
        // Transform to rect
        CGContextTranslateCTM(contextRef, rect.origin.x, rect.origin.y);
        CGContextScaleCTM(contextRef, rect.size.width /clipBoundingBox.size.width, rect.size.height /clipBoundingBox.size.height);
        
        // Draw
        [self.layer renderInContext:contextRef];
        
        CGContextRestoreGState(contextRef);
    }else{
        // Draw
        [self.layer renderInContext:contextRef];
    }

    return YES;
}


// look at
//+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
//+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations NS_AVAILABLE_IOS(7_0); // start time and duration are values between 0.0 and 1.0 specifying time and duration relative to the overall time of the keyframe animation


@end
#pragma clang diagnostic pop
