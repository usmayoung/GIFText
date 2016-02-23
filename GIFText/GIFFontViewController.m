//
//  GIFFontViewController.m
//  GIFTextView
//
//  Created by Eric Young on 2/1/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFFontViewController.h"
#import "GIFRemoteFont.h"
#import "GIFFontCell.h"
#import "UIFont-TTF.h"

@interface GIFFontViewController ()
{
    GIFFontCell *_sizingCell;
}
@property (nonatomic, strong) NSMutableArray *fonts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)doneSelected:(id)sender;
@end

@implementation GIFFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fonts = [NSMutableArray new];
    NSArray *fontUrls = GetAllShippedFontsFromDisk();
    for (NSURL *u in fontUrls) {
        [self.fonts addObject:[UIFont fontWithTTFAtURL:u size:20.0]];
    }
   
    
    UINib *cellNib = [UINib nibWithNibName:@"GIFFontCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"GIFFontCell"];
    
    
    _sizingCell = [[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[flowLayout setItemSize:CGSizeMake(50, 50)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //[flowLayout setEstimatedItemSize:CGSizeMake(50, 50)];
    [self.collectionView setCollectionViewLayout:flowLayout];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
    CGFloat fontSize = self.selectedTextView.currentFontSize;
    SetWebFont(@"Cabin Sketch", fontSize, @"https://fonts.gstatic.com/s/cabinsketch/v8/d9fijO34zQajqQvl3YHRCYnF5uFdDttMLvmWuJdhhgs.ttf", ^(UIFont *font) {
        [self.selectedTextView changeFont:font];
    }, ^(AFHTTPSessionManager *operation, NSError *error) {
        
    });
     */

    //[self.collectionView reloadData];
}


/*
-(void)setSelectedTextView:(GIFEditTextView *)selectedTextView
{
    [super setSelectedTextView:selectedTextView];
}
 */

-(void)wantsToEditTextView:(GIFEditTextView*)textView
{
    self.selectedTextView = textView;
    NSLog(@"text view %@", self.selectedTextView);
}

-(void)didDeleteTextView:(GIFEditTextView*)textView {}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"create cell");
    return [self.fonts count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"fonts count %lu", (unsigned long)self.fonts.count);
    NSLog(@"create cell");
    static NSString *cellIdentifier = @"GIFFontCell";
    
    GIFFontCell *cell = (GIFFontCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self _configureCell:cell forIndexPath:indexPath];
    
    return cell;
    
}

- (void)_configureCell:(GIFFontCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [self.fonts objectAtIndex:indexPath.row];
    
    [cell.label setText:font.fontName];
    
    cell.label.font = font;
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat fontSize = self.selectedTextView.currentFontSize;
    UIFont *font = [self.fonts objectAtIndex:indexPath.row];
    //[self.selectedTextView changeFont:font];
    
    SetWebFont(font.fontName, fontSize, @"", ^(UIFont *font) {
        [self.selectedTextView changeFont:font];
    }, ^(AFHTTPSessionManager *operation, NSError *error) {
        
    });
   
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self _configureCell:_sizingCell forIndexPath:indexPath];
    
    CGSize s = [_sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    s.height = 50;
    
    return s;
    //return CGSizeMake(50, 50);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneSelected:(id)sender
{
    //[self dismissViewControllerAnimated:NO completion:^{}];
    [self.delegate gifFontViewControllerDidFinishWithTextFields:self.textFields];
}
@end
