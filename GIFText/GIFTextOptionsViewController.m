//
//  GIFTextOptionsViewController.m
//  GIFTextView
//
//  Created by Eric Young on 1/30/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFTextOptionsViewController.h"

@interface GIFTextOptionsViewController ()
- (IBAction)addTextSelected:(id)sender;
- (IBAction)changeFontSelected:(id)sender;
- (IBAction)changeColorSelected:(id)sender;

@end

@implementation GIFTextOptionsViewController

+(void)gifTextFields:(NSArray *)textFeilds withDelegate:(id)delegate
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GIFTextMain" bundle:nil];
    GIFTextOptionsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"GIFTextOptionsViewController"];
    vc.delegate = delegate;
    vc.textFields = [textFeilds mutableCopy];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor clearColor];
    vc.view.backgroundColor = [UIColor clearColor];
    [nav setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [delegate presentViewController:nav animated:NO completion:^{}];
    //vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //[self presentViewController:vc animated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style: UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    [[self navigationItem] setRightBarButtonItem:item];
    
    // Do any additional setup after loading the view.
    if (self.textFields.count == 0) {
        self.selectedTextView = [[GIFEditTextView alloc] initWithFrame:CGRectMake(50, 100, 250, 70)];
        self.textFields = [NSMutableArray new];
        [self.textFields addObject:self.selectedTextView];
        //self.editTextView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.selectedTextView];
        
        [self performSegueWithIdentifier:@"GIFTextViewController" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectedTextView:(GIFEditTextView *)selectedTextView
{
    [super setSelectedTextView:selectedTextView];
}

-(void)wantsToEditTextView:(GIFEditTextView*)textView
{
    self.selectedTextView = textView;
    [self performSegueWithIdentifier:@"GIFTextViewController" sender:self];
}

-(void)didDeleteTextView:(GIFEditTextView*)textView {}


-(void)gifTextViewControllerDidFinishWithTextFields:(NSMutableArray *)textFields
{
    self.textFields = textFields;
    //[self dismissViewControllerAnimated:NO completion:^{}];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)gifFontViewControllerDidFinishWithTextFields:(NSMutableArray *)textFields
{
    [self dismissViewControllerAnimated:NO completion:^{}];
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[GIFTextViewController class]]) {
       GIFTextViewController *gifController = segue.destinationViewController;
        gifController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[GIFFontViewController class]]) {
        GIFFontViewController *gifController = segue.destinationViewController;
        gifController.delegate = self;
    }
    
    [super prepareForSegue:segue sender:sender];
     
}

- (IBAction)addTextSelected:(id)sender
{
    [self addTextView];
    [self performSegueWithIdentifier:@"GIFTextViewController" sender:self];
}

- (IBAction)changeFontSelected:(id)sender
{
    [self performSegueWithIdentifier:@"GIFFontViewController" sender:self];
}

- (IBAction)changeColorSelected:(id)sender
{
    [self performSegueWithIdentifier:@"GIFColorViewController" sender:self];
}

-(void)addTextView
{
    GIFEditTextView *tv = [[GIFEditTextView alloc] initWithFrame:CGRectMake(50, 200, 250, 70)];
    self.selectedTextView = tv;
    [self.textFields addObject:self.selectedTextView];
    [self.view addSubview:self.selectedTextView];
}

-(void)doneButtonPressed
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self.selectedTextView makeEditable:NO animated:NO];
        [self.delegate gifTextOptionsViewControllerDidFinishWithTextFields:self.textFields];
    }];
    
}
@end
