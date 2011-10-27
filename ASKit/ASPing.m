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

- (int)pingIP:(NSString *)pingAddr isAsynchronous:(BOOL)asynch {
    userInfo = [NSMutableDictionary dictionaryWithObject:pingAddr forKey:@"pingAddr"]; // Attach pingAddr to dictionary
    
    NSArray *params = [NSArray arrayWithObjects:@"-c2", @"-o", pingAddr, nil]; // Construct paramaters array
    
    if (asynch == FALSE) { // Run task synchronously and return ping exit state
        NSTask *ping = [self _pingIP_Synch:params];
        return [ping terminationStatus];
    } else { // Run task asynchronously and return success (launched ping)
        [self _pingIP:params];
        return 0;
    }
}

- (int)pingIPwithParams:(NSDictionary *)pingParameters isAsynchronous:(BOOL)asynch {
    
    // DICT FORMAT:
    //      * pingAddr (NSString)
    //      * pingParams (NSArray)
    
    // Regenerate userInfo dictionary for later use
    userInfo = [NSMutableDictionary dictionaryWithObject:[pingParameters valueForKey:@"pingAddr"] forKey:@"pingAddr"];
    
    // Construct valid array for _pingIP
    NSMutableArray* params = [NSMutableArray arrayWithArray:[pingParameters valueForKey:@"pingParams"]];
    [params addObject:[pingParameters valueForKey:@"pingAddr"]];
    
    NSLog(@"%@",params);
    
    if (asynch == TRUE) {
        [self _pingIP:params];
        return 0;
    } else {
        NSTask *ping = [self _pingIP_Synch:params];
        return [ping terminationStatus];
    }
    
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

- (NSTask *)_pingIP_Synch:(NSArray *)params {
    
    NSTask *ping = [[NSTask alloc] init];
    
    [ping setLaunchPath:@"/sbin/ping"]; // This path SHOULD work on all OS X versions
    [ping setArguments:params];
    [ping launch]; // Launch ping
    [ping waitUntilExit]; // This makes it synchronous!
    
    return ping; // Since it's done via Synch calls, we'll return the task to the caller
}

@end
