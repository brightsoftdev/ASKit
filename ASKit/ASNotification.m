// ==CLASS================================================ //
//                                                         //
//  ASNotification.m                                       //
//  ASKit                                                  //
//                                                         //
//  Created by Robert Tully on 06/07/2012.                 //
//                                                         //
// --LICENSE---------------------------------------------- //
//                                                         //
//  Licensed under Creative Commons BY-NC-SA 3.0 Unported  //
//                                                         //
//  More information can be found in the LICENSE file      //
//  within the root folder of this project.                //
//                                                         //
// ======================================================= //

#if MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_8
#import "ASNotification.h"

@implementation ASNotification

- (void)sendNotification {
    // Since this is a subclass of NSUserNotification...
    // ...we just send ourself.
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:self];
}

- (void)setAllAttributes:(NSString *)title:(NSString *)subtitle:(NSString *)info {
    self.title = title;
    self.subtitle = subtitle;
    self.informativeText = info;
}

- (void)setAndSend:(NSString *)title:(NSString *)subtitle:(NSString *)info {
    // Just chain the other two custom NSUserNotification additions together.
    [self setAllAttributes:title:subtitle:info];
    [self sendNotification];
}

@end
#endif