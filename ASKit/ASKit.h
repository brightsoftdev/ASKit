// ======================================================= //
//                                                         //
//  ASKit.h                                                //
//  ASKit                                                  //
//                                                         //
//  Framework umbrella header                              //
//                                                         //
// ------------------------------------------------------- //
//                                                         //
//  Licensed under Creative Commons BY-NC-SA 3.0 Unported  //
//                                                         //
//  More information can be found in the LICENSE file      //
//  within the root folder of this project.                //
//                                                         //
// ======================================================= //

#ifndef ASKit_Available
#define ASKit_Available

#import "ASPing.h"

// ASNotification relies upon the presence of the 10.8 Notification Center APIs
#if MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_8
#import "ASNotification.h"
#endif

#endif
