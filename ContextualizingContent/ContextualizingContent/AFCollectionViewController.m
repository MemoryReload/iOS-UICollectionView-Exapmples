//
//  AFCollectionViewController.m
//  ContextualizingContent
//
//  Created by HePing on 2020/3/29.
//  Copyright © 2020 何平. All rights reserved.
//

#import "AFCollectionViewController.h"
#import "AFCollectionHeaderView.h"
#import "AFPhotoModel.h"

@interface AFCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray* selectionModelArray;
@property (nonatomic,assign) NSUInteger currentModelArrayInex;
@end

@implementation AFCollectionViewController
@synthesize selectionModelArray = selectionModelArray;
@synthesize currentModelArrayInex = currentModelArrayInex;

static NSString * const CellIdentifier = @"Cell";
static NSString * const HeaderIdentifier = @"Header";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    // Register Header class
    [self.collectionView registerClass:[AFCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    AFCollectionHeaderView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
    if (indexPath.section ==0) {
        //If this is the first header, display a prompt to the user
        [headerView setText:@"Tap on a photo to start the recommendation engine."];
    }
    else if (indexPath.section <= currentModelArrayInex){
        //Otherwise, display a prompt using the selected photo from the previous section
        AFSelectionModel* selectionModel = selectionModelArray[indexPath.section -1];
        AFPhotoModel* selectedPhotoModel = [self photoModelForIndexPath:[NSIndexPath indexPathForItem:selectionModel.selectedPhotoModelIndex inSection:indexPath.section -1]];
        [headerView setText:[NSString stringWithFormat:@"Because you liked %@ ...",selectedPhotoModel.name]];
    }
    return headerView;
}
#pragma mark  tools
-(AFPhotoModel*)photoModelForIndexPath:(NSIndexPath*)indexPath
{
    //FIXME: Add the actual implementation.
    return nil;
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
