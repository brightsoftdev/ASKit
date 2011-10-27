//
//  ASPing.m
//  ASKit
//
//  Created by Robert Tully on 26/10/2011.
//  Copyright 2011 Azurenode. All rights reserved.
//

#import "ASPing.h"

@implementation ASPing

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkPingStatus:)
                                                     name:NSTaskDidTerminateNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)pingIP:(NSString*)pingAddr { // FIXME: Provide overloads with extra arguments
    userInfo = [NSMutableDictionary dictionaryWithObject:pingAddr forKey:@"pingAddr"]; // Attach pingAddr to dictionary
    
    [self _pingIP:[NSArray arrayWithObjects:@"-c2", @"-o", pingAddr, nil]]; // Create arguments (-c2 -o pingAddr)
}

- (void)pingIPwithParams:(NSDictionary *)pingParameters {
    
    // DICT FORMAT:
    //      * pingAddr (NSString)
    //      * pingParams (NSArray)
    
    // Regenerate userInfo dictionary for later use
    userInfo = [NSMutableDictionary dictionaryWithObject:[pingParameters valueForKey:@"pingAddr"] forKey:@"pingAddr"];
    
    // Construct valid array for _pingIP
    NSMutableArray* params = [NSMutableArray arrayWithArray:[pingParameters valueForKey:@"pingParams"]];
    [params addObject:[pingParameters valueForKey:@"pingAddr"]];
    
    NSLog(@"%@",params);
    
    [self _pingIP:params];
    
}

- (void)checkPingStatus:(NSNotification *)aNotification { // FIXME: This function is unbearably horrible.
    
    int status = [[aNotification object] terminationStatus]; // Grab ping exit status
    
    if (status == 0) {
        [userInfo setValue:@"0" forKey:@"status"]; // Update userInfo with return code (as NSString (Damn you NSDictionary))
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ASPingCompleted" object:self userInfo:userInfo]; // Success
    } else {
        [userInfo setValue:@"1" forKey:@"status"]; // Update userInfo with return code (as NSString (Damn you NSDictionary))
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ASPingCompleted" object:self userInfo:userInfo]; // Failure
    }
    
}

- (void)_pingIP:(NSArray *)params {
    NSTask *ping = [[NSTask alloc] init];
    
    [ping setLaunchPath:@"/sbin/ping"]; // This path SHOULD work on all OS X versions
    [ping setArguments:params];
    [ping launch]; // Launch ping

}

@end
