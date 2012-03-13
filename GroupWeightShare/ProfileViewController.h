//
//  ProfileViewController.h
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISegmentedControl *maleOrFemailSegmentedControl;
@property (nonatomic, strong) IBOutlet UITextField *ageTextField;
@property (nonatomic, strong) IBOutlet UISwitch *shareSwitch;

- (IBAction)onGenderSelected:(id)sender;
- (IBAction)onAgeEntered:(id)sender;
@end
