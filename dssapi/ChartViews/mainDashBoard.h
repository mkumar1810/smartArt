
#import <UIKit/UIKit.h>
#import "baseChart.h"
#import "dbScatterDelegates.h"
#import "dbPieDelegates.h"
#import "dbBarDelegates.h"
//#import "dbBar6MonthsDelegates.h"
#import "dbBarSalesCollectionDelegates.h"

@interface mainDashBoard : UIViewController
{
    IBOutlet UIScrollView *bottomScroll;
    IBOutlet CPTGraphHostingView *topView, *bottomLeftView, *bottomCenterView, *bottomRightView;
	CPTXYGraph *linegraph, *piechart, *barSalColnChart, *newbarchart;
    dbScatterDelegates *dbscd;
    dbPieDelegates *dbpd;
    dbBarDelegates *dbbard;
    dbBarSalesCollectionDelegates *dbBarSalColn;
    BOOL initialized; 
    IBOutlet UIActivityIndicatorView *actIndicator;
    int noofGraphsGenerated, noofReqdRefresh;
    NSMutableDictionary *plotLayOptions;
    NSString *topChart,*fullScreenChart;
    CGRect frameBeforeFullScreen;
    BOOL fullScreenMode;
    UIButton *leftButton, *rightButton;
    UIInterfaceOrientation prevOrientation, currOrientation;
    METHODCALLBACK _chartDataGenerate;
}

@property (nonatomic, retain) UIView *bottomScroll;
@property (nonatomic, retain) CPTGraphHostingView *topView, *bottomLeftView, *bottomCenterView, *bottomRightView;
@property (retain) dbScatterDelegates *dbscd;
@property (retain) dbPieDelegates *dbpd;
@property (retain) dbBarDelegates *dbbard;
@property (retain) dbBarSalesCollectionDelegates *dbBarSalColn;


//Initialize is needed as the init method is not firing from the tabbarcontroller
- (void) initialize;
- (void) ChartDataGenerated : (NSDictionary*) chartGenInfo;

//To refresh all the charts in the view controller
- (IBAction) refreshCharts : (id) sender;
- (void) setActivityIndicatorProperly;

//to put the bar charts and pie charts in a line in bottom scroll
- (void) layoutScrollImages:(UIInterfaceOrientation) intOrientation;

//refresh buttons for all the charts
- (void) createRefreshButtons;

//chart views's refresh functions
- (IBAction) refreshParticularChart:(id) sender;
- (void) reLoadChartForTag:(int) tagValue;
- (void) reLoadChartForTag:(int) tagValue withOffsetval:(int) monthOffset;

//full screen mode functions
- (IBAction) makeFullScreen:(id)sender;
- (IBAction) restoreOldMode:(id)sender;
- (void) setFSReadjustmentForOrientation:(UIInterfaceOrientation) p_toOrientation;

//chart views chart swapping functions
- (IBAction) swapParticularChartToTop:(id) sender;
- (void) swapToTopFromChart:(NSString*) fromChart;
//- (void) refreshTheSwapedViewChartType:(NSString*) chartType andViewTag:(int) viewTag andBaseChart:(baseChart*) bChart andToPos:(NSString*) toPosition;

- (CPTGraphHostingView*) getViewToHostForChart:(NSString*) chartType;
- (void) addButtonsToChart:(NSString*) chartType andTag:(int) tagValue;
- (void) removeButtonsFromChart:(NSString*) chartType;
- (void) setChartAndScrollForOrientation:(UIInterfaceOrientation) intOrientation;

// add previous and next bar buttons in to the navigation bar
- (void) addPreviousNextButtons;
- (void) setPreviousNextButtonStatuses;
- (IBAction) prevNextOffsetTopChart:(id) sender;

@end
