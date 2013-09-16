//
//  GKLocalPlayer.h
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

#import <GameKit/GameKit.h>


#ifndef __IPHONE_7_0

@protocol GKInviteEventListener
@optional

- (void)player:(GKPlayer *)player didAcceptInvite:(GKInvite *)invite;
- (void)player:(GKPlayer *)player didRequestMatchWithPlayers:(NSArray *)playerIDsToInvite;

@end

@protocol GKTurnBasedEventListener
@optional

- (void)player:(GKPlayer *)player didRequestMatchWithPlayers:(NSArray *)playerIDsToInvite;
- (void)player:(GKPlayer *)player receivedTurnEventForMatch:(GKTurnBasedMatch *)match didBecomeActive:(BOOL)didBecomeActive;
- (void)player:(GKPlayer *)player matchEnded:(GKTurnBasedMatch *)match;

@end

@protocol GKLocalPlayerListener <GKInviteEventListener, GKTurnBasedEventListener>
@end

#endif


@interface GKLocalPlayer (RRiOS7Backport)

#ifndef __IPHONE_7_0

- (void)registerListener:(id <GKLocalPlayerListener>)listener;

- (void)unregisterListener:(id <GKLocalPlayerListener>)listener;

- (void)unregisterAllListeners;

#endif

@end
