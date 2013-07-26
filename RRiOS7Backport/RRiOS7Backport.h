//
//  RRiOS7Backport.h
//  RRiOS7Backport
//
//  Created by Paddy O'Brien on 2013-07-25.
//  Copyright (c) 2013 UD7. All rights reserved.
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

#if !COCOAPODS
	#define RRiOS7BackportFoundation	1
	#define RRiOS7BackportUIKit			1
	#define RRiOS7BackportGameKit		1
#endif

// Foundation
#if RRiOS7BackportFoundation
	#import "NSArray.h"
	#import "NSTimer.h"
	#import "NSData.h"
#endif

// GameKit
#if RRiOS7BackportGameKit
	#import "GKLocalPlayer.h"
#endif

// UIKit
#if RRiOS7BackportUIKit
	#import "UIView.h"
#endif