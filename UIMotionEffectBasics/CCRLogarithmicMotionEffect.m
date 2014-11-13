//
//  CCRLogarithmicMotionEffect.m
//  UIMotionEffectBasics
//
//  Created by Catalin (iMac) on 09/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import "CCRLogarithmicMotionEffect.h"

@interface CCRLogarithmicMotionEffect ()

@property (readwrite, nonatomic) NSString *keyPath;
@property (readwrite, nonatomic) UIInterpolatingMotionEffectType type;

@end

@implementation CCRLogarithmicMotionEffect

- (id)copyWithZone:(NSZone *)zone {
    CCRLogarithmicMotionEffect *logarithmicEffect = [super copyWithZone:zone];
    if (logarithmicEffect) {
        logarithmicEffect.minimumRelativeValue = self.minimumRelativeValue;
        logarithmicEffect.maximumRelativeValue = self.maximumRelativeValue;
        logarithmicEffect.type = self.type;
        logarithmicEffect.keyPath = self.keyPath;
    }
    return logarithmicEffect;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    // boxing the values
    NSValue *minimumValue = [NSValue valueWithBytes:(__bridge const void *)(self.minimumRelativeValue) objCType:@encode(typeof(self.minimumRelativeValue))];
    NSValue *maximumValue = [NSValue valueWithBytes:(__bridge const void *)(self.maximumRelativeValue) objCType:@encode(typeof(self.maximumRelativeValue))];
 
    [aCoder encodeObject:minimumValue forKey:@"minimumRelativeValue"];
    [aCoder encodeObject:maximumValue forKey:@"maximumRelativeValue"];
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    [aCoder encodeObject:self.keyPath forKey:@"keyPath"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) {
        return nil;
    }
    
    _minimumRelativeValue = [aDecoder decodeObjectForKey:@"minimumRelativeValue"];
    _maximumRelativeValue = [aDecoder decodeObjectForKey:@"maximumRelativeValue"];
    _type = (UIInterpolatingMotionEffectType)[[aDecoder decodeObjectForKey:@"type"] integerValue];
    _keyPath = [aDecoder decodeObjectForKey:@"keyPath"];
    
    return self;
}

- (instancetype)initWithKeyPath:(NSString *)keyPath type:(UIInterpolatingMotionEffectType)type {
    if (!(self = [super init])) {
        return nil;
    }
    
    _type = type;
    _keyPath = keyPath;
    
    return self;
}

// This class only accepts float numbers for minimum and maximum values
- (void)setMaximumRelativeValue:(id)maximumRelativeValue
{
    if ([maximumRelativeValue isKindOfClass:[NSNumber class]]) {
        _maximumRelativeValue = maximumRelativeValue;
    } else {
        NSLog(@"This class only accepts numbers for the maximumRelativeValue");
        _maximumRelativeValue = [NSNumber numberWithFloat:0.0];
    }
}

- (void)setMinimumRelativeValue:(id)minimumRelativeValue
{
    if ([minimumRelativeValue isKindOfClass:[NSNumber class]]) {
        _minimumRelativeValue = minimumRelativeValue;
    } else {
        NSLog(@"This class only accepts numbers for the maximumRelativeValue");
        _minimumRelativeValue = [NSNumber numberWithFloat:0.0];
    }
}



- (NSDictionary *)keyPathsAndRelativeValuesForViewerOffset:(UIOffset)viewerOffset {
    CGFloat motionAmplitude = 0.0;
    if (self.type == UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis) {
        motionAmplitude = viewerOffset.horizontal;
    } else {
        motionAmplitude = viewerOffset.vertical;
    }
    
    // Reduce the motion effect by dividing the amplitiude by 5
    if (motionAmplitude > 0) {
        CGFloat maximumValue = [self.maximumRelativeValue floatValue];
        return @{self.keyPath: @(maximumValue * motionAmplitude / 5.0)};
    }
    else {
        CGFloat minimumValue = [self.minimumRelativeValue floatValue];
        return @{self.keyPath: @(-minimumValue * motionAmplitude / 5.0)};
    }
}

@end
