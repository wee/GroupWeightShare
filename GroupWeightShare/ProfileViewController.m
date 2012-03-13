//
//  ProfileViewController.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/13/12.
//

#import "ProfileViewController.h"
#import "MainTabBarViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize maleOrFemailSegmentedControl=_maleOrFemailSegmentedControl;
@synthesize ageTextField=_ageTextField;
@synthesize shareSwitch=_shareSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *user = ((MainTabBarViewController *)self.parentViewController).user;
    if (user.isMale) {
        self.maleOrFemailSegmentedControl.selectedSegmentIndex = 0;
    } else {
        self.maleOrFemailSegmentedControl.selectedSegmentIndex = 1;
    }
    [self.maleOrFemailSegmentedControl setNeedsDisplay];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.ageTextField resignFirstResponder];
}

- (IBAction)onGenderSelected:(id)sender {
    NSLog(@"gender %d selected", self.maleOrFemailSegmentedControl.selectedSegmentIndex);
}


@end
