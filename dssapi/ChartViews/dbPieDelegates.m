//
//  dbPieDelegates.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "dbPieDelegates.h"


@implementation dbPieDelegates


- (void) initializeItems
{
    localgraph.plotAreaFrame.masksToBorder = NO;
    localgraph.paddingLeft =10.0;
    localgraph.paddingTop = 35.0;
    localgraph.paddingRight = 10.0;
    localgraph.paddingBottom = 10.0;
    localgraph.axisSet=nil;
}

- (void) generateGraphComplete:(NSDictionary*) dataInfo
{
    int loopcounter=0;
    if (dataInfo) 
    {
        dataForPlot = [[NSMutableArray alloc] initWithArray:[dataInfo valueForKey:@"data"]  copyItems:YES];
        _dataGenInProgress = NO;
    }
    totalsalesvalue=0;
    firstFiveTotal =0;
    for (NSDictionary *tmpDict in dataForPlot) {
        totalsalesvalue = totalsalesvalue +[[tmpDict valueForKey:@"TOTALSALES"] doubleValue];
        if (loopcounter < 5) {
            firstFiveTotal = firstFiveTotal + [[tmpDict valueForKey:@"TOTALSALES"] doubleValue];
        }
        loopcounter ++;
    }

    if (isSmallView==1)
        localgraph.title = @"Salesman Performance";
    else
        localgraph.title = [[NSString alloc] initWithFormat:@"%@ %@", @"Salesman Performance", [self getTitleSuffix]]; 
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor whiteColor];
    textStyle.fontName = @"Helvetica-Bold";
    //textStyle.fontSize = localgraph.bounds.size.height / 20.0f;
    if (isSmallView==1) 
    {
        textStyle.fontSize = 16.0f; 
        localgraph.titleDisplacement = CGPointMake(0.0f, 15.0f);
    }
    else
    {
        if (isFullScreenMode==YES) 
            textStyle.fontSize = 30.0f;
        else
            textStyle.fontSize = 25.0f;
        localgraph.titleDisplacement = CGPointMake(0.0f, 20.0f);
    }
    localgraph.titleTextStyle = textStyle;
    //localgraph.titleDisplacement = CGPointMake(0.0f, localgraph.bounds.size.height / 18.0f);
    localgraph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    CPTGradient *overlayGradient = [[CPTGradient alloc] init] ;
    overlayGradient.gradientType = CPTGradientTypeRadial;
	overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.0] atPosition:0.0];
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.3] atPosition:0.9];
	overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.7] atPosition:1.0];
    piePlot = [[CPTPieChart alloc] init];
    piePlot.dataSource = self;
    if (isSmallView==1) 
            piePlot.pieRadius = 115.0;
    else
        if (isFullScreenMode==YES) 
            if (UIInterfaceOrientationIsPortrait(intOrientation)) 
                piePlot.pieRadius = 325.0;
            else
                piePlot.pieRadius = 300.0;
        else
            if (UIInterfaceOrientationIsPortrait(intOrientation)) 
                piePlot.pieRadius = 200.0;
            else
                piePlot.pieRadius = 240.0;
    //NSLog(@"view type %d  nd radius is %f", isSmallView,piePlot.pieRadius );
    piePlot.identifier = @"Sales Data";
    piePlot.startAngle = 0;
    piePlot.sliceDirection = CPTPieDirectionCounterClockwise;
    piePlot.borderLineStyle = [CPTLineStyle lineStyle];
    piePlot.labelOffset = -50.0;
    piePlot.overlayFill = [CPTFill fillWithGradient:overlayGradient];
    [localgraph addPlot:piePlot];
    
    CPTLegend *theLegend = [CPTLegend legendWithGraph:localgraph];
    if (isSmallView==1) 
        theLegend.numberOfColumns = 3;
    else
        theLegend.numberOfColumns = 1;
    //theLegend.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    theLegend.fill = [CPTFill fillWithGradient:overlayGradient];
    theLegend.borderLineStyle = [CPTLineStyle lineStyle];
    theLegend.cornerRadius = 5.0;
    CPTMutableTextStyle *textStyle1 = [CPTMutableTextStyle textStyle];
    textStyle1.color = [CPTColor whiteColor];
    textStyle1.fontName = @"Helvetica-Bold";
    if (isFullScreenMode==YES) 
        textStyle1.fontSize = 13.0f;
    else
        textStyle1.fontSize = 11.0f;

    theLegend.textStyle = textStyle1;
    
    localgraph.legend = theLegend;
    
    localgraph.legendAnchor = CPTRectAnchorRight;
    if (isSmallView==1) 
        localgraph.legendDisplacement = CGPointMake(-30.0, -145.0);
    else
        if (isFullScreenMode==YES) 
            if (UIInterfaceOrientationIsPortrait(intOrientation)) 
                localgraph.legendDisplacement = CGPointMake(-30.0, 270.0);
            else
                localgraph.legendDisplacement = CGPointMake(-30.0, 160.0);
        else
            if (UIInterfaceOrientationIsPortrait(intOrientation)) 
                localgraph.legendDisplacement = CGPointMake(-30.0, 90.0);
            else
                localgraph.legendDisplacement = CGPointMake(-30.0, 140.0);
    NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
    [chartInfo setValue:_chartType forKey:@"ChartType"];
    [chartInfo setValue:localgraph forKey:@"LocalGraph"];
    [chartInfo setValue:self forKey:@"ChartDelegate"];
    //[[NSNotifxicationCenter defaultCenter] postNotixficationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
    _chartDataGenerateMethod(chartInfo);
    
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
    //NSLog(@"noof items for plot %d",[dataForPlot count]);
    if (isSmallView) 
        numOfRecs = [dataForPlot count] <= 6 ? [dataForPlot count] : 6;
    else
        numOfRecs =  [dataForPlot count];
    return numOfRecs;
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    
	static CPTMutableTextStyle *whiteText = nil;
    NSDictionary *tempdict = [dataForPlot objectAtIndex:index]; 
    NSNumber *totsales = (NSNumber*) [tempdict valueForKey:@"TOTALSALES"];
    //NSLog(@"total sales %@", totsales);
    if (isSmallView==1 & index==5) 
        totsales = [NSNumber numberWithDouble:(totalsalesvalue - firstFiveTotal)];
    double totsalesperc = [totsales doubleValue]/totalsalesvalue*100;
    NSNumberFormatter *numformatter = [[NSNumberFormatter alloc] init];
    [numformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numformatter setMaximumFractionDigits:2];
    [numformatter setMaximumIntegerDigits:2];
    [numformatter setRoundingMode:NSNumberFormatterRoundUp];
    NSString *disptext = [numformatter stringFromNumber:[NSNumber numberWithDouble:totsalesperc]];
    NSNumberFormatter *salesFormatter = [[NSNumberFormatter alloc] init];
    [salesFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [salesFormatter setCurrencySymbol:@""];
    [salesFormatter setMaximumFractionDigits:0];
    disptext = [NSString stringWithFormat:@"%@(%@%)",[salesFormatter stringFromNumber:[NSNumber numberWithInteger:[[tempdict valueForKey:@"TOTALSALES"] integerValue]]], disptext];
	if ( !whiteText ) 
	{
		whiteText = [[CPTMutableTextStyle alloc] init];
		whiteText.color = [CPTColor whiteColor];
	}
    if (isSmallView==1) 
        whiteText.fontSize=11.0f;
    else
    {
        if (isFullScreenMode==YES) 
            whiteText.fontSize=14.0f;
        else
            whiteText.fontSize = 12.0f;
    }
    CPTTextLayer *newLayer = nil;
    switch ( index ) {
        case -1:
            newLayer = (id)[NSNull null];
            break;
        default:
            newLayer = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@", disptext] style:whiteText] ;
            break;
    }
    //newLayer = [[[CPTTextLayer alloc] initWithText:disptext style:whiteText] autorelease];
    return newLayer;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    NSDecimalNumber *num = nil;
    if ( index >= [dataForPlot count] ) return nil;
    if ( fieldEnum == CPTPieChartFieldSliceWidth ) 
    {
        NSDictionary *tempdata = [dataForPlot objectAtIndex:index];
        num = [tempdata valueForKey:@"TOTALSALES"];
        if (isSmallView==1 & index==5) 
            num = [[NSDecimalNumber alloc] initWithDouble:(totalsalesvalue - firstFiveTotal)];
    }
    else 
        num =  (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
    return num;
}

-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index
{
    NSDictionary *tempdict = [dataForPlot objectAtIndex:index]; 
    NSString *smname =[[NSString alloc] initWithFormat:@"%@",[tempdict valueForKey:@"SALESMANNAME"]] ;
    if (isSmallView==1 & index==5) 
        smname = @"REST ALL";
    return smname;
}

@end
