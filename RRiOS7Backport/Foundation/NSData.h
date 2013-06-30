//
//  NSData.h
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 26/06/2013.
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

#import <Foundation/Foundation.h>


#ifndef __IPHONE_7_0

typedef NS_OPTIONS(NSUInteger, NSDataBase64EncodingOptions) {
    // Use zero or one of the following to control the maximum line length after which a line ending is inserted. No line endings are inserted by default.
    NSDataBase64Encoding64CharacterLineLength = 1UL << 0,
    NSDataBase64Encoding76CharacterLineLength = 1UL << 1,
    
    // Use zero or more of the following to specify which kind of line ending is inserted. The default line ending is CR LF.
    NSDataBase64EncodingEndLineWithCarriageReturn = 1UL << 4,
    NSDataBase64EncodingEndLineWithLineFeed = 1UL << 5,
};


typedef NS_OPTIONS(NSUInteger, NSDataBase64DecodingOptions) {
    // Use the following option to modify the decoding algorithm so that it ignores unknown non-Base64 bytes, including line ending characters.
    NSDataBase64DecodingIgnoreUnknownCharacters = 1UL << 0
};

#endif


@interface NSData (RRiOS7Backport)

#ifndef __IPHONE_7_0

/* Create an NSData from a Base-64 encoded NSString using the given options. By default, returns nil when the input is not recognized as valid Base-64.
 */
- (id)initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options;

/* Create a Base-64 encoded NSString from the receiver's contents using the given options.
 */
- (NSString *)base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options;

/* Create an NSData from a Base-64, UTF-8 encoded NSData. By default, returns nil when the input is not recognized as valid Base-64.
 */
- (id)initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options;

/* Create a Base-64, UTF-8 encoded NSData from the receiver's contents using the given options.
 */
- (NSData *)base64EncodedDataWithOptions:(NSDataBase64EncodingOptions)options;

#endif

@end
