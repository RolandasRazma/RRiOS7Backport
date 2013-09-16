//
//  NSTimer.m
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 19/06/2013.
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

#import "NSTimer.h"


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation NSTimer (RRiOS7Backport)


+ (void)load {
    
    if( ![NSTimer instancesRespondToSelector:@selector(tolerance)] ){
        RR_ADD_INSTANCE_METHOD([NSTimer class], @selector(setTolerance:), @selector(rr_setTolerance:));
        RR_ADD_INSTANCE_METHOD([NSTimer class], @selector(tolerance),     @selector(rr_tolerance));
    }

}


- (NSTimeInterval)rr_tolerance {
    return [objc_getAssociatedObject(self, @selector(tolerance)) doubleValue];
}


- (void)rr_setTolerance:(NSTimeInterval)tolerance {
    objc_setAssociatedObject(self, @selector(tolerance), @(tolerance), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
#pragma clang diagnostic pop