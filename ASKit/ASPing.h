//
//  ASPing.h
//  ASKit
//
//  Created by Robert Tully on 26/10/2011.
//  Copyright 2011 Azurenode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASPing : NSObject {
    NSMutableDictionary* userInfo; 
}

- (int)pingIP:(NSString *)pingAddr isAsynchronous:(BOOL)asynch;
- (int)pingIPwithParams:(NSDictionary *)pingParameters isAsynchronous:(BOOL)asynch;
- (void)checkPingStatus:(NSNotification *)aNotification;

- (void)_pingIP:(NSArray *)params;
- (NSTask *)_pingIP_Synch:(NSArray *)params;

@end
