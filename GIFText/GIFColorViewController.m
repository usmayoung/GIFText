//
//  GIFColorViewController.m
//  GIFTextView
//
//  Created by Eric Young on 2/10/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFColorViewController.h"
#import "Colours.h"
#import "GIFColorCell.h"

@interface GIFColorViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colors;
@end

@implementation GIFColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINib *cellNib = [UINib nibWithNibName:@"GIFColorCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"GIFColorCell"];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(50, 50)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //[flowLayout setEstimatedItemSize:CGSizeMake(50, 50)];
    [self.collectionView setCollectionViewLayout:flowLayout];
    // Do any additional setup after loading the view.
    self.colors = @[@"infoBlue",
                    @"success",
                    @"warning",
                    @"danger",
                    @"antiqueWhite",
                    @"oldLace",
                    @"ivory",
                    @"seashell",
                    @"ghostWhite",
                    @"snow",
                    @"linen",
                    @"black25Percent",
                    @"black50Percent",
                    @"black75Percent",
                    @"warmGray",
                    @"coolGray",
                    @"charcoal",
                    @"teal",
                    @"steelBlue",
                    @"robinEgg",
                    @"pastelBlue",
                    @"turquoise",
                    @"skyBlue",
                    @"indigo",
                    @"denim",
                    @"blueberry",
                    @"cornflower",
                    @"babyBlue",
                    @"midnightBlue",
                    @"fadedBlue",
                    @"iceberg",
                    @"wave",
                    @"emerald",
                    @"grass",
                    @"pastelGreen",
                    @"seafoam",
                    @"paleGreen",
                    @"cactusGreen",
                    @"chartreuse",
                    @"hollyGreen",
                    @"olive",
                    @"oliveDrab",
                    @"moneyGreen",
                    @"honeydew",
                    @"lime",
                    @"cardTable",
                    @"salmon",
                    @"brickRed",
                    @"easterPink",
                    @"grapefruit",
                    @"pink",
                    @"indianRed",
                    @"strawberry",
                    @"coral",
                    @"maroon",
                    @"watermelon",
                    @"tomato",
                    @"pinkLipstick",
                    @"paleRose",
                    @"crimson",
                    @"eggplant",
                    @"pastelPurple",
                    @"palePurple",
                    @"coolPurple",
                    @"violet",
                    @"plum",
                    @"lavender",
                    @"raspberry",
                    @"fuschia",
                    @"grape",
                    @"periwinkle",
                    @"orchid",
                    @"goldenrod",
                    @"yellowGreen",
                    @"banana",
                    @"mustard",
                    @"buttermilk",
                    @"gold",
                    @"cream",
                    @"lightCream",
                    @"wheat",
                    @"beige",
                    @"peach",
                    @"burntOrange",
                    @"pastelOrange",
                    @"cantaloupe",
                    @"carrot",
                    @"mandarin",
                    @"chiliPowder",
                    @"burntSienna",
                    @"chocolate",
                    @"coffee",
                    @"cinnamon",
                    @"almond",
                    @"eggshell",
                    @"sand",
                    @"mud",
                    @"sienna",
                    @"dust"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.colors count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"GIFColorCell";
    
    GIFColorCell *cell = (GIFColorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self _configureCell:cell forIndexPath:indexPath];
    
    return cell;
    
}

- (void)_configureCell:(GIFColorCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    UIColor *colorName = [self.colors objectAtIndex:indexPath.row];
    
    // The class constructor for the relevant UIColor is <color name>Color
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Color", colorName]);
    
    if ([[UIColor class] respondsToSelector:selector]) {
        
        // Suppress perform selector leak compiler warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        UIColor *cellColor = (UIColor *)[[UIColor class] performSelector:selector];
#pragma diagnostic pop
        
        cell.backgroundColor = cellColor;
    }
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *colorName = [self.colors objectAtIndex:indexPath.row];
    
    // The class constructor for the relevant UIColor is <color name>Color
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Color", colorName]);
    
    if ([[UIColor class] respondsToSelector:selector]) {
        
        // Suppress perform selector leak compiler warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        UIColor *cellColor = (UIColor *)[[UIColor class] performSelector:selector];
#pragma diagnostic pop
        
        [self.selectedTextView changeColor:cellColor];
    }
    
    
   
   
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2,2,2,2);
}

-(void)wantsToEditTextView:(GIFEditTextView*)textView
{
    self.selectedTextView = textView;
    NSLog(@"text view %@", self.selectedTextView);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
