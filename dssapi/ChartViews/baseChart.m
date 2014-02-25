//
//  baseChart.m
//  dssapi
//
//  Created by Raja T S Sekhar on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "baseChart.h"

@implementation baseChart

- (void) makeFullScreenModewithOrientation:(UIInterfaceOrientation) passIntOrientation
{
    isSmallView = 0;
    isFullScreenMode = YES;
    intOrientation = passIntOrientation;
    [localgraph.axisSet removeFromSuperlayer];
    [localgraph.legend removeFromSuperlayer];
    [localgraph removeFromSuperlayer];
    //[localgraph release];
    localgraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];        
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [localgraph applyTheme:theme];
    [self initializeItems];
    [self generateGraphComplete:nil];
    NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
    [chartInfo setValue:_chartType forKey:@"ChartType"];
    [chartInfo setValue:localgraph forKey:@"LocalGraph"];
    [chartInfo setValue:self forKey:@"ChartDelegate"];
    //[[NSNotificatxionCenter defaultCenter] postNotificxationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
    _chartDataGenerateMethod(chartInfo);
}

- (void) swapChartToView:(CPTGraphHostingView*) newHostView andViewPosition: (NSString*) viewPos withOrientation:(UIInterfaceOrientation) passIntOrientation
{
    isSmallView = ([viewPos isEqualToString:@"T"]) ? 0 : 1;
    isFullScreenMode = NO;
    intOrientation = passIntOrientation;
    if (_dataGenInProgress==NO) 
    {
        [localgraph.axisSet removeFromSuperlayer];
        [localgraph.legend removeFromSuperlayer];
        [localgraph removeFromSuperlayer];
        //[localgraph release];
        localgraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];        
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        [localgraph applyTheme:theme];
        [self initializeItems];
        [self generateGraphComplete:nil];
        newHostView.hostedGraph = localgraph;
        NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
        [chartInfo setValue:_chartType forKey:@"ChartType"];
        [chartInfo setValue:localgraph forKey:@"LocalGraph"];
        [chartInfo setValue:self forKey:@"ChartDelegate"];
        //[[NSNotifixcationCenter defaultCenter] postNotixficationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
        _chartDataGenerateMethod(chartInfo);
    }
    else
    {
        NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
        [chartInfo setValue:_chartType forKey:@"ChartType"];
        [chartInfo setValue:nil forKey:@"LocalGraph"];
        [chartInfo setValue:self forKey:@"ChartDelegate"];
        //[[NSNotificxxationCenter defaultCenter] postNotifixxcationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
        _chartDataGenerateMethod(chartInfo);
    }
    _viewPosition = [[NSString alloc] initWithString:viewPos];
}

- (void) reDrawGraphsFornewView:(CPTGraphHostingView*) holderView
{
    if (_dataGenInProgress==NO) 
    {
        localgraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];        
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        [localgraph applyTheme:theme];
        [self initializeItems];
        [self generateGraphComplete:nil];
    }
}

-(void) generateData
{
    if ([_chartType isEqualToString:@"BARSC"]==YES) 
    {
        NSString *monthOffsetStr = [[NSString alloc] initWithFormat:@"%d", _monthOffset];
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        forDate = [NSDate date];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[nsdf stringFromDate:forDate], @"p_fordate",monthOffsetStr,@"p_monthoffset", nil];
        [[dssWSCallsProxy alloc] initWithReportType:_chartType andInputParams:inputDict andReturnMethod:_proxyReturnMethod];
        return;
    }
    if ([_chartType isEqualToString:@"BAR"]==YES) 
    {
        NSString *monthOffsetStr = [[NSString alloc] initWithFormat:@"%d", _monthOffset];
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        forDate = [NSDate date];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[nsdf stringFromDate:forDate], @"p_fordate",monthOffsetStr,@"p_monthoffset", nil];
        [[dssWSCallsProxy alloc] initWithReportType:_chartType andInputParams:inputDict andReturnMethod:_proxyReturnMethod];
        return;
    }
    if ([_chartType isEqualToString:@"PIE"]==YES) 
    {
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        NSString *monthOffsetStr = [[NSString alloc] initWithFormat:@"%d", _monthOffset];
        mtdsalesfordate = [NSDate date];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[nsdf stringFromDate:mtdsalesfordate], @"p_fordate",monthOffsetStr,@"p_monthoffset", nil];
        [[dssWSCallsProxy alloc] initWithReportType:_chartType andInputParams:inputDict andReturnMethod:_proxyReturnMethod];
        return;
    }
    if ([_chartType isEqualToString:@"LC"]==YES) 
    {
        _monthOffset = -1;
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        NSTimeInterval secondsforNdays = - NO_OF_DAYS_FOR_LINECHART * 24 * 60 * 60;
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        businvenddate = [NSDate date];
        businvstartdate = [businvenddate dateByAddingTimeInterval:secondsforNdays];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[nsdf stringFromDate:businvstartdate], @"p_startdate",[nsdf stringFromDate:businvenddate],@"p_enddate", nil];
        [[dssWSCallsProxy alloc] initWithReportType:_chartType andInputParams:inputDict andReturnMethod:_proxyReturnMethod];
        return;
    }
}

