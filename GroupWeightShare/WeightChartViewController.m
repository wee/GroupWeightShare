//
//  WeightChartViewController.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/16/12.
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
#import "CPTTimeFormatter.h"
#import "CPTAxisLabel.h"

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
    graph.paddingLeft   = 50.0;
    graph.paddingTop    = 40.0;
    graph.paddingRight  = 15.0;
    graph.paddingBottom = 40.0;
    
    graph.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
    graph.plotAreaFrame.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    NSTimeInterval xMin = [[self.user earliestWeightRecordDate] timeIntervalSinceReferenceDate];
    NSTimeInterval xMax = [[self.user lastWeightRecordDate] timeIntervalSinceReferenceDate];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(xMin)
                                                    length:CPTDecimalFromDouble(xMax - xMin)];
    float yMin = [[self.user minimumWeight] floatValue];
    float yMax = [[self.user maximumWeight] floatValue];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin)
                                                    length:CPTDecimalFromFloat(yMax - yMin)];
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 1.0f;
    majorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.75f];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 1.0f;
    minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.25f];

    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x=axisSet.xAxis;
    x.majorIntervalLength = [[NSDecimalNumber decimalNumberWithString:@"1"] decimalValue];
    CPTPlotRange *xAxisRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromString(@"0.0") length:CPTDecimalFromString(@"24.0")];
    x.minorTicksPerInterval = 4;
//    x.majorTickLineStyle = lineStyle;
//    x.minorTickLineStyle = lineStyle;
//    x.axisLineStyle = lineStyle;
    x.minorTickLength = 5.0f;
    x.majorTickLength = 7.0f;
    x.visibleRange=xAxisRange;
    x.orthogonalCoordinateDecimal=CPTDecimalFromString(@"0");
    x.title=@"Hours";
    x.titleOffset=47.0f;
    x.labelRotation=M_PI/4;
    x.labelingPolicy=CPTAxisLabelingPolicyNone;
    NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:3], [NSDecimalNumber numberWithInt:6], [NSDecimalNumber numberWithInt:9], [NSDecimalNumber numberWithInt:12], 
                                    [NSDecimalNumber numberWithInt:15], [NSDecimalNumber numberWithInt:18], [NSDecimalNumber numberWithInt:21], [NSDecimalNumber numberWithInt:24],nil];
    NSArray *xAxisLabels = [NSArray arrayWithObjects:@"3 AM", @"6 AM", @"9 AM", @"12PM", @"3 PM",@"6 PM",@"9 PM", @"12 AM", nil];
    NSUInteger labelLocation = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
    for (NSNumber *tickLocation in customTickLocations) 
    {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [xAxisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = M_PI/4;
        [customLabels addObject:newLabel];
    }
    x.axisLabels =  [NSSet setWithArray:customLabels];
//    CPTXYAxis *x = axisSet.xAxis;
 //   x.title = @"Date";
//    x.titleOffset = 0.0f;
//    x.titleLocation = CPTDecimalFromFloat(0.0f);
//    x.majorGridLineStyle = majorGridLineStyle;
//    x.minorGridLineStyle = minorGridLineStyle;
//    
//    x.majorIntervalLength = CPTDecimalFromInteger(10);
//    x.minorTicksPerInterval = 5;
//    x.plotSpace = plotSpace;     
//    x.labelOffset = 0.0f;
//    x.labelAlignment = CPTAlignmentLeft;
//    x.labelRotation = M_PI/4;
//    x.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
//    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.plotSpace = plotSpace;
    x.orthogonalCoordinateDecimal = CPTDecimalFromFloat(xMin);
    
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	dateFormatter.dateStyle = kCFDateFormatterShortStyle;
//	CPTTimeFormatter *timeFormatter = [[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter];
//	timeFormatter.referenceDate = [self.user earliestWeightRecordDate];
//	x.labelFormatter			= timeFormatter;
//    
    CPTXYAxis *y = axisSet.yAxis;
    y.title = @"Weight";
//    y.titleOffset = 35.0f;
//    y.majorIntervalLength = CPTDecimalFromInteger(1);
//    y.minorTicksPerInterval = 0.5;
//    y.orthogonalCoordinateDecimal = CPTDecimalFromInteger(0);
    //y.preferredNumberOfMajorTicks = 8;
    y.plotSpace = plotSpace;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
//    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelAlignment = CPTAlignmentLeft;
    
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
        return [self.user dateAsSecondsSinceReferenceDateForEntry:index];
//        return [NSNumber numberWithInteger:index];
    } else {
        return [self.user weightForEntry:index];
    }
}

@end
