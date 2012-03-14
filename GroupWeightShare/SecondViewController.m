//
//  SecondViewController.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/12/12.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize  weightTextField=_weightTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.weightTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.1)) {
        self.weightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
	[self.weightTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.weightTextField resignFirstResponder];
}
@end
