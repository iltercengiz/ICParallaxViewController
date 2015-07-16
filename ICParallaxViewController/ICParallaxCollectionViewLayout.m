//
//  ICParallaxCollectionViewLayout.m
//  ICParallaxViewController
//
//  Created by Ilter Cengiz on 16/07/15.
//  Copyright (c) 2015 Ilter Cengiz. All rights reserved.
//

#import "ICParallaxCollectionViewLayout.h"

@interface ICParallaxCollectionViewLayout ()

@property (nonatomic) CGFloat parallaxHeaderMaxY;

@end

@implementation ICParallaxCollectionViewLayout

#pragma mark - Providing layout attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    for (NSUInteger index = 0; index < attributes.count; index++) {
        UICollectionViewLayoutAttributes *layoutAttributes = attributes[index];
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell ||
            layoutAttributes.representedElementCategory == UICollectionElementCategorySupplementaryView) {
            [missingSections addIndex:(NSUInteger)layoutAttributes.indexPath.section]; // Remember that we need to layout header for this section
        }
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [attributes removeObjectAtIndex:index]; // Remove layout of header done by our super, we will do it right later
            index--;
        }
    }
    
    if (![missingSections containsIndex:0]) { // If section 0 is removed by super, add it back!
        [missingSections addIndex:0];
    }
    
    // Layout all headers needed for the rect using self code
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (layoutAttributes) {
            [attributes addObject:layoutAttributes];
        }
    }];
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionView *collectionView = self.collectionView;
        CGPoint offset = collectionView.contentOffset;
        CGRect frame = attributes.frame;
        
        if (indexPath.section == 0) { // Parallax header
            UIEdgeInsets insets = collectionView.contentInset;
            CGFloat minY = -insets.top;
            CGFloat deltaY = fabs(offset.y - minY);
            CGSize headerSize = self.headerReferenceSize;
            
            // Detect the direction
            if (offset.y < minY) { // Scrolled up / pulled down.
                frame.size.height = MAX(minY, headerSize.height + deltaY);
                frame.origin.y = frame.origin.y - deltaY;
            } else { // Scrolled down / pulled up.
                CGFloat height = MAX(minY, headerSize.height - deltaY);
                if (height < 128.0) {
                    height = 128.0;
                }
                frame.size.height = height;
                frame.origin.y = deltaY;
            }
            self.parallaxHeaderMaxY = CGRectGetMaxY(frame);
            attributes.frame = frame;
            
            attributes.zIndex = NSIntegerMax;
        } else { // Other section headers
            CGPoint nextHeaderOrigin = CGPointMake(0.0, INFINITY);
            if (indexPath.section + 1 < [collectionView numberOfSections]) {
                UICollectionViewLayoutAttributes *nextHeaderAttributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section + 1]];
                nextHeaderOrigin = nextHeaderAttributes.frame.origin;
            }
            CGFloat y = MIN(MAX(offset.y, frame.origin.y), nextHeaderOrigin.y - CGRectGetHeight(frame));
            if (y < self.parallaxHeaderMaxY) {
                y = self.parallaxHeaderMaxY;
            }
            frame.origin.y = y;
            attributes.frame = frame;
        }
    }
    
    return attributes;
}

#pragma mark - Invalidating the layout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - Configuring the scroll direction

- (UICollectionViewScrollDirection)scrollDirection {
    return UICollectionViewScrollDirectionVertical;
}

@end
