//
//  GWViewController.m
//  iTip test
//
//  Created by iOS App Bootcamp on 8/11/14.
//  Copyright (c) 2014 Gabe Walker. All rights reserved.
//

#import "GWViewController.h"

@interface GWViewController ()

{
    float currentY;
    float previousY;
    int tiltHoldCount;
}

//UI stuff

@property (weak, nonatomic) IBOutlet UISlider *simpleSlider;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField;
@property (weak, nonatomic) IBOutlet UITextField *finalTipValue;
@property (weak, nonatomic) IBOutlet UITextField *mealTextField;
@property (weak, nonatomic) IBOutlet UITextField *finalPriceText;
@property (weak, nonatomic) IBOutlet UITextField *personalityText;
@property (weak, nonatomic) IBOutlet UITextField *speedText;
@property (weak, nonatomic) IBOutlet UITextField *qualityText;
@property (weak, nonatomic) IBOutlet UITextField *helpfulnessText;
@property (weak, nonatomic) IBOutlet UISlider *pSlider;
@property (weak, nonatomic) IBOutlet UISlider *sSlider;
@property (weak, nonatomic) IBOutlet UISlider *qSlider;
@property (weak, nonatomic) IBOutlet UISlider *hSlider;
@property (weak, nonatomic) IBOutlet UITextField *gyroText;
@property (weak, nonatomic) IBOutlet UITextField *dollarsText;
@property (weak, nonatomic) IBOutlet UITextField *tiltTextValue;

//actions

- (IBAction)tipStepper:(id)sender;
- (IBAction)generateResults:(id)sender;
- (IBAction)personalitySlider:(id)sender;
- (IBAction)speedSlider:(id)sender;
- (IBAction)qualitySlider:(id)sender;
- (IBAction)helpfulnessSlider:(id)sender;
- (IBAction)startAccelerometer:(id)sender;
- (IBAction)swipeDollar:(id)sender;


//variables


@property int stepperValue;
@property float mealCost;
@property float finalPrice;
@property int personalitySlider;
@property int speedSlider;
@property int qualitySlider;
@property int helpfulnessSlider;
@property int dollarsRemaining;
@property int tiltValue;
@property bool leftFirstTilt;
@property bool rightFirstTilt;
@property bool leftTiltReturn;
@property bool rightTiltReturn;
@property bool checkTwist;
@property bool checkTwistReturn;
@property bool checkTwistStop;

@end

@implementation GWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stepperValue = 0;
    self.dollarsRemaining = 20;
    self.tiltValue = 10;
    
    self.leftFirstTilt = false;
    self.rightFirstTilt = false;
    self.checkTwist = false;
    
    self.leftTiltReturn = false;
    self.rightTiltReturn = false;
    self.checkTwistReturn = false;
    self.checkTwistStop = false;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tipStepper:(id)sender
{
    self.stepperValue = self.simpleSlider.value;
    
    self.tipTextField.text = [NSString stringWithFormat:@"%.2d%%", self.stepperValue];
    
    self.finalTipPercentage = 0;
}

- (IBAction)generateResults:(id)sender
{
    //this is used on the results screen for after the cost of your meal text box is filled
    
    self.finalTipValue.text = [NSString stringWithFormat:@"%2d%%", self.finalTipPercentage];
    
    self.finalPrice = (self.mealCost*(self.finalTipPercentage*0.01)) + self.mealCost;
    
    self.finalPriceText.text = [NSString stringWithFormat:@"%.02f", self.finalPrice];
    
}

- (IBAction)personalitySlider:(id)sender
{
    self.personalitySlider = self.pSlider.value;
    
    self.personalityText.text = [NSString stringWithFormat:@"%.2d", self.personalitySlider];

}

- (IBAction)speedSlider:(id)sender
{
    self.speedSlider = self.sSlider.value;
    
    self.speedText.text = [NSString stringWithFormat:@"%.2d", self.speedSlider];
}

- (IBAction)qualitySlider:(id)sender
{
    self.qualitySlider = self.qSlider.value;
    
    self.qualityText.text = [NSString stringWithFormat:@"%.2d", self.qualitySlider];

}

- (IBAction)helpfulnessSlider:(id)sender
{
    self.helpfulnessSlider = self.hSlider.value;
    
    self.helpfulnessText.text = [NSString stringWithFormat:@"%.2d", self.helpfulnessSlider];
    
}

