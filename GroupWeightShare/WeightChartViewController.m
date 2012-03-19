//
//  WeightChartViewController.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeightChartViewController.h"
#import "MainTabBarViewController.h"
#import "CPTGraphHostingView.h"
#import "CPTXYGraph.h"
#import "CPTScatterPlot.h"
#import "CPTXYPlotSpace.h"
#import "CPTTheme.h"
#import "CPTUtilities.h"
#import "CPTXYAxisSet.h"
#import "CPTMutableLineStyle.h"
#import "CPTColor.h"
#import "CPTXYAxis.h"
#import "CPTFill.h"
#import "CPTPlotAreaFrame.h"

@interface WeightChartViewController ()
- (void)setUpGraph;
@end

@implementation WeightChartViewController

@synthesize chartView=_chartView;
@synthesize user=_user;

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
    self.user = ((MainTabBarViewController *)self.parentViewController).user;

    [self setUpGraph];

}

- (void)setUpGraph {
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.chartView.bounds];
    hostingView.backgroundColor = [UIColor clearColor];
    [self.chartView addSubview:hostingView];
    self.chartView.backgroundColor = [UIColor whiteColor];
    self.chartView.alpha = 0.5;
    
    CPTXYGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.chartView.bounds];
    hostingView.hostedGraph = graph;
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph applyTheme:theme];
    graph.paddingLeft   = 15.0;
    graph.paddingTop    = 40.0;
    graph.paddingRight  = 15.0;
    graph.paddingBottom = 40.0;
    
    graph.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
    graph.plotAreaFrame.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
//    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble([[self.user earliestWeightRecordDate] timeIntervalSince1970])
//                                                    length:CPTDecimalFromDouble([[self.user lastWeightRecordDate] timeIntervalSince1970])];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat([[self.user minimumWeight] floatValue])
                                                    length:CPTDecimalFromFloat([[self.user maximumWeight] floatValue] - [[self.user minimumWeight] floatValue])];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 1.0f;
    majorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.75f];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 1.0f;
    minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.25f];
    
    
    CPTXYAxis *x = axisSet.xAxis;
    x.title = @"X axis";
    x.titleOffset = -20.0f;
    x.titleLocation = CPTDecimalFromFloat(30.0f);
    x.majorGridLineStyle = majorGridLineStyle;
    x.minorGridLineStyle = minorGridLineStyle;
    
    x.majorIntervalLength = CPTDecimalFromInteger(1);
    x.minorTicksPerInterval = 0.5;
    x.plotSpace = plotSpace;       
    
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength = CPTDecimalFromInteger(1);
    y.minorTicksPerInterval = 0.5;
    //y.orthogonalCoordinateDecimal = CPTDecimalFromInteger(-0.5);
    //y.preferredNumberOfMajorTicks = 8;
    y.plotSpace = plotSpace;
    
    
    [graph addPlotSpace:plotSpace];    
    
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.dataSource = self;
    
    CPTMutableLineStyle *lineStyle   = [dataSourceLinePlot.dataLineStyle mutableCopy];
    //lineStyle.miterLimit             = 1.0f;
    lineStyle.lineWidth              = 3.0f;
    lineStyle.lineColor              = [CPTColor blueColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    
    [graph addPlot:dataSourceLinePlot];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.user = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Plot Datasource
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return [self.user numberOfEntries];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    if (fieldEnum == CPTScatterPlotFieldX) {
        return [self.user dateAsSecondsSince1970ForEntry:index];
    } else {
        return [self.user weightForEntry:index];
    }
}

@end
