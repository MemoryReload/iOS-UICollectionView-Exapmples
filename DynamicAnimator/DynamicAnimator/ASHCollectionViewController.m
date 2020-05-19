//
//  ViewController.m
//  DynamicAnimator
//
//  Created by 何平 on 2020/5/19.
//  Copyright © 2020 cn.com.kuwo. All rights reserved.
//

#import "ASHCollectionViewController.h"

@interface ASHCollectionViewController ()

@end

static NSString * CellIdentifier = @"CellIdentifier";

@implementation ASHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UICollectionView Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView
numberOfItemsInSection:(NSInteger)section
{
    return 120;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

@end
