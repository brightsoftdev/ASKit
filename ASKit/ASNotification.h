// ==CLASS================================================ //
//                                                         //
//  ASNotification.h                                       //
//  ASKit                                                  //
//                                                         //
//  Created by Robert Tully on 06/07/2012.                 //
//                                                         //
// --DESCRIPTION------------------------------------------ //
//                                                         //
//  Wrapper class for sending OS X 10.8+ Notifications     //
//  with less mess.                                        //
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
#import <Foundation/Foundation.h>

@interface ASNotification : NSUserNotification

- (void)sendNotification;
- (void)setAllAttributes:(NSString *)title:(NSString *)subtitle:(NSString *)info;
- (void)setAndSend:(NSString *)title:(NSString *)subtitle:(NSString *)info;

@end
#endif