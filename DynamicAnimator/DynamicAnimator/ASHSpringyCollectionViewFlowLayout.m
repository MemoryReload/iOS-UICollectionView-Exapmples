//
//  ASHSpringyCollectionViewFlowLayout.m
//  DynamicAnimator
//
//  Created by 何平 on 2020/5/19.
//  Copyright © 2020 cn.com.kuwo. All rights reserved.
//

#import "ASHSpringyCollectionViewFlowLayout.h"

@interface ASHSpringyCollectionViewFlowLayout ()
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, assign) CGSize oldCotentSize;
@end

@implementation ASHSpringyCollectionViewFlowLayout
-(instancetype)init
{
    if (!(self = [super init])) return nil;
    [self commonInit];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    if (!(self = [super init])) return nil;
    [self commonInit];
    return self;
}

-(void)commonInit
{
    self.oldCotentSize = CGSizeZero;
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(80, 80);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
}

-(void)prepareLayout
{
    [super prepareLayout];
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0.0f, 0.0f, self.collectionViewContentSize.width, self.collectionViewContentSize.height)];
    if (!CGSizeEqualToSize(self.oldCotentSize, self.collectionViewContentSize)) {
        //do clear stuff
        [self.dynamicAnimator removeAllBehaviors];
        //then rebuilt from original flow layout attributes.
        [items enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx,
                                            BOOL *stop) {
            UICollectionViewLayoutAttributes* attrs = [obj copy];
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc]
                                               initWithItem:attrs attachedToAnchor:[attrs center]];
            behaviour.length = 0.0f;
            behaviour.damping = 0.8f;
            behaviour.frequency = 1.0f;
            [self.dynamicAnimator addBehavior:behaviour];
        }];
    }
    //we record the contentSize, cuz we use it to decide wheather we should update the dynamicAnimator.
    self.oldCotentSize = self.collectionViewContentSize;
}



-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.dynamicAnimator itemsInRect:rect];
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = sqrt(pow(yDistanceFromTouch, 2)+pow(xDistanceFromTouch, 2))/500;
//        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 300.0f;
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes*)springBehaviour.items.firstObject;
        CGPoint center = item.center;
//        if (delta < 0) {
//            center.y += MAX(delta, delta*scrollResistance);
//            center.y += delta*scrollResistance;
//        }
//        else {
//            center.y += MIN(delta, delta*scrollResistance);
//        }
        center.y += delta*scrollResistance;
        item.center = center;
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }];
    return NO;
}
@end
