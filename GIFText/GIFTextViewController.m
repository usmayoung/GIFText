//
//  GIFTextViewController.m
//  GIFTextView
//
//  Created by Eric Young on 1/29/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFTextViewController.h"
#import "GIFTextOptionsViewController.h"
@interface GIFTextViewController ()

@property (strong, nonatomic) UITextField *textField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVerticalSpacerConstraint;
@end

@implementation GIFTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.editTextView = [[GIFEditTextView alloc] initWithFrame:CGRectMake(50, 100, 250, 100)];
    //self.editTextView.backgroundColor = [UIColor greenColor];
    //[self.view addSubview:self.editTextView];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectZero];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:textView];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textView
                              attribute:NSLayoutAttributeLeft
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeLeft
                              multiplier:1.0
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:textView
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeRight
                              multiplier:1.0
                              constant:0.0]];
    
    self.bottomVerticalSpacerConstraint = [NSLayoutConstraint
                                           constraintWithItem:textView
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.view
                                           attribute:NSLayoutAttributeBottom
                                           multiplier:1.0
                                           constant:0.0];
    
    [self.view addConstraint:self.bottomVerticalSpacerConstraint];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:textView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:40.0]];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.textField setBorderStyle:UITextBorderStyleBezel];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [textView addSubview:self.textField];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textField
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:textView
                             attribute:NSLayoutAttributeLeft
                             multiplier:1.0
                             constant:8.0]];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textField
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:textView
                             attribute:NSLayoutAttributeTop
                             multiplier:1.0
                             constant:5.0]];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.textField
                             attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationEqual
                             toItem:textView
                             attribute:NSLayoutAttributeBottom
                             multiplier:1.0
                             constant:-5.0]];
    
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    doneButton.backgroundColor = [UIColor greenColor];
    [doneButton addTarget:self action:@selector(doneSelected:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [textView addSubview:doneButton];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:doneButton
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:textView
                             attribute:NSLayoutAttributeTop
                             multiplier:1.0
                             constant:5.0]];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:doneButton
                             attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationEqual
                             toItem:textView
                             attribute:NSLayoutAttributeBottom
                             multiplier:1.0
                             constant:-5.0]];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:doneButton
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:textView
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:-10.0]];
    
    [textView addConstraint:[NSLayoutConstraint
                             constraintWithItem:doneButton
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.textField
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:0.0]];
    
    [textView addConstraint:[NSLayoutConstraint constraintWithItem:doneButton
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0
                                                          constant:70.0]];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:self.view.window];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.textField.text = self.selectedTextView.text;
    [self.textField addTarget:self
                       action:@selector(editingChanged:)
             forControlEvents:UIControlEventEditingChanged];
    [self.textField becomeFirstResponder];
}

-(void)setSelectedTextView:(GIFEditTextView *)selectedTextView
{
    [super setSelectedTextView:selectedTextView];
    self.textField.text = selectedTextView.text;
}

-(void)doneSelected:(id)sender
{
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GIFTextOptionsViewController *viewController = (GIFTextOptionsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GIFTextOptionsViewController"];
    viewController.textFields = self.textFields;
    [self.navigationController pushViewController:viewController animated:NO];
     */
    NSMutableArray *validText = [NSMutableArray new];
    for (GIFEditTextView *g in self.textFields) {
        if ([g.text length] > 0) {
            [validText addObject:g];
        } else {
            [g removeFromSuperview];
        }
    }
    self.textFields = nil;
    self.textFields = validText;
    [self.delegate gifTextViewControllerDidFinishWithTextFields:self.textFields];

}

-(void) editingChanged:(id)sender {
    self.selectedTextView.text = self.textField.text;
}

-(void)wantsToEditTextView:(GIFEditTextView*)textView
{
    self.selectedTextView = textView;
}

-(void)didDeleteTextView:(GIFEditTextView*)textView
{
    
}

-(void)keyboardWillChangeFrame:(NSNotification*)notification
{
    NSLog(@"keyboard change");
    NSDictionary * userInfo = notification.userInfo;
    UIViewAnimationCurve animationCurve  = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // convert the keyboard's CGRect from screen coords to view coords
    CGRect kbEndFrame = [self.view convertRect:[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]
                                      fromView:self.view.window];
    CGRect kbBeginFrame = [self.view convertRect:[[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue]
                                        fromView:self.view.window];
    CGFloat deltaKeyBoardOrigin = kbEndFrame.origin.y - kbBeginFrame.origin.y;
    
    // update the constant factor of the constraint governing your tracking view
    NSLog(@"keyboard change %f", deltaKeyBoardOrigin);
    self.bottomVerticalSpacerConstraint.constant = deltaKeyBoardOrigin;
    // tell the constraint solver it needs to re-solve other constraints.
    [self.view setNeedsUpdateConstraints];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
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

@end
