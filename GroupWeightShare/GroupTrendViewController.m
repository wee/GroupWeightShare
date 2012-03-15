//
//  FirstViewController.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/12/12.
//

#import "GroupTrendViewController.h"

@interface GroupTrendViewController ()
@property (nonatomic, strong) UIActionSheet *actionSheet;
- (UISegmentedControl *)createCloseButtonSegmentedControl;
- (UISegmentedControl *)createWeightUnitButtonSegmentedControl;
- (UIActionSheet *)createEnterWeightActionSheet;
@end

@implementation GroupTrendViewController
@synthesize actionSheet=_actionSheet;

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction)onEnterWeightButton:(id)sender {
    if (self.actionSheet == nil) {
        self.actionSheet = [self createEnterWeightActionSheet];
    }    
    [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [self.actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)dismissActionSheet:(id)sender {
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - Weight Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == (NSInteger)3) {
        return 1;
    }
    return 10;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* label = (UILabel*)view;
    if (view == nil){
        label= [[UILabel alloc] initWithFrame:CGRectZero];
        label.opaque = NO;
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:22];
    }
    if (component == (NSInteger)3) {
        label.text = @".";
    } else {
        label.text = [NSString stringWithFormat:@"%d", row];
    }
    return label;
}

#pragma mark - Action Sheet Buttons
- (UISegmentedControl *)createCloseButtonSegmentedControl {
    UISegmentedControl *closeSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeSegmentedControl.momentary = YES; 
    closeSegmentedControl.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    closeSegmentedControl.tintColor = [UIColor blackColor];
    [closeSegmentedControl addTarget:self 
                              action:@selector(dismissActionSheet:) 
                    forControlEvents:UIControlEventValueChanged];
    return closeSegmentedControl;
}

- (UISegmentedControl *)createWeightUnitButtonSegmentedControl {
    NSArray *itemArray = [NSArray arrayWithObjects: @"lbs", @"kgs", nil];
    UISegmentedControl *weightUnitSegmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    weightUnitSegmentedControl.frame = CGRectMake(10, 7, 100, 30);
    weightUnitSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    weightUnitSegmentedControl.tintColor = [UIColor blackColor];
    weightUnitSegmentedControl.selectedSegmentIndex = 1;
    return weightUnitSegmentedControl;
}

- (UIActionSheet *)createEnterWeightActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    [actionSheet addSubview:[self createCloseButtonSegmentedControl]];
    [actionSheet addSubview:[self createWeightUnitButtonSegmentedControl]];
    return actionSheet;
}
@end
