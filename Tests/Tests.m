//
//  Tests.m
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 19/06/2013.
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


#import <SenTestingKit/SenTestingKit.h>
#import <QuartzCore/QuartzCore.h>


@interface Tests : SenTestCase

@end


@implementation Tests


- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}


- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testEnvironment {
#ifdef __IPHONE_7_0
    STAssertTrue(&UIContentSizeCategoryMedium == NULL, @"Tests should be run on iOS6 or earlyer");
#endif
}


@end


@implementation Tests (NSArray)


- (void)testFirstObject {
    
    // Test if method exists
    STAssertTrue([NSArray instancesRespondToSelector:@selector(firstObject)], @"missing -[NSArray firstObject]");
    
    // Test if method returns correct value
    STAssertTrue(([[@[@"A", @"B"] firstObject] isEqualToString:@"A"]), @"-[NSArray firstObject] returned unexpected object");
    
}


@end


@implementation Tests (UIView)


- (void)testPerformWithoutAnimation {
    
    // Test if method exists
    STAssertTrue([[UIView class] respondsToSelector:@selector(performWithoutAnimation:)], @"missing +[UIView performWithoutAnimation:]");

    // Test animation suppression
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 50, 50)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 50, 50)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
    
    [UIView animateWithDuration: 10.0f
                     animations: ^{
                         
                         [view1 setCenter:CGPointMake(100, 200)];
                         
                         STAssertNotNil(view1.layer.animationKeys, @"missing animationKeys for animating view");
                         
                         [UIView performWithoutAnimation: ^{
                             [view2 setCenter:CGPointMake(150, 200)];
                         }];
                         
                         STAssertNil(view2.layer.animationKeys, @"animationKeys should be absent for non animating view");
                         
                         [view3 setCenter:CGPointMake(200, 200)];
                         
                         STAssertNotNil(view3.layer.animationKeys, @"missing animationKeys for animating view");
                         
                     }];
}


- (void)testDrawViewHierarchyInRect {
    
    // Test if method exists
    STAssertTrue([UIView instancesRespondToSelector:@selector(drawViewHierarchyInRect:)], @"missing -[UIView drawViewHierarchyInRect:]");

}


@end


@implementation Tests (NSTimer)


- (void)testTolerance {
    
    // Test if method exists
    STAssertTrue([NSTimer instancesRespondToSelector:@selector(tolerance)],     @"missing -[NSTimer tolerance]");
    STAssertTrue([NSTimer instancesRespondToSelector:@selector(setTolerance:)], @"missing -[NSTimer setTolerance:]");
    
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:nil interval:0 target:NULL selector:NULL userInfo:NULL repeats:NO];
    [timer setTolerance:10];
    
    // Test if method returns correct value
    STAssertTrue(timer.tolerance == 10, @"-[NSTimer tolerance] returned unexpected value");
    
}


@end


@implementation Tests (NSData)


- (void)testBase64Encoding {
    
    // Test if method exists
    STAssertTrue([NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)],   @"missing -[NSData initWithBase64EncodedString:options:]");
    STAssertTrue([NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)],        @"missing -[NSData base64EncodedStringWithOptions:]");
    STAssertTrue([NSData instancesRespondToSelector:@selector(initWithBase64EncodedData:options:)],     @"missing -[NSData initWithBase64EncodedData:options:]");
    STAssertTrue([NSData instancesRespondToSelector:@selector(base64EncodedDataWithOptions:)],          @"missing -[NSData base64EncodedDataWithOptions:]");
    
    
    // Test data from iOS7
    NSString *testString        = @"T汉字/漢字his\nis\tTest^&*()_\nS\rtring\tTest\nS\rtring\nThis\nis\tTesnThis\nis\tTest\nS\rtring\n";
    NSData   *testData          = [testString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *testEncodedString = @"VOaxieWtly/mvKLlrZdoaXMKaXMJVGVzdF4mKigpXwpTDXRyaW5nCVRlc3QKUw10cmluZwpUaGlzCmlzCVRlc25UaGlzCmlzCVRlc3QKUw10cmluZwo=";
    NSData   *testEncodedData   = [testEncodedString dataUsingEncoding:NSUTF8StringEncoding];


    // Try encode
    NSString *base64EncodedString = [testData base64EncodedStringWithOptions:0];
    STAssertNotNil(base64EncodedString, @"failed -[NSData base64EncodedStringWithOptions:]");
    STAssertTrue([base64EncodedString isEqualToString: testEncodedString], @"Encoded string not same as on iOS7");
    
    NSData *base64EncodedData = [testData base64EncodedDataWithOptions:0];
    STAssertNotNil(base64EncodedData, @"failed -[NSData base64EncodedDataWithOptions:]");
    STAssertEqualObjects(base64EncodedData, testEncodedData, @"Decoded data not equal encoded one");
    

    // Try decode
/* need to fix this
    NSData *decodedBase64 = [[NSData alloc] initWithBase64EncodedString:base64EncodedString options:0];
    STAssertNotNil(decodedBase64, @"failed -[NSData initWithBase64EncodedString:options:]");
    STAssertEqualObjects(decodedBase64, testData, @"Decoded data not equal encoded one");

    NSData *decodedBase64d = [[NSData alloc] initWithBase64EncodedData:testEncodedData options:0];
    STAssertNotNil(decodedBase64d, @"failed -[NSData initWithBase64EncodedString:options:]");
    STAssertEqualObjects(decodedBase64d, testData, @"Decoded data not equal encoded one");
    STAssertEqualObjects(decodedBase64d, decodedBase64, @"Decoded data not equal encoded one");
*/
}


@end


@implementation Tests (GKLocalPlayer)

- (void)testLocalPlayerEvents {
    
    // Test if method exists
    STAssertTrue([GKLocalPlayer instancesRespondToSelector:@selector(registerListener:)],       @"missing -[GKLocalPlayer registerListener:]");
    STAssertTrue([GKLocalPlayer instancesRespondToSelector:@selector(unregisterListener:)],     @"missing -[GKLocalPlayer unregisterListener:]");
    STAssertTrue([GKLocalPlayer instancesRespondToSelector:@selector(unregisterAllListeners)],  @"missing -[GKLocalPlayer unregisterAllListeners]");
    
}

@end
