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

- (void)pingIP:(NSString *)pingAddr;
- (void)pingIPwithParams:(NSDictionary *)pingParameters;
- (void)checkPingStatus:(NSNotification *)aNotification;

- (void)_pingIP:(NSArray *)params;

@end
