//
//  ViewController.m
//  InstaKil
//
//  Created by Jaewon Kim on 2017-08-09.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"


@interface ViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *foodArray;
@property (strong, nonatomic) NSMutableArray *etcArray;
@property (strong, nonatomic) NSArray *sectionNames;
@property (weak, nonatomic) IBOutlet UISegmentedControl *foodOrEct;
@property (strong, nonatomic) NSMutableArray *homeArray;
@property (strong, nonatomic) NSMutableArray *outdoorArray;
@property (strong, nonatomic) NSArray *locationNames;
@property (nonatomic) UICollectionViewFlowLayout *groupSegment;
@property (nonatomic) UICollectionViewFlowLayout *locationSegment;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewLayout *nextLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.foodArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"IMG_1677"],[UIImage imageNamed:@"IMG_1678"], [UIImage imageNamed:@"IMG_1661"],[UIImage imageNamed:@"IMG_1628"], nil];
    
    self.etcArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"IMG_1645"], [UIImage imageNamed:@"IMG_0061"], [UIImage imageNamed:@"IMG_1637"],[UIImage imageNamed:@"IMG_1604"],[UIImage imageNamed:@"IMG_0718"],[UIImage imageNamed:@"IMG_0772"], nil];
    
    self.sectionNames = @[@"food",@"ect"];
    
    self.homeArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"IMG_1645"],[UIImage imageNamed:@"IMG_0061"],[UIImage imageNamed:@"IMG_1637"],[UIImage imageNamed:@"IMG_1604"],[UIImage imageNamed:@"IMG_1628"], nil];
    
    self.outdoorArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"IMG_1678"],[UIImage imageNamed:@"IMG_0718"],[UIImage imageNamed:@"IMG_1677"],[UIImage imageNamed:@"IMG_0772"], [UIImage imageNamed:@"IMG_1661"], nil];
    
    self.locationNames = @[@"home",@"outdoor"];
    
    

    self.groupSegment = [[UICollectionViewFlowLayout alloc] init];
    self.groupSegment.itemSize = CGSizeMake(100, 100);
    self.groupSegment.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.groupSegment.minimumInteritemSpacing = 15;
    self.groupSegment.minimumLineSpacing = 10;
    self.groupSegment.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50.0f);

//    self.groupSegment.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
    //    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.locationSegment = [[UICollectionViewFlowLayout alloc] init];
    self.locationSegment.itemSize = CGSizeMake(100, 100);
    self.locationSegment.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.locationSegment.minimumLineSpacing = 15;
    self.locationSegment.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50.0f);
    self.locationSegment.minimumInteritemSpacing = 10;
    
    self.nextLayout = self.groupSegment;
    [self.collectionView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr - gestures

- (IBAction)foodOrEct:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.nextLayout = self.groupSegment;
            break;
            
        case 1:
            self.nextLayout = self.locationSegment;
            
        default:
            break;
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    [self.collectionView setCollectionViewLayout:self.nextLayout animated:YES];
}



#pragma makr - collectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    if (self.nextLayout == self.groupSegment) {
        return self.sectionNames.count;
    } else {
        return self.locationNames.count;
    }
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.nextLayout == self.groupSegment){
        if (section == 0) {
        return self.foodArray.count;
        } else {
        return self.etcArray.count;
        }
    } else {
        if (section == 0) {
            return self.homeArray.count;
        } else {
            return self.outdoorArray.count;
        }

    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCollectionViewCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    if (self.nextLayout == self.groupSegment) {
        if (indexPath.section == 0) {
        imageCell.imageCollectionView.image = [self.foodArray objectAtIndex:indexPath.row];
        } else {
        imageCell.imageCollectionView.image = [self.etcArray objectAtIndex:indexPath.row];
        }
    } else {
        if (indexPath.section == 0) {
            imageCell.imageCollectionView.image = [self.homeArray objectAtIndex:indexPath.row];
        } else {
            imageCell.imageCollectionView.image = [self.outdoorArray objectAtIndex:indexPath.row];
        }
    }

    return imageCell;
}

#pragma mark - HeaderCollectionResuable


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        if (self.nextLayout == self.groupSegment){
            headerView.foodSection.text = [self.sectionNames objectAtIndex:indexPath.section];
        } else{
            headerView.foodSection.text = [self.locationNames objectAtIndex:indexPath.section];
        }
        return headerView;
        
    } else {
        return nil;
    }
}



@end
