//
//  GWViewController.h
//  iTip test
//
//  Created by iOS App Bootcamp on 8/11/14.
//  Copyright (c) 2014 Gabe Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GWViewController : UIViewController <UITextFieldDelegate, UIAccelerometerDelegate>{
    
    //float valueX;
    //float valueY;
    
}

//@property (nonatomic,strong) IBOutlet UIButton *buttonMoving;

@property int finalTipPercentage;


//-(void) awakeAccelerometer;
//-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;



@end
