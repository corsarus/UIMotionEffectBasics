//
//  ViewController.m
//  UIMotionEffectBasics
//
//  Created by Catalin (iMac) on 08/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import "ViewController.h"
#import "CCRLogarithmicMotionEffect.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIView *movingView;

@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    UIInterpolatingMotionEffect *shiftingEffect = [self verticalShiftingEffect];
//    UIInterpolatingMotionEffect *skewingEffect = [self skewingEffect];
//    
//    UIMotionEffectGroup *effectGroup = [[UIMotionEffectGroup alloc] init];
//    effectGroup.motionEffects = @[shiftingEffect, skewingEffect];
//    
//    [self.movingView addMotionEffect:effectGroup];
    
    CCRLogarithmicMotionEffect *verticalLogarithmicShiftingEffect = [self verticalLogarithmicShiftingEffect];
    [self.movingView addMotionEffect:verticalLogarithmicShiftingEffect];
}

- (UIInterpolatingMotionEffect *)verticalShiftingEffect
{
    // Motion effect that shifts the view up and down
    UIInterpolatingMotionEffect *verticalIterpolatingEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    // Initialize boundaries with boxed values
    verticalIterpolatingEffect.minimumRelativeValue = @(-100.0);
    verticalIterpolatingEffect.maximumRelativeValue = @(100.0);
    
    return verticalIterpolatingEffect;
}

- (UIInterpolatingMotionEffect *)skewingEffect
{
    // Motion effect that adds perspective to the view
    UIInterpolatingMotionEffect *perspectiveIterpolatingEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.transform" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    // CATransform3D value for minimumRelativeValue
    CATransform3D tranformMinimumRelativeValue = CATransform3DIdentity;
    tranformMinimumRelativeValue.m34 = 1.0 / 200;
    tranformMinimumRelativeValue = CATransform3DRotate(tranformMinimumRelativeValue, M_PI_4, 1, 0, 0);

    // CATransform3D value for minimumRelativeValue
    CATransform3D tranformMaximumRelativeValue = CATransform3DIdentity;
    tranformMaximumRelativeValue.m34 = 1.0 / 200;
    tranformMaximumRelativeValue = CATransform3DRotate(tranformMaximumRelativeValue, -M_PI_4, 1, 0, 0);
    
    // Set the transform property boundaries for the interpolation
    perspectiveIterpolatingEffect.minimumRelativeValue = [NSValue valueWithCATransform3D:tranformMinimumRelativeValue];
    perspectiveIterpolatingEffect.maximumRelativeValue = [NSValue valueWithCATransform3D:tranformMaximumRelativeValue];
    
    return perspectiveIterpolatingEffect;
}


- (CCRLogarithmicMotionEffect *)verticalLogarithmicShiftingEffect {
    // Motion effect that shifts the view up and down
    CCRLogarithmicMotionEffect *verticalLogarithmicEffect = [[CCRLogarithmicMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    // Initialize boundaries with boxed values
    verticalLogarithmicEffect.minimumRelativeValue = @(-100.0);
    verticalLogarithmicEffect.maximumRelativeValue = @(100.0);
    
    return verticalLogarithmicEffect;
}

@end
