//
//  MainViewController.m
//  DrawCrowd
//
//  Created by liujin on 15/5/4.
//  Copyright (c) 2015年 Jin Liu. All rights reserved.
//

#import "MainViewController.h"
#import "ProjectCell.h"
#import "Project.h"
#import "Network.h"
#import <MJRefresh/MJRefresh.h>
#import <iOS-Slide-Menu/SlideNavigationController.h>
#import <FMMosaicLayout/FMMosaicLayout.h>
#import <NYTPhotoViewer/NYTPhotosViewController.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface MainViewController () <SlideNavigationControllerDelegate, NYTPhotosViewControllerDelegate, FMMosaicLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *projectsArray;
@property (nonatomic) NSInteger page;
@end

@implementation MainViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _page = 1;
        _projectsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
    [self setupHeaderAndFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark private methods

- (void)setupLayout {
    FMMosaicLayout *layout = [[FMMosaicLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
}

- (void)setupHeaderAndFooter {
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.footer.automaticallyRefresh = NO;
    self.collectionView.footer.hidden = YES;
    self.collectionView.header.textColor = [UIColor whiteColor];
    self.collectionView.footer.textColor = [UIColor whiteColor];
    [self.collectionView.header beginRefreshing];
}

- (void)refresh {
    _page = 1;
    [Network getNewDiscoveriesWithPage:_page
                            completion:^(NSArray *projectsArray) {
                                if (projectsArray.count > 0) {
                                    [_projectsArray removeAllObjects];
                                    [_projectsArray addObjectsFromArray:projectsArray];
                                    _page = [self nextPage];
                                    [self.collectionView.footer resetNoMoreData];
                                    [self.collectionView reloadData];
                                } else {
                                    [self.collectionView.footer noticeNoMoreData];
                                }
                                [self.collectionView.header endRefreshing];
                            }];
}

- (void)loadMore {
    [Network getNewDiscoveriesWithPage:_page completion:^(NSArray *projectsArray) {
        if (projectsArray.count > 0) {
            [_projectsArray addObjectsFromArray:projectsArray];
            _page = [self nextPage];
            [self.collectionView reloadData];
        } else {
            [self.collectionView.footer noticeNoMoreData];
        }
        [self.collectionView.footer endRefreshing];
    }];
}

- (NSInteger)nextPage {
    return self.projectsArray.count / 24 + 1;
}

#pragma mark <SlideNavigationControllerDelegate>

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    collectionView.footer.hidden = (self.projectsArray.count == 0);
    return self.projectsArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout numberOfColumnsInSection:(NSInteger)section {
    return 2;
}

- (FMMosaicCellSize)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout mosaicCellSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.item % 8 == 0) ? FMMosaicCellSizeBig : FMMosaicCellSizeSmall;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"ProjectCell";
    ProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Project *project = _projectsArray[indexPath.row];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imageView setImageWithURL:[NSURL URLWithString:project.medium_image]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:project.large_image]
                                                                              options:8|9
                                                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {}
                                                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                                                project.image = image;
                                                                            }];
                          }
        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCell *selected = (ProjectCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!selected.imageView.image) {
        return;
    }
    Project *project = _projectsArray[indexPath.row];
    NYTPhotosViewController *photoVC = [[NYTPhotosViewController alloc] initWithPhotos:_projectsArray initialPhoto: project];
    [self presentViewController:photoVC animated:YES completion:nil];
}

# pragma mark <NYTPhotosViewControllerDelegate>
- (void)photosViewController:(NYTPhotosViewController *)photosViewController didDisplayPhoto:(id<NYTPhoto>)photo atIndex:(NSUInteger)photoIndex {
    Project *project = (Project *)photo;
    if (!project.image) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:project.large_image]
                                                        options:8|9
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {}
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                          project.image = image;
                                                          [photosViewController updateImageForPhoto:project];
                                                      }];
    }
}

- (UIView *)photosViewController:(NYTPhotosViewController *)photosViewController referenceViewForPhoto:(id<NYTPhoto>)photo {
    ProjectCell *cell = (ProjectCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[_projectsArray indexOfObject:photo] inSection:0]];
    return cell;
}

@end
