//
//  dbBarDelegates.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "dbBarDelegates.h"

@implementation dbBarDelegates

- (void) initializeItems
{
    localgraph.plotAreaFrame.masksToBorder = NO;
    localgraph.paddingLeft = 70.0;
    localgraph.paddingTop = 35.0;
    localgraph.paddingRight = 20.0;
    localgraph.paddingBottom = 80.0;   
}

- (void) generateGraphComplete:(NSDictionary*) dataInfo
{
    if (dataInfo) 
    {
        dataForPlot = [[NSMutableArray alloc] initWithArray:[dataInfo valueForKey:@"data"]  copyItems:YES];
        _dataGenInProgress = NO;
    }
    //NSLog(@"received data is %@", dataForPlot);
    long maxPurchase = [[dataForPlot valueForKeyPath:@"@max.PURCHASES"] longLongValue];
    long maxSales = [[dataForPlot valueForKeyPath:@"@max.SALES"] longLongValue];
    maxAll = (maxPurchase > maxSales ? maxPurchase : maxSales);
    onePoint = maxAll / 16;
    maxAll = onePoint * 20;
    /*if (_dataGenInProgress==YES) return;
    if (_chartGenInProgress==YES) return;
    _chartGenInProgress = YES;*/
    localgraph.title = @"Purchases Vs Sales";
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor whiteColor];
    textStyle.fontName = @"Helvetica-Bold";
    if (isSmallView==1) 
    {
        textStyle.fontSize = 16.0f; 
        localgraph.titleDisplacement = CGPointMake(0.0f, 15.0f);
    }
    else
    {
        textStyle.fontSize = 25.0f;
        localgraph.titleDisplacement = CGPointMake(0.0f, 20.0f);
    }
    localgraph.titleTextStyle = textStyle;
    localgraph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    if (isSmallView==1) noOfBars = 12; else noOfBars = 36;

    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)localgraph.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(maxAll)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromInt(noOfBars)];

    CPTMutableLineStyle *commonlinestyle = [CPTMutableLineStyle lineStyle]; 
    [commonlinestyle setLineWidth:0.2]; 
    [commonlinestyle setLineColor:[CPTColor whiteColor]];
    
    /*if (_regenerateFlag==NO) 
    {*/
    // Axes
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)localgraph.axisSet;

        CPTXYAxis *x = [self generateCustomLabelTicksForXAxis:axisSet]; //   axisSet.xAxis;
        x.majorGridLineStyle = commonlinestyle;    
        
        CPTXYAxis *y = [self generateCustomLabelTicksForYAxis:axisSet]; //   axisSet.yAxis;
        y.majorGridLineStyle = commonlinestyle; 

        NSMutableArray *newAxes = [localgraph.axisSet.axes mutableCopy];
        [newAxes addObject:[self generateAddtionalXAxisForDataLabel:axisSet]];
        localgraph.axisSet.axes = newAxes;
        //[newAxes release];
        
        [localgraph addPlot:[self getPurchaseBarPlot] toPlotSpace:plotSpace];
        
        [localgraph addPlot:[self getSalesBarPlot] toPlotSpace:plotSpace];
    
        localgraph.legend = [CPTLegend legendWithGraph:localgraph];
        localgraph.legend.numberOfColumns = 2;
        localgraph.legend.textStyle = x.titleTextStyle;
        localgraph.legend.fill = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
        localgraph.legend.borderLineStyle = x.axisLineStyle;
        localgraph.legend.cornerRadius = 5.0;
        localgraph.legend.swatchSize = CGSizeMake(25.0, 25.0);
        localgraph.legendAnchor = CPTRectAnchorTopRight;
        localgraph.legendDisplacement = CGPointMake(-20.0, -35.0);  
        NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
        [chartInfo setValue:_chartType forKey:@"ChartType"];
        [chartInfo setValue:localgraph forKey:@"LocalGraph"];
        [chartInfo setValue:self forKey:@"ChartDelegate"];
        //[[NSNotifxicationCenter defaultCenter] postNotifxicationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
    _chartDataGenerateMethod(chartInfo);
    //}
    //_chartGenInProgress = NO;
    //_regenerateFlag = NO;
}

