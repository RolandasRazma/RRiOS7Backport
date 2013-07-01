//
//  NSData.h
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 26/06/2013.
//  Copyright (c) 2013 Rolandas Razma.
//
//  Base64 encodin/decoding based on Nick Lockwood https://github.com/nicklockwood/Base64
//
//  This code is distributed under the permissive zlib License
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
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
