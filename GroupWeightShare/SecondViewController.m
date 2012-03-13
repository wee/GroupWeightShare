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
