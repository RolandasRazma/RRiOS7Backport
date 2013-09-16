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
    BOOL isIOS6 = ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] == NSOrderedSame);
    STAssertTrue(isIOS6, @"Tests should be run on iOS6");
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