- (CPTXYAxis*) generateAddtionalXAxisForDataLabel : (CPTXYAxisSet*) mainAxis
{
    CPTXYAxis *newAxis = [[CPTXYAxis alloc] init] ;
    customDataLabelXAxis = [NSMutableArray arrayWithCapacity:10];
    customDataLabelXTicks = [NSMutableArray arrayWithCapacity:10];
    newAxis.coordinate = CPTCoordinateX;
    newAxis.majorIntervalLength = CPTDecimalFromString(@"3");
    newAxis.tickDirection = CPTSignPositive;
    newAxis.plotSpace = mainAxis.xAxis.plotSpace;
    newAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    for (int i=0; i<noOfBars ;i++) 
	{
        int dividedvalue = i / 3;
        int remindervalue = i - dividedvalue*3;
        int indexShift = noOfBars / 3;
        NSString *disptext;
        NSDictionary *datadict = [dataForPlot objectAtIndex:([dataForPlot count] - indexShift + dividedvalue)];
        disptext = [[NSString alloc] initWithString:@""];
        if (remindervalue!=0) 
        {
             [customDataLabelXTicks addObject:[NSNumber numberWithInt:i]];
             NSDecimalNumber *num = nil;    
             if (remindervalue==1)
                 num = [datadict valueForKey:@"PURCHASES"];   
             else
                 num = [datadict valueForKey:@"SALES"];    
            NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
            [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
            [frm setCurrencySymbol:@""];
            [frm setMaximumFractionDigits:0];
            //NSString *formatted = [frm stringFromNumber:[NSNumber numberWithInt:100000]];
            disptext = [frm stringFromNumber:[NSNumber numberWithInteger:[num integerValue]]];
            
             //disptext = [[NSString alloc] initWithFormat:@"%d",[num integerValue]];
             CPTAxisLabel *newDataLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:mainAxis.xAxis.labelTextStyle];
            newDataLabel.tickLocation = [[NSNumber numberWithInt:i] decimalValue]; //    [[[NSString alloc] initWithFormat:@"%d",i] decimalValue];
             newDataLabel.offset = -newAxis.labelOffset;  // - xAxis.majorTickLength;
             newDataLabel.alignment =  (CPTAlignment)  CPTTextAlignmentLeft;
             newDataLabel.rotation = M_PI_2;
             [customDataLabelXAxis addObject:newDataLabel];
             //[newDataLabel release];
        }
	}
	newAxis.axisLabels =  [NSSet setWithArray:customDataLabelXAxis];
    newAxis.majorTickLocations = [NSSet setWithArray:customDataLabelXTicks];
    return newAxis;
}


- (CPTBarPlot*) getPurchaseBarPlot
{
    CPTBarPlot *purchasePlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor cyanColor] horizontalBars:NO];
    purchasePlot.baseValue = CPTDecimalFromString(@"0");
    purchasePlot.dataSource = self;
    purchasePlot.barOffset = CPTDecimalFromFloat(0.5f);
    purchasePlot.barWidth = CPTDecimalFromFloat(1.0f);
    purchasePlot.identifier = @"Purchase";
    return purchasePlot;
}

- (CPTBarPlot*) getSalesBarPlot
{
    CPTBarPlot *salesPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    //salesPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    salesPlot.dataSource = self;
    salesPlot.baseValue = CPTDecimalFromString(@"0");
    salesPlot.barOffset = CPTDecimalFromFloat(0.5f);
    salesPlot.barWidth = CPTDecimalFromFloat(1.0f);
    salesPlot.barCornerRadius = 2.0f;
    salesPlot.identifier = @"Sales";
    return salesPlot;
}


- (CPTXYAxis*) generateCustomLabelTicksForXAxis: (CPTXYAxisSet*) mainAxis
{
    CPTXYAxis *xAxis = mainAxis.xAxis;
    customXLabels = [NSMutableArray arrayWithCapacity:10];
    customXTicks = [NSMutableArray arrayWithCapacity:10];
    xAxis.majorIntervalLength = CPTDecimalFromString(@"3");
    xAxis.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    xAxis.title = @"Month & Year";
    xAxis.titleLocation = CPTDecimalFromFloat(7.5f);
	xAxis.titleOffset = 55.0f;
    xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    for (int i=0; i<noOfBars ;i++) 
	{
        int dividedvalue = i / 3;
        int remindervalue = i - dividedvalue*3;
        int indexShift = noOfBars / 3;
        NSString *disptext;
        NSDictionary *datadict = [dataForPlot objectAtIndex:([dataForPlot count] - indexShift + dividedvalue)];
        NSString *monthname = [[datadict valueForKey:@"MONTHS"] substringToIndex:3];
        NSString *yearcode = [[datadict valueForKey:@"YEARCODE"] substringFromIndex:2];
        disptext = [[NSString alloc] initWithString:@""];
        //[customXTicks addObject:[NSNumber numberWithInt:i]];
        if (remindervalue==2) 
        {
            [customXTicks addObject:[NSNumber numberWithInt:i]];
            disptext = [[NSString alloc] initWithFormat:@"%@,%@", monthname, yearcode];
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:xAxis.labelTextStyle];
            newLabel.tickLocation =[[NSNumber numberWithInt:i] decimalValue]; // [[[NSString alloc] initWithFormat:@"%d",i] decimalValue];
            newLabel.offset = xAxis.labelOffset + xAxis.majorTickLength;
            newLabel.rotation = M_PI_4;
            [customXLabels addObject:newLabel];
            //[newLabel release];
        }
	}
	xAxis.axisLabels =  [NSSet setWithArray:customXLabels];
    xAxis.majorTickLocations = [NSSet setWithArray:customXTicks];
    return xAxis;
}