- (id) initWithGraphObject:(CPTXYGraph*) graph andViewPOS:(NSString*) viewPosition andMonthOffset:(int) monthOffset andChart:(NSString*) typeChart withOrientation:(UIInterfaceOrientation) passIntOrientation andDataGenerateMethod:(METHODCALLBACK) p_generateMethod
{
    self = [super init];
    isFullScreenMode = NO;
    if (self) {
        _dataGenInProgress = YES;
        _monthOffset = monthOffset;
        _viewPosition = [[NSString alloc] initWithString:viewPosition];
        __block id myself = self;
        _proxyReturnMethod = ^(NSDictionary* p_dictInfo)
        {
            [myself generateGraphComplete:p_dictInfo];
        };
        _chartDataGenerateMethod = p_generateMethod;
        intOrientation = passIntOrientation;
        //[[NSNotificationCenter defaultCenter] removeOxbserver:self];
        graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];        
        dataForPlot = [[NSMutableArray alloc] init];        
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        if ([viewPosition isEqualToString:@"T"] | [viewPosition isEqualToString:@"F"]) 
            isSmallView = 0;
        else
            isSmallView = 1;
        isFullScreenMode = ([viewPosition isEqualToString:@"F"]) ? YES : NO;
        _chartType = [[NSString alloc] initWithString:typeChart];
        [graph applyTheme:theme];
        localgraph = graph;
        [self initializeItems];
        [self generateData];
    }
    return self;
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

-(void) dealloc
{
    //[[NSNotificationCenter defaultCenter] removexObserver:self];
    [localgraph removeFromSuperlayer];
    //[super dealloc];
}

- (BOOL) enablePreviousButton
{
    BOOL retVal = NO;
    switch (_monthOffset) {
        case -1:
            retVal = NO;
            break;
        case 0:
            retVal = YES;
            break;
        default:
            retVal = YES;
            break;
    }
    return retVal;
}

- (BOOL) enableNextButton
{
    BOOL retVal = NO;
    switch (_monthOffset) {
        case -1:
            retVal = NO;
            break;
        case 0:
            retVal = NO;
            break;
        default:
            retVal = YES;
            break;
    }
    return retVal;
}

- (int) getCurrentOffset
{
    return  _monthOffset;
}

- (NSString*) getTitleSuffix
{
    NSString *retval = [[NSString alloc] init];
    if (isSmallView==1) {
        retval = @"";
    }
    else
    {
        if (_monthOffset==0) 
        {
            retval = @"";
        }
        else
        {
            NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
            NSTimeInterval secondsforNdays = - 24 * 60 * 60;
            [nsdf setDateFormat:@"d-MMM-yyyy"];
            NSDate *l_fordate = [NSDate date];
            // for pie charts take one day before for others current date
            if ([_chartType isEqualToString:@"PIE"]) 
            {
                l_fordate = [l_fordate dateByAddingTimeInterval:secondsforNdays];
            }
            [nsdf setDateFormat:@"yyyyMM"];
            NSInteger curMonthYearValue = [[nsdf stringFromDate:l_fordate] integerValue];
            [nsdf setDateFormat:@"MM"];
            NSInteger curMonthValue = [[nsdf stringFromDate:l_fordate] integerValue];
            NSInteger subyear = _monthOffset / 12;
            NSInteger submonths = _monthOffset - subyear*12;
            if (submonths>= curMonthValue) 
            {
                curMonthYearValue = curMonthYearValue - 100 +12;
            }
            NSInteger prevMonthValue = curMonthYearValue - subyear*100 - submonths;
            [nsdf setDateFormat:@"yyyyMMd"];
            NSString *prevMonthStr = [[NSString alloc] initWithFormat:@"%d%d", prevMonthValue, 1];
            NSDate *prevMonthDate = [nsdf dateFromString:prevMonthStr];
            [nsdf setDateFormat:@"(MMMM,YYYY)"];
            retval = [nsdf stringFromDate:prevMonthDate];
        }
    }
    return  retval;
}

- (BOOL) allowGraphRemoval
{
    if (_dataGenInProgress==YES)
        return NO;
    else
        return YES;
    
}

@end
