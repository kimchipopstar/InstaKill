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
#import "FooterCollectionReusableView.h"

@interface ViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *foodArray;
@property (strong, nonatomic) NSMutableArray *etcArray;
@property (strong, nonatomic) NSArray *sectionNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.foodArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"IMG_1677"],[UIImage imageNamed:@"IMG_1678"], [UIImage imageNamed:@"IMG_1661"],[UIImage imageNamed:@"IMG_1628"], nil];
    
    self.etcArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"IMG_1645"], [UIImage imageNamed:@"IMG_0061"], [UIImage imageNamed:@"IMG_1637"],[UIImage imageNamed:@"IMG_1604"],[UIImage imageNamed:@"IMG_0718"],[UIImage imageNamed:@"IMG_0772"], nil];
    
    self.sectionNames = @[@"food",@"ect"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return self.sectionNames.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.foodArray.count;
    } else {
        return self.etcArray.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCollectionViewCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        imageCell.imageCollectionView.image = [self.foodArray objectAtIndex:indexPath.row];
    } else {
        imageCell.imageCollectionView.image = [self.etcArray objectAtIndex:indexPath.row];
    }
    
    return imageCell;

}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    


    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.foodSection.text = [self.sectionNames objectAtIndex:0];
        
        return headerView;
        
    } else {
        FooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.etcSection.text = [self.sectionNames objectAtIndex:1];
        
        return footerView;
    }

    
}



@end
