//
//  DGHWaiterSlider.m
//  RGBX
//
//  Created by Darren Hudman on 8/14/14.
//  Copyright (c) 2014 CCT. All rights reserved.
//

#import "GWServerSlider.h"
#define DEFAULT_UI_SLIDER_HEIGHT 31

@implementation GWServerSlider

/*
 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 self.sliderImage = [UIImage imageNamed:@"server.png"];
 [self setThumbImage:self.sliderImage forState:UIControlStateNormal];
 
 // Initialization code
 }
 return self;
 }*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.sliderImage = [UIImage imageNamed:@"SERVERsmall.png"];
        [self setThumbImage:self.sliderImage forState:UIControlStateNormal];
        
        
    }
    return self;
}



/*
-(CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGRect super_rect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    
    //NSLog(@"%@", bounds);
    
    //value + trackRect.origin.x
    
    NSLog(@"val: %f", value);
    
    float transform = super_rect.origin.x + ((value-0.5) * (super_rect.size.width/2));
    
    NSLog(@"Transform: %f", transform);
    
    super_rect.origin.x = transform;
    
    NSLog(@"X: %f", super_rect.origin.x);
    
    return super_rect;
    
}
 */


@end

