//
//  AFCollectionHeaderView.m
//  ContextualizingContent
//
//  Created by 何平 on 2020/3/31.
//  Copyright © 2020 何平. All rights reserved.
//

#import "AFCollectionHeaderView.h"

@implementation AFCollectionHeaderView
{
    UILabel *textLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        textLabel = [[UILabel alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)), 30, 10)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont boldSystemFontOfSize:20];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:textLabel];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setText:@""];
}

-(void)setText:(NSString *)text
{
    _text = text;
    [textLabel setText:text];
}
@end
