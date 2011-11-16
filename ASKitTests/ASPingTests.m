// ==CLASS================================================ //
//                                                         //
//  ASPingTests.h                                          //
//  ASKitLogicTests                                        //
//                                                         //
//  Created by Robert Tully on 16/11/2011.                 //
//                                                         //
// --LICENSE---------------------------------------------- //
//                                                         //
//  Licensed under Creative Commons BY-NC-SA 3.0 Unported  //
//                                                         //
//  More information can be found in the LICENSE file      //
//  within the root folder of this project.                //
//                                                         //
// ======================================================= //

#import "ASPingTests.h"

@implementation ASPingTests

- (void)testLocalhostSynchronous
{
    ASPing *ping = [[ASPing new] init];
    
    NSLog(@"ASTestRig: Instance of ASPing spawned.");
    
    STAssertTrue([ping pingIP:@"127.0.0.1"
               isAsynchronous: FALSE] == 0, @"Ping returned inaccurate value (localhost)");
}

@end
