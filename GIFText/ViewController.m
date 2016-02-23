//
//  ViewController.m
//  GIFTextView
//
//  Created by Eric Young on 1/20/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "ViewController.h"
#import "GIFLabel.h"
#import "GIFEditTextView.h"

@interface ViewController ()
@property (strong, nonatomic) GIFLabel *label;
@property (strong, nonatomic) GIFEditTextView *editTextView;
@property (weak, nonatomic) IBOutlet UITextField *text;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.editTextView = [[GIFEditTextView alloc] initWithFrame:CGRectMake(50, 100, 250, 100)];
    //self.editTextView.backgroundColor = [UIColor greenColor];
    //[self.view addSubview:self.editTextView];
    
   // self.editTextView.text = self.text.text;
    
    //[self.text addTarget:self
                 // action:@selector(editingChanged:)
       // forControlEvents:UIControlEventEditingChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) editingChanged:(id)sender {
    // your code
    self.editTextView.text = self.text.text;
}

- (IBAction)changedText:(id)sender
{
    self.editTextView.text = self.text.text;
}

- (IBAction)testAction:(id)sender {
    //[self.editTextView makeEditable:YES];
    //[self.editTextView changeFont:[UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:self.editTextView.currentFontSize]];
}

-(void)gifTextOptionsViewControllerDidFinishWithTextFields:(NSMutableArray *)textFields
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    for (GIFEditTextView *gv in textFields) {
        [self.view addSubview:gv];
        //CATextLayer *subtitle1Text = [[CATextLayer alloc] init];
        //[subtitle1Text setFont:CFBridgingRetain(gv.currentFont.fontName)];
        //[subtitle1Text setFont:gv.currentFont.CGFontRef];
        //[subtitle1Text setFontSize:gv.currentFontSize];
        //[subtitle1Text setFrame:gv.frame];
        //[subtitle1Text setString:gv.text];
        //[subtitle1Text setAlignmentMode:kCAAlignmentCenter];
        //subtitle1Text.wrapped = YES;
        //subtitle1Text.shadowColor = [UIColor blackColor].CGColor;
        //subtitle1Text.shadowOffset = CGSizeMake(3, 0);
        //subtitle1Text.shadowOpacity = .8;
        //subtitle1Text.borderColor = [UIColor blackColor].CGColor;
        //[subtitle1Text setForegroundColor:[[UIColor whiteColor] CGColor]];
        //[self.view.layer addSublayer:gv.layer];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[GIFTextOptionsViewController class]]) {
        GIFTextOptionsViewController *gifEdit = segue.destinationViewController;
        gifEdit.delegate = self;
    }
}
@end
