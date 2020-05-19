//
//  ViewController.m
//  LayoutTransition
//
//  Created by 何平 on 2020/5/18.
//  Copyright © 2020 cn.com.kuwo. All rights reserved.
//

#import "AFPrimaryViewController.h"
#import "AFSecondaryViewController.h"
#import "AFSecondaryLayout.h"

@interface AFPrimaryViewController ()

@end

static NSString *CellIdentifier = @"Cell";

@implementation AFPrimaryViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    AFSecondaryViewController *viewController = [[AFSecondaryViewController alloc] initWithCollectionViewLayout:[[AFSecondaryLayout alloc] init]];
    viewController.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
