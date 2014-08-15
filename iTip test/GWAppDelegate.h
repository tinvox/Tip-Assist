//
//  GWAppDelegate.h
//  iTip test
//
//  Created by iOS App Bootcamp on 8/11/14.
//  Copyright (c) 2014 Gabe Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h> //SOMETHING WRONG

@interface GWAppDelegate : UIResponder <UIApplicationDelegate>{
    
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly) CMMotionManager *motionManager;

@end
