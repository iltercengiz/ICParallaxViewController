//
//  ICParallaxViewController.m
//  ICParallaxViewController
//
//  Created by Ilter Cengiz on 16/07/15.
//  Copyright (c) 2015 Ilter Cengiz. All rights reserved.
//

#import "CollectionViewController.h"
#import "ICParallaxCollectionViewLayout.h"

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SectionHeaderView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"SectionHeaderView"];
    
    ICParallaxCollectionViewLayout *layout = (ICParallaxCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 216.0);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection view data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    return collectionViewCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 25;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *collectionViewHeader;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            collectionViewHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionViewHeader" forIndexPath:indexPath];
        } else {
            collectionViewHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeaderView" forIndexPath:indexPath];
        }
    }
    return collectionViewHeader;
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 56.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 216.0);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 56.0);
    }
}

@end
