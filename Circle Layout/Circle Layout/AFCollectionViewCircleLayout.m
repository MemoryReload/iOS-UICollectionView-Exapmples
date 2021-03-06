//
//  AFCollectionViewCircleLayout.m
//  Circle Layout
//
//  Created by Ash Furrow on 2013-01-30.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewCircleLayout.h"
#import "AFDecorationView.h"

#define kItemDimension   70.0f

static NSString *AFCollectionViewFlowDecoration = @"DecorationView";

@interface AFCollectionViewCircleLayout ()

@property (nonatomic, strong) NSMutableSet *insertedRowSet;
@property (nonatomic, strong) NSMutableSet *deletedRowSet;

@end

@implementation AFCollectionViewCircleLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.insertedRowSet = [NSMutableSet set];
    self.deletedRowSet = [NSMutableSet set];
    
    [self registerClass:[AFDecorationView class] forDecorationViewOfKind:AFCollectionViewFlowDecoration];
    
    return self;
}

-(void)setCenter:(CGPoint)center
{
    if (CGPointEqualToPoint(_center, center)) return;
    _center = center;
    [self invalidateLayout];
}

-(void)setRadius:(CGFloat)radius
{
    if (_radius == radius) return;
    _radius = radius;
    [self invalidateLayout];
}
#pragma mark - Overridden Methods

-(void)prepareLayout
{
    [super prepareLayout];
    self.cellCount = [[self collectionView] numberOfItemsInSection:0];
}

-(CGSize)collectionViewContentSize
{
    CGRect bounds = [[self collectionView] bounds];
    return bounds.size;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    attributes.size = CGSizeMake(kItemDimension, kItemDimension);
    /*
     * As the zero angle is along the X axis, and the positive direction of angle is clockwise
     */
    attributes.center = CGPointMake(self.center.x + self.radius * cosf(2 * path.item * M_PI / self.cellCount - M_PI_2), self.center.y + self.radius * sinf(2 * path.item * M_PI / self.cellCount - M_PI_2));
    attributes.transform3D = CATransform3DMakeRotation((2 * M_PI * path.item / self.cellCount), 0, 0, 1);
    
    return attributes;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    
    for (NSInteger i = 0 ; i < self.cellCount; i++)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    if (CGRectContainsPoint(rect, self.center))
    {
        [attributes addObject:[self layoutAttributesForDecorationViewOfKind:AFCollectionViewFlowDecoration atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    }
    
    return attributes;
}

-(void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger idx, BOOL *stop) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertedRowSet addObject:@(updateItem.indexPathAfterUpdate.item)];
        }
        else if (updateItem.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deletedRowSet addObject:@(updateItem.indexPathBeforeUpdate.item)];
        }
    }];
}

-(void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    
    [self.insertedRowSet removeAllObjects];
    [self.deletedRowSet removeAllObjects];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertedRowSet containsObject:@(itemIndexPath.item)])
    {
        attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        attributes.alpha = 0.0;
        attributes.center = self.center;
        return attributes;
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // The documentation says that this returns nil. It is lying.
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deletedRowSet containsObject:@(itemIndexPath.item)])
    {
        attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        attributes.alpha = 0.0;
        attributes.center = self.center;
        /*
         There is a little bit tricky here. As the data source for this cell has been removed, the self.cellCount has been decreased. But the UI hasn't been updated yet. So, don't try to simply scale down the attributes with factor 0.1, because the rotation is wrong caculated. Thus we should recaculate the rotation radius with self.cellCount+1.
         */
        attributes.transform3D = CATransform3DConcat(CATransform3DMakeRotation((2 * M_PI * itemIndexPath.item / (self.cellCount + 1)), 0, 0, 1), CATransform3DMakeScale(0.1, 0.1, 1.0));
        //code below are identical to above line.
//        attributes.transform3D = CATransform3DScale(CATransform3DMakeRotation((2 * M_PI * itemIndexPath.item / (self.cellCount + 1)), 0, 0, 1), 0.1, 0.1, 0.1);
//        attributes.transform3D = CATransform3DRotate(CATransform3DMakeScale(0.1, 0.1, 0.1), (2 * M_PI * itemIndexPath.item / (self.cellCount + 1)), 0, 0, 1);
//        return attributes;
    }
    
    return attributes;
}

#pragma mark Decoration View Layout

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];

    if ([decorationViewKind isEqualToString:AFCollectionViewFlowDecoration])
    {
        CGFloat rotationAngle = 0.0f;
        
        if ([self.collectionView.delegate conformsToProtocol:@protocol(AFCollectionViewDelegateCircleLayout) ])
        {
            rotationAngle = [(id<AFCollectionViewDelegateCircleLayout>)self.collectionView.delegate rotationAngleForSupplmentaryViewInCircleLayout:self];
        }
        
        layoutAttributes.size = CGSizeMake(20, 200);
        layoutAttributes.center = self.center;
        layoutAttributes.transform3D = CATransform3DMakeRotation(rotationAngle, 0, 0, 1);
        // Place the decoration view behind all the cells
        layoutAttributes.zIndex = -1;
    }
    
    return layoutAttributes;
}


@end

#undef kItemDimension
