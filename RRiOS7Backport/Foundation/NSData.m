//
//  NSData.m
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 26/06/2013.
//  Copyright (c) 2013 Rolandas Razma.
//
//  Base64 encodin/decoding from https://github.com/ekscrypto/Base64/ (Public Domain)
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
    return [self initWithBase64EncodedData: [base64String dataUsingEncoding:NSASCIIStringEncoding]
                                   options: options];
}


- (NSString *)rr_base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options {
    NSData *base64EncodedData = [self base64EncodedDataWithOptions:options];
    
    if( base64EncodedData ){
        NSString *string = [[NSString alloc] initWithData:base64EncodedData encoding:NSASCIIStringEncoding];
        NSString *endLine= @"\r\n";
        NSInteger lineLength = -1;
        
        // line length
        if( (options & NSDataBase64Encoding64CharacterLineLength) && !(options & NSDataBase64Encoding76CharacterLineLength) ){
            lineLength = 64;
        }else if( (options & NSDataBase64Encoding76CharacterLineLength) && !(options & NSDataBase64Encoding64CharacterLineLength) ){
            lineLength = 76;
        }
        
        // end line
        if( (options & NSDataBase64EncodingEndLineWithCarriageReturn) && !(options & NSDataBase64EncodingEndLineWithLineFeed) ){
            endLine = @"\r";
        }else if( (options & NSDataBase64EncodingEndLineWithLineFeed) && !(options & NSDataBase64EncodingEndLineWithCarriageReturn) ){
            endLine = @"\n";
        }
        
        if( lineLength > 0 ){    
            NSMutableString *mutableString = [string mutableCopy];
            
            for( NSUInteger i=lineLength; i<mutableString.length; i+=lineLength ){
                [mutableString insertString:endLine atIndex:i];
                i += endLine.length;
            }
            
            return [mutableString copy];
        }

        return string;
    }else{
        return nil;
    }
}


- (id)rr_initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options {

    // Strip
    NSMutableData *mutableBase64Data = [base64Data mutableCopy];
    
    void (^stripDataFromData)(NSData *, NSMutableData **) = ^(NSData *dataToStrip, NSMutableData **fromData) {
        NSRange range;
        
        do {
            range = [*fromData rangeOfData: dataToStrip
                                   options: NSDataSearchBackwards
                                     range: NSMakeRange(0, [*fromData length])];
            
            if( range.location != NSNotFound ){
                [*fromData replaceBytesInRange:range
                                     withBytes:NULL
                                        length:0];
            }
        }while ( range.location != NSNotFound );
    };
    
    stripDataFromData([@"="  dataUsingEncoding:NSASCIIStringEncoding], &mutableBase64Data);
    stripDataFromData([@"\r" dataUsingEncoding:NSASCIIStringEncoding], &mutableBase64Data);
    stripDataFromData([@"\n" dataUsingEncoding:NSASCIIStringEncoding], &mutableBase64Data);

    base64Data = (NSData *)mutableBase64Data;
    
    
    // Decode
    NSData *data = nil;
    unsigned char *decodedBytes = NULL;
    @try {
        #define __ 255
        static char decodingTable[256] = {
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x00 - 0x0F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x10 - 0x1F
            __,__,__,__, __,__,__,__, __,__,__,62, __,__,__,63,  // 0x20 - 0x2F
            52,53,54,55, 56,57,58,59, 60,61,__,__, __, 0,__,__,  // 0x30 - 0x3F
            __, 0, 1, 2,  3, 4, 5, 6,  7, 8, 9,10, 11,12,13,14,  // 0x40 - 0x4F
            15,16,17,18, 19,20,21,22, 23,24,25,__, __,__,__,__,  // 0x50 - 0x5F
            __,26,27,28, 29,30,31,32, 33,34,35,36, 37,38,39,40,  // 0x60 - 0x6F
            41,42,43,44, 45,46,47,48, 49,50,51,__, __,__,__,__,  // 0x70 - 0x7F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x80 - 0x8F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x90 - 0x9F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xA0 - 0xAF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xB0 - 0xBF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xC0 - 0xCF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xD0 - 0xDF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xE0 - 0xEF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xF0 - 0xFF
        };
        
        unsigned char *encodedBytes = (unsigned char *)[base64Data bytes];
        
        NSUInteger encodedLength = [base64Data length];
        NSUInteger encodedBlocks = (encodedLength +3) >> 2;
        NSUInteger expectedDataLength = encodedBlocks *3;
        
        unsigned char decodingBlock[4];
        
        decodedBytes = malloc(expectedDataLength);
        if( decodedBytes != NULL ) {
            
            NSUInteger i = 0;
            NSUInteger j = 0;
            NSUInteger k = 0;
            unsigned char c;
            while( i < encodedLength ) {
                c = decodingTable[encodedBytes[i]];
                i++;

                if( c != __ ) {
                    decodingBlock[j] = c;
                    j++;
                    
                    if( j == 4 ) {
                        decodedBytes[k]   = (unsigned char)((decodingBlock[0] << 2) | (decodingBlock[1] >> 4));
                        decodedBytes[k+1] = (unsigned char)((decodingBlock[1] << 4) | (decodingBlock[2] >> 2));
                        decodedBytes[k+2] = (unsigned char)((decodingBlock[2] << 6) | (decodingBlock[3]));
                        
                        j  = 0;
                        k += 3;
                    }
                }
            }
            
            // Process left over bytes, if any
            if( j == 3 ) {
                decodedBytes[k]   = (unsigned char)((decodingBlock[0] << 2) | (decodingBlock[1] >> 4));
                decodedBytes[k+1] = (unsigned char)((decodingBlock[1] << 4) | (decodingBlock[2] >> 2));
                k += 2;
            } else if( j == 2 ) {
                decodedBytes[k] = (unsigned char)((decodingBlock[0] << 2) | (decodingBlock[1] >> 4));
                k += 1;
            }
            data = [[NSData alloc] initWithBytes:decodedBytes length:k];
        }
    }
    @catch (NSException *exception) {
        data = nil;
        NSLog(@"WARNING: error occured while decoding base 32 string: %@", exception);
    }
    @finally {
        if( decodedBytes != NULL ) {
            free( decodedBytes );
        }
    }
    
    return data;

}