//SOMETHING NOT RIGHT D:

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (IBAction)startAccelerometer:(id)sender
{
    static const NSTimeInterval gyroMin = 0.1;
    tiltHoldCount = 0;
        // Create a CMMotionManager

        // Check whether the gyroscope is available
        if ([self.motionManager isGyroAvailable] == YES) {
            NSLog(@"gyro!");
            // Assign the update interval to the motion manager
            [self.motionManager setGyroUpdateInterval:gyroMin];
            [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *gyroData, NSError *error)
            {
                //NSLog(@"HI");
                currentY = gyroData.rotationRate.y;
                self.gyroText.text = [NSString stringWithFormat:@"%.2f", currentY];
                
                float tiltThreshold = 2.5;
                float negThreshold = tiltThreshold* -1;
                
                if (!(self.checkTwist || self.checkTwistReturn || self.checkTwistStop)) {
                    if(-0.1 < currentY & currentY < 0.1) {
                        tiltHoldCount++;
                        // NSLog(@"Counter UP");
                    }
                    if(tiltHoldCount > 2){
                        self.checkTwist = true;
                        tiltHoldCount = 0;
                        NSLog(@"Counter MAX - now you can check");
                    }
                }

                
                if(self.checkTwist == true)
                {
                    if(currentY < negThreshold)
                    {
                        self.leftFirstTilt = true;
                        self.checkTwist = false;
                        self.checkTwistReturn = true;
                        NSLog(@"Twisted Left!");
                    }
                    else if(currentY > tiltThreshold)
                    {
                        self.rightFirstTilt = true;
                        self.checkTwist = false;
                        self.checkTwistReturn = true;
                        NSLog(@"Twisted Right!");
                    }
                }
                
                if(self.checkTwistReturn == true)
                {
                    if((currentY > tiltThreshold) & self.leftFirstTilt)
                    {
                        self.leftTiltReturn = true;
                        self.checkTwistReturn = false;
                        self.checkTwistStop = true;
                        NSLog(@"Returned from Left!");
                    }
                    else if((currentY < negThreshold) & self.rightFirstTilt)
                    {
                        self.rightTiltReturn = true;
                        self.checkTwistReturn = false;
                        self.checkTwistStop = true;
                        NSLog(@"Returned from Right!");
                    }
                }
                
                if(self.checkTwistStop == true )
                {
                    if(self.leftFirstTilt == true & self.leftTiltReturn == true)
                    {
                        if(-0.05 < currentY < 0.05)
                        {
                            // self.checkTwist = true;
                            self.checkTwistReturn = false;
                            self.checkTwistStop = false;
                            self.tiltValue--;
                            self.leftFirstTilt = false;
                            self.leftTiltReturn = false;
                            NSLog(@"Idle from Left");
                        }
                    }
                    
                    if(self.rightFirstTilt == true & self.rightTiltReturn == true)
                    {
                        if(-0.05 < currentY < 0.05)
                        {
                            // self.checkTwist = true;
                            self.checkTwistReturn = false;
                            self.checkTwistStop = false;
                            self.tiltValue++;
                            self.rightFirstTilt = false;
                            self.rightTiltReturn = false;
                            NSLog(@"Idle from Right");
                        }
                    }
                }
                
                if(self.tiltValue >= 20)
                {
                    self.tiltValue = 20;
                }
                if(self.tiltValue <= 0)
                {
                    self.tiltValue = 0;
                }
                
                self.tiltTextValue.text = [NSString stringWithFormat:@"%.2d", self.tiltValue];
            }];
      }
}

- (void)stopUpdates{
    //CMMotionManager *mManager = [(APLAppDelegate *)[[UIApplication sharedApplication] delegate] sharedManager];
    if ([self.motionManager isGyroActive] == YES) {
        [self.motionManager stopGyroUpdates];
    }
}

//END OF SOMETHING NOT RIGHT, MORE IN GWAppDelegate.h

- (IBAction)swipeDollar:(id)sender
{
    NSLog(@"gyro!");
    self.dollarsRemaining = self.dollarsRemaining - 1;
    self.dollarsText.text = [NSString stringWithFormat:@"Remaining : %.2d", self.dollarsRemaining];
    
    
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"simpleSegue"])
    {
        GWViewController *gwv = (GWViewController *)segue.destinationViewController;
        
        gwv.finalTipPercentage = self.stepperValue;
    }
    else if([segue.identifier isEqualToString:@"judgeSegue"])
    {
        GWViewController *gwv = (GWViewController *)segue.destinationViewController;
    
        gwv.finalTipPercentage = self.personalitySlider + self.speedSlider + self.qualitySlider + self.helpfulnessSlider;
    }
    else if([segue.identifier isEqualToString:@"tiltSegue"])
    {
        GWViewController *gwv = (GWViewController *)segue.destinationViewController;
        
        gwv.finalTipPercentage = self.tiltValue;
    
    }
    else if([segue.identifier isEqualToString:@"evilSegue"])
    {
        GWViewController *gwv = (GWViewController *)segue.destinationViewController;
        
        gwv.finalTipPercentage = self.dollarsRemaining;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.mealCost = [self.mealTextField.text floatValue];
    
    return YES;
}


@end