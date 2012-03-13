//
//  MainTabBarViewController.h
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface MainTabBarViewController : UITabBarController

@property (nonatomic, strong) User *user;
@end
