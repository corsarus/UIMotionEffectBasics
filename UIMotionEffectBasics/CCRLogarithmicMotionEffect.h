//
//  CCRLogarithmicMotionEffect.h
//  UIMotionEffectBasics
//
//  Created by Catalin (iMac) on 09/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRLogarithmicMotionEffect : UIMotionEffect

@property (readonly, nonatomic) NSString *keyPath;
@property (readonly, nonatomic) UIInterpolatingMotionEffectType type;

@property (retain, nonatomic) id minimumRelativeValue;
@property (retain, nonatomic) id maximumRelativeValue;

- (instancetype)initWithKeyPath:(NSString *)keyPath type:(UIInterpolatingMotionEffectType)type;

@end
