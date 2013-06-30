//
//  GKLocalPlayer.m
//  RRiOS7Backport
//
//  Created by Rolandas Razma on 30/06/2013.
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

#import "GKLocalPlayer.h"
#import <objc/runtime.h>


@interface GKLocalPlayer () <GKTurnBasedEventHandlerDelegate>
@end


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation GKLocalPlayer (RRiOS7Backport)


+ (void)load {
    
    if( ![GKLocalPlayer instancesRespondToSelector:@selector(registerListener:)] ){
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(registerListener:),                         @selector(rr_registerListener:));
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(unregisterListener:),                       @selector(rr_unregisterListener:));
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(unregisterAllListeners),                    @selector(rr_unregisterAllListeners));
        
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(handleInviteFromGameCenter:),               @selector(rr_handleInviteFromGameCenter:));
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(handleTurnEventForMatch:didBecomeActive:),  @selector(rr_handleTurnEventForMatch:didBecomeActive:));
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(handleTurnEventForMatch:),                  @selector(rr_handleTurnEventForMatch:));
        RR_ADD_INSTANCE_METHOD([GKLocalPlayer class], @selector(handleMatchEnded:),                         @selector(rr_handleMatchEnded:));
    }
    
}


- (void)rr_registerListener:(id <GKLocalPlayerListener>)listener {
    [self.rr_listeners addObject:listener];
    
    [[GKTurnBasedEventHandler sharedTurnBasedEventHandler] setDelegate: self];
}


- (void)rr_unregisterListener:(id <GKLocalPlayerListener>)listener {
    [self.rr_listeners removeObject:listener];
    
    if( self.rr_listeners.count == 0 ){
        [[GKTurnBasedEventHandler sharedTurnBasedEventHandler] setDelegate: nil];
    }
}


- (void)rr_unregisterAllListeners {
    [self.rr_listeners removeAllObjects];
    
    [[GKTurnBasedEventHandler sharedTurnBasedEventHandler] setDelegate: nil];
}


- (NSMutableSet *)rr_listeners {
    NSMutableSet *listeners = objc_getAssociatedObject(self, @selector(rr_listeners));
    if( !listeners ){
        listeners = [NSMutableSet set];
        objc_setAssociatedObject( self, @selector(rr_listeners), listeners, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return listeners;
}


#pragma mark -
#pragma mark GKTurnBasedEventHandlerDelegate


- (void)rr_handleInviteFromGameCenter:(NSArray *)playersToInvite {

    for( id listener in [self.rr_listeners objectEnumerator] ){
        if( [listener respondsToSelector:@selector(player:didRequestMatchWithPlayers:)] ){
            [listener player:self didRequestMatchWithPlayers:playersToInvite];
        }
    }
    
}


- (void)rr_handleTurnEventForMatch:(GKTurnBasedMatch *)match didBecomeActive:(BOOL)didBecomeActive {

    for( id listener in [self.rr_listeners objectEnumerator] ){
        if( [listener respondsToSelector:@selector(player:receivedTurnEventForMatch:didBecomeActive:)] ){
            // is player self or remote player?
            [listener player:self receivedTurnEventForMatch:match didBecomeActive:didBecomeActive];
        }
    }
    
}


- (void)rr_handleTurnEventForMatch:(GKTurnBasedMatch *)match {
    [self handleTurnEventForMatch:match didBecomeActive:NO];
}


- (void)rr_handleMatchEnded:(GKTurnBasedMatch *)match {
    
    for( id listener in [self.rr_listeners objectEnumerator] ){
        if( [listener respondsToSelector:@selector(player:matchEnded:)] ){
            [listener player:self matchEnded:match];
        }
    }
    
}


@end
#pragma clang diagnostic pop
