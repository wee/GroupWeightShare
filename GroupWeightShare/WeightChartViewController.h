//
//  WeightChartViewController.h
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTPlot.h"
#import "User.h"

@interface WeightChartViewController : UIViewController<CPTPlotDataSource>

@property (nonatomic, strong) IBOutlet UIView *chartView;
@property (nonatomic, strong) User *user;
@end
