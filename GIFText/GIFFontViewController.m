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

#import "TagCell.h"

//#import "GIFTagFlowLayout.h"


@interface GIFFontViewController ()
{
}
@property (nonatomic, strong) NSMutableArray *fonts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet GIFTagLayout *flowLayout;
@property (strong, nonatomic) TagCell *sizingCell;
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
   
    
    UINib *cellNib = [UINib nibWithNibName:@"TagCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"tagCell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.sizingCell = [[cellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    //self.flowLayout.numberOfRows = 4;
    self.flowLayout.delegate = self;
    
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
    static NSString *cellIdentifier = @"tagCell";
    
    TagCell *cell = (TagCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self _configureCell:cell forIndexPath:indexPath];
    
    return cell;
    
}

- (void)_configureCell:(TagCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [self.fonts objectAtIndex:indexPath.row];
    
    [cell.label setText:font.fontName];
    cell.label.font = font;
    cell.layer.cornerRadius = 4;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
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

-(CGFloat)collectionView:(UICollectionView *)collectionView widthForTagAtIndexPath:(NSIndexPath *)index withHeight:(CGFloat)height
{
    [self _configureCell:self.sizingCell forIndexPath:index];
    CGSize s = [self.sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return s.width;
}


/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self _configureCell:self.sizingCell forIndexPath:indexPath];
    CGSize s = [self.sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    s.height = 50;
    return s;
}
 */



/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self _configureCell:_sizingCell forIndexPath:indexPath];
    
    CGSize s = [_sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    s.height = 50;
    
    return s;
    //return CGSizeMake(50, 50);
}
 */

/*
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
 */

/*
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
 */

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2,2,2,2);
}
 */

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
