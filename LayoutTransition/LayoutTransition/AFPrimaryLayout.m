//
//  AFPrimaryLayout.m
//  LayoutTransition
//
//  Created by 何平 on 2020/5/18.
//  Copyright © 2020 cn.com.kuwo. All rights reserved.
//

#import "AFPrimaryLayout.h"

@implementation AFPrimaryLayout
-(id)init {
    self = [super init];
    if (self == nil) return nil;
    self.itemSize = CGSizeMake(120, 120);
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    return self;
}
@end
