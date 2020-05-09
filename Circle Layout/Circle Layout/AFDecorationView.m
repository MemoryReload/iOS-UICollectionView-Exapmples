//
//  AFDecorationView.m
//  Circle Layout
//
//  Created by Ash Furrow on 2013-01-30.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFDecorationView.h"

@implementation AFDecorationView

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    self.layer.anchorPoint = CGPointMake(0.5, 1);
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)[[UIColor clearColor] CGColor] , (id)[[UIColor blackColor] CGColor]];
    gradientLayer.backgroundColor = [[UIColor clearColor] CGColor];
    gradientLayer.frame = self.bounds;
    
    self.layer.mask = gradientLayer;
}

@end