- (NSData *)rr_base64EncodedDataWithOptions:(NSDataBase64EncodingOptions)options {
    
    NSData *base64EncodedData = nil;
    unsigned char *encodingBytes = NULL;
    @try {
        static char encodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        static NSUInteger paddingTable[] = {0,2,1};
        //                 Table 1: The Base 64 Alphabet
        //
        //    Value Encoding  Value Encoding  Value Encoding  Value Encoding
        //        0 A            17 R            34 i            51 z
        //        1 B            18 S            35 j            52 0
        //        2 C            19 T            36 k            53 1
        //        3 D            20 U            37 l            54 2
        //        4 E            21 V            38 m            55 3
        //        5 F            22 W            39 n            56 4
        //        6 G            23 X            40 o            57 5
        //        7 H            24 Y            41 p            58 6
        //        8 I            25 Z            42 q            59 7
        //        9 J            26 a            43 r            60 8
        //       10 K            27 b            44 s            61 9
        //       11 L            28 c            45 t            62 +
        //       12 M            29 d            46 u            63 /
        //       13 N            30 e            47 v
        //       14 O            31 f            48 w         (pad) =
        //       15 P            32 g            49 x
        //       16 Q            33 h            50 y
        
        NSUInteger dataLength = [self length];
        NSUInteger encodedBlocks = (dataLength *8) /24;
        NSUInteger padding = paddingTable[dataLength % 3];
        if( padding > 0 ) encodedBlocks++;
        NSUInteger encodedLength = encodedBlocks * 4;
        
        encodingBytes = malloc(encodedLength);
        if( encodingBytes != NULL ) {
            NSUInteger rawBytesToProcess = dataLength;
            NSUInteger rawBaseIndex = 0;
            NSUInteger encodingBaseIndex = 0;
            unsigned char *rawBytes = (unsigned char *)[self bytes];
            unsigned char rawByte1, rawByte2, rawByte3;
            while( rawBytesToProcess >= 3 ) {
                rawByte1 = rawBytes[rawBaseIndex];
                rawByte2 = rawBytes[rawBaseIndex+1];
                rawByte3 = rawBytes[rawBaseIndex+2];
                encodingBytes[encodingBaseIndex]   = encodingTable[((rawByte1 >> 2) & 0x3F)];
                encodingBytes[encodingBaseIndex+1] = encodingTable[((rawByte1 << 4) & 0x30) | ((rawByte2 >> 4) & 0x0F)];
                encodingBytes[encodingBaseIndex+2] = encodingTable[((rawByte2 << 2) & 0x3C) | ((rawByte3 >> 6) & 0x03)];
                encodingBytes[encodingBaseIndex+3] = encodingTable[(rawByte3 & 0x3F)];
                
                rawBaseIndex += 3;
                encodingBaseIndex += 4;
                rawBytesToProcess -= 3;
            }
            
            rawByte2 = 0;
            switch( dataLength -rawBaseIndex ) {
                case 2:
                    rawByte2 = rawBytes[rawBaseIndex+1];
                case 1:
                    rawByte1 = rawBytes[rawBaseIndex];
                    encodingBytes[encodingBaseIndex]   = encodingTable[((rawByte1 >> 2) & 0x3F)];
                    encodingBytes[encodingBaseIndex+1] = encodingTable[((rawByte1 << 4) & 0x30) | ((rawByte2 >> 4) & 0x0F)];
                    encodingBytes[encodingBaseIndex+2] = encodingTable[((rawByte2 << 2) & 0x3C)];
                    // we can skip rawByte3 since we have a partial block it would always be 0
                    break;
            }
            
            // compute location from where to begin inserting padding, it may overwrite some bytes from the partial block encoding
            // if their value was 0 (cases 1-2).
            encodingBaseIndex = encodedLength - padding;
            while( padding-- > 0 ) {
                encodingBytes[encodingBaseIndex++] = '=';
            }

            base64EncodedData = [NSData dataWithBytes:encodingBytes length:encodedLength];
        }
    }
    @catch (NSException *exception) {
        base64EncodedData = nil;
        NSLog(@"WARNING: error occured while tring to encode base 32 data: %@", exception);
    }
    @finally {
        if( encodingBytes != NULL ) {
            free( encodingBytes );
        }
    }
    
    return base64EncodedData;
}


@end
#pragma clang diagnostic pop