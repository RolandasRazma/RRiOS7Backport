//
//  NSData.m
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

#import "NSData.h"
#import <CommonCrypto/CommonCryptor.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation NSData (RRiOS7Backport)


+ (void)load {
    
    if( ![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)] ){
        RR_ADD_INSTANCE_METHOD([NSData class], @selector(initWithBase64EncodedString:options:), @selector(rr_initWithBase64EncodedString:options:));
        RR_ADD_INSTANCE_METHOD([NSData class], @selector(base64EncodedStringWithOptions:),      @selector(rr_base64EncodedStringWithOptions:));
        RR_ADD_INSTANCE_METHOD([NSData class], @selector(initWithBase64EncodedData:options:),   @selector(rr_initWithBase64EncodedData:options:));
        RR_ADD_INSTANCE_METHOD([NSData class], @selector(base64EncodedDataWithOptions:),        @selector(rr_base64EncodedDataWithOptions:));
    }
    
}


- (id)rr_initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options {
    
    if (base64String == nil || base64String.length < 1)
    {
        @throw([NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"nil string argument"]
                                     userInfo:nil]);
    }
    
    return [self initWithBase64EncodedData: [base64String dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]
                                   options: options];
}


- (NSString *)rr_base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options {
    return [[NSString alloc] initWithData: [self base64EncodedDataWithOptions:options]
                                 encoding: NSASCIIStringEncoding];
}


- (id)rr_initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options {
    
    if (base64Data == nil || base64Data.length < 1)
    {
        @throw([NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"nil data argument"]
                                     userInfo:nil]);
    }
    else if (base64Data.length % 4 != 0)
    {
        return nil;
    }
    
    const char lookup[] = {
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
        99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62, 99, 99, 99, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99, 99, 99, 99, 99,
        99,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99, 99, 99, 99, 99,
        99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99, 99, 99, 99, 99
    };
    
    NSUInteger inputLength = [base64Data length];
    const unsigned char *inputBytes = [base64Data bytes];
    
    NSUInteger maxOutputLength = (inputLength /4 +1) *3;
    NSMutableData *outputData  = [NSMutableData dataWithLength:maxOutputLength];
    unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
    
    int accumulator = 0;
    long long outputLength = 0;
    unsigned char accumulated[] = {0, 0, 0, 0};
    for ( long long i = 0; i < inputLength; i++ ) {
        unsigned char decoded = lookup[inputBytes[i] & 0x7F];
        if ( decoded != 99 ) {
            accumulated[accumulator] = decoded;
            if (accumulator == 3)
            {
                outputBytes[outputLength++] = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);
                outputBytes[outputLength++] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);
                outputBytes[outputLength++] = (unsigned char)(accumulated[2] << 6) | accumulated[3];
            }
            accumulator = (accumulator + 1) % 4;
        }
    }

    //handle left-over data
    if (accumulator > 0) outputBytes[outputLength]   = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);
    if (accumulator > 1) outputBytes[++outputLength] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);
    if (accumulator > 2) outputLength++;

    //truncate data to match actual output length
    outputData.length = outputLength;
    
    return ((outputLength>0)?[self initWithData:outputData]:nil);
}


- (NSData *)rr_base64EncodedDataWithOptions:(NSDataBase64EncodingOptions)options {
    NSUInteger wrapWidth = 0;
    
    if( (options & NSDataBase64Encoding64CharacterLineLength) && !(options & NSDataBase64Encoding76CharacterLineLength) ){
        wrapWidth = 64;
    }else if( (options & NSDataBase64Encoding76CharacterLineLength) && !(options & NSDataBase64Encoding64CharacterLineLength) ){
        wrapWidth = 76;
    }
    
    if( wrapWidth > 0 && !(options & NSDataBase64EncodingEndLineWithCarriageReturn) && !(options & NSDataBase64EncodingEndLineWithLineFeed) ){
        options = options | NSDataBase64EncodingEndLineWithCarriageReturn | NSDataBase64EncodingEndLineWithLineFeed;
    }
    
    
    //ensure wrapWidth is a multiple of 4
    wrapWidth = (wrapWidth / 4) *4;
    
    const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    NSUInteger inputLength          = [self length];
    const unsigned char *inputBytes = [self bytes];
    
    NSUInteger maxOutputLength = (inputLength /3 +1) *4;
    maxOutputLength += ((wrapWidth>0)?(maxOutputLength /wrapWidth) *2:0);
    
    unsigned char *outputBytes = (unsigned char *)malloc(maxOutputLength);
    
    long long i;
    NSUInteger outputLength = 0;
    for ( i = 0; i < inputLength -2; i += 3 ){
        outputBytes[outputLength++] = lookup[(inputBytes[i]      & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i]     & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = lookup[((inputBytes[i + 1] & 0x0F) << 2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
        outputBytes[outputLength++] = lookup[inputBytes[i + 2]   & 0x3F];
        
        //add line break
        if ( wrapWidth && (outputLength +2) % (wrapWidth +2) == 0 ) {
            if( options & NSDataBase64EncodingEndLineWithCarriageReturn ){
                outputBytes[outputLength++] = '\r';
            }
            if( options & NSDataBase64EncodingEndLineWithLineFeed ){
                outputBytes[outputLength++] = '\n';
            }
        }
    }
    
    //handle left-over data
    if ( i == inputLength -2 ) {
        // = terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i]     & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i]    & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
        outputBytes[outputLength++] = lookup[(inputBytes[i + 1] & 0x0F) << 2];
        outputBytes[outputLength++] =   '=';
    } else if ( i == inputLength -1 ) {
        // == terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0xFC) >> 2];
        outputBytes[outputLength++] = lookup[(inputBytes[i] & 0x03) << 4];
        outputBytes[outputLength++] = '=';
        outputBytes[outputLength++] = '=';
    }
    
    if ( outputLength >= 4 ) {
        //truncate data to match actual output length
        outputBytes = realloc(outputBytes, outputLength);
        
        return [[NSData alloc] initWithBytesNoCopy:outputBytes length:outputLength freeWhenDone:YES];
    } else if ( outputBytes ){
        free(outputBytes);
    }
    
    return nil;
}


@end
#pragma clang diagnostic pop