//
//  AFSecondaryViewController.m
//  LayoutTransition
//
//  Created by 何平 on 2020/5/18.
//  Copyright © 2020 cn.com.kuwo. All rights reserved.
//

#import "AFSecondaryViewController.h"

@interface AFSecondaryViewController ()

@end

static NSString *CellIdentifier = @"Cell";

@implementation AFSecondaryViewController
/*
 All method below will not get invoked, cuz useLayoutToLayoutNavigationTransitions = YES makes the delegate and data source set to PrimaryViewController's. So methods below will not work.
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 80;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
@end