- (CPTXYAxis*) generateCustomLabelTicksForYAxis: (CPTXYAxisSet*) mainAxis
{
    CPTXYAxis *yAxis = mainAxis.yAxis;
    customYLabels = [NSMutableArray arrayWithCapacity:20];
    customYTicks = [NSMutableArray arrayWithCapacity:20];
    yAxis.majorIntervalLength = CPTDecimalFromDouble(onePoint);
    yAxis.minorTicksPerInterval = onePoint;
    yAxis.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0) ; // - 10 * onePoint);
    yAxis.title = @"     In Dirhams";
    yAxis.titleLocation = CPTDecimalFromFloat(150.0f);
	yAxis.titleOffset = 40.0f;
    yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	yAxis.axisLabels =  [NSSet setWithArray:customYLabels];
    yAxis.majorTickLocations = [NSSet setWithArray:customYTicks];
	
    for (int i=0; i< 10 ;i++) 
	{
        long dispvalue = onePoint * 2 * i;
        NSString *disptext = dispvalue<=0 ? @"" : [[NSString alloc] initWithFormat:@"%ld", dispvalue];
        if (dispvalue > 0) [customYTicks addObject:[NSNumber numberWithLong:dispvalue]];
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:yAxis.labelTextStyle];
		newLabel.tickLocation = [[NSNumber numberWithLong:dispvalue] decimalValue]; // [[[NSString alloc] initWithFormat:@"%ld",dispvalue] decimalValue];
		newLabel.rotation = 0;
        newLabel.offset = 1.0f;
        [customYTicks addObject:[NSNumber numberWithInt:2*i]];
		[customYLabels addObject:newLabel];
		//[newLabel release];
	}
	yAxis.axisLabels =  [NSSet setWithArray:customYLabels];
    yAxis.majorTickLocations = [NSSet setWithArray:customYTicks];
    return yAxis;
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
    //NSLog(@"no of records 10 returned");
    return noOfBars;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    if (index>=noOfBars) return nil;
    NSDecimalNumber *num = nil;
    int indexval = [[NSNumber numberWithUnsignedInteger:index] integerValue];
    int dividedvalue = indexval / 3;
    int remindervalue = indexval - dividedvalue*3;
    int indexShift = noOfBars / 3;
    NSDictionary *tempdata = [dataForPlot objectAtIndex:([dataForPlot count] - indexShift + dividedvalue )];
    switch ( fieldEnum ) 
    {
        case CPTBarPlotFieldBarLocation:
            num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
            break;
        case CPTBarPlotFieldBarTip:
            if (plot.identifier==@"Purchase" && remindervalue==1) 
                num = [tempdata valueForKey:@"PURCHASES"];    
            if (plot.identifier==@"Sales" && remindervalue==2) 
                num = [tempdata valueForKey:@"SALES"];            
            break;
    }
    //NSLog(@"plot identifier %@ generated is %d and index is %d and reminder %d and divided value is %d ", plot.identifier, [num integerValue], indexval, remindervalue, dividedvalue);
    return num;
}

/*

- (CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
	static CPTMutableTextStyle *whiteText = nil;
	if ( !whiteText ) 
	{
		whiteText = [[CPTMutableTextStyle alloc] init];
		whiteText.color = [CPTColor whiteColor];
        whiteText.fontSize=18;
	}
	CPTTextLayer *newLayer = nil;
    if ( [plot isKindOfClass:[CPTBarPlot class]]) 
	{
        NSNumber *labelVal = [self numberForPlot:plot field:CPTBarPlotFieldBarTip recordIndex:index];
		newLayer = [[[CPTTextLayer alloc] initWithText:[labelVal stringValue] style:whiteText] autorelease];
        
        
	}
    return newLayer;
}
*/
@end
