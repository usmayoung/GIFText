//
//  GIFBaseViewController.m
//  GIFTextView
//
//  Created by Eric Young on 1/30/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFBaseViewController.h"
#import "GIFEditTextView.h"

@interface GIFBaseViewController ()

@end

@implementation GIFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    [[self navigationItem] setLeftBarButtonItem:item];
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear --> %li", self.textFields.count);
    for (GIFEditTextView *g in self.textFields) {
        if (g.isSelected) {
            self.selectedTextView = g;
        }
        g.delegate = self;
        [self.view addSubview:g];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GIFBaseViewController *base = segue.sourceViewController;
    GIFBaseViewController *gifController = segue.destinationViewController;
    gifController.textFields = base.textFields;
    gifController.view.backgroundColor = [UIColor clearColor];
    [base setModalPresentationStyle:UIModalPresentationOverCurrentContext];
}

-(void)setSelectedTextView:(GIFEditTextView *)selectedTextView
{
    [self unselectAllTextFeilds];
    _selectedTextView = selectedTextView;
    [_selectedTextView makeEditable:YES animated:NO];
}

-(void)unselectAllTextFeilds
{
    for (GIFEditTextView *g in self.textFields) {
        [g makeEditable:NO animated:NO];
    }
}

-(void)wantsToEditTextView:(GIFEditTextView*)textView
{
}
-(void)didDeleteTextView:(GIFEditTextView*)textView
{
}


@end
