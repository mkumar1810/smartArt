//
//  dbScatterDelegates.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "dbScatterDelegates.h"

@implementation dbScatterDelegates


- (void) initializeItems
{
    localgraph.paddingLeft = 10.0;
    localgraph.paddingTop = 40.0;
    localgraph.paddingRight = 10.0;
    localgraph.paddingBottom = 10.0;
    localgraph.plotAreaFrame.paddingLeft = 60.0;
    localgraph.plotAreaFrame.paddingRight = 10.0;
    noOfYSections = isSmallView ? 9 : 18;
}

- (void) generateGraphComplete:(NSDictionary*) dataInfo
{
    if (dataInfo) 
    {
        dataCache = [[NSMutableArray alloc] initWithArray:[dataInfo valueForKey:@"data"]  copyItems:YES];
        _dataGenInProgress = NO;
    }
    long maxBusY , minBusY, maxInvY, minInvY, maxColnY, minColnY;
    if (dataForPlot) {
        [dataForPlot removeAllObjects];
        //[dataForPlot release];
    }
    if (isSmallView==0)
    {
        localgraph.title = @"Business/Invoice/Collection Indicators";
        if (localgraph.bounds.size.width < 600) localgraph.title = @"Buss/inv/Coln Indicators";
        //dataForPlot = [[NSMutableArray alloc] initWithArray:dataCache copyItems:YES];
        dataForPlot = [[NSMutableArray alloc] init];
        for (int i=0; i<[dataCache count]; i++) 
        {
            NSDictionary *tmpdict = [dataCache objectAtIndex:i];
            /*[tmpdict setValue:[NSNumber numberWithInteger:[[tmpdict valueForKey:@"INVOICE"] integerValue]]  forKey:@"INVOICE"];
            [tmpdict setValue:[NSNumber numberWithInteger:[[tmpdict valueForKey:@"BUSINESS"] integerValue]]  forKey:@"BUSINESS"];
            [tmpdict setValue:[NSNumber numberWithInteger:[[tmpdict valueForKey:@"COLLECTION"] integerValue]]  forKey:@"COLLECTION"];*/
            [dataForPlot addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[tmpdict valueForKey:@"FORDATE"], @"FORDATE", [tmpdict valueForKey:@"DOW"],@"DOW",[NSNumber numberWithInteger:[[tmpdict valueForKey:@"INVOICE"] integerValue]] , @"INVOICE",[NSNumber numberWithInteger:[[tmpdict valueForKey:@"BUSINESS"] integerValue]],@"BUSINESS", [NSNumber numberWithInteger:[[tmpdict valueForKey:@"COLLECTION"] integerValue]],@"COLLECTION" , nil]];
        }
    }
    else
    {
        localgraph.title = @"Bus/Inv/Coln";
        dataForPlot = [[NSMutableArray alloc] init];
        for (int i=[dataCache count] -10; i<[dataCache count]; i++) 
        {
            NSDictionary *tmpdict = [dataCache objectAtIndex:i];
            /*[tmpdict setValue:[NSNumber numberWithInteger:[[tmpdict valueForKey:@"INVOICE"] integerValue]]  forKey:@"INVOICE"];
             [tmpdict setValue:[NSNumber numberWithInteger:[[tmpdict valueForKey:@"BUSINESS"] integerValue]]  forKey:@"BUSINESS"];
             [tmpdict setValue:[NSNumber numberWithInteger:[[tmpdict valueForKey:@"COLLECTION"] integerValue]]  forKey:@"COLLECTION"];*/
            [dataForPlot addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[tmpdict valueForKey:@"FORDATE"], @"FORDATE", [tmpdict valueForKey:@"DOW"],@"DOW",[NSNumber numberWithInteger:[[tmpdict valueForKey:@"INVOICE"] integerValue]] , @"INVOICE",[NSNumber numberWithInteger:[[tmpdict valueForKey:@"BUSINESS"] integerValue]],@"BUSINESS", [NSNumber numberWithInteger:[[tmpdict valueForKey:@"COLLECTION"] integerValue]],@"COLLECTION" , nil]];
        }
    }
    

    //NSLog(@"the generated data is %@", dataForPlot);
    maxBusY = 0; // [[dataForPlot valueForKeyPath:@"@max.BUSINESS"] longValue];
    minBusY = 0; //[[dataForPlot valueForKeyPath:@"@min.BUSINESS"] longValue];
    maxInvY = [[dataForPlot valueForKeyPath:@"@max.INVOICE"] integerValue];
    minInvY = [[dataForPlot valueForKeyPath:@"@min.INVOICE"] integerValue];
    maxColnY = [[dataForPlot valueForKeyPath:@"@max.COLLECTION"] integerValue];
    minColnY = [[dataForPlot valueForKeyPath:@"@min.COLLECTION"] integerValue];
    maxY = maxBusY > maxInvY ? maxBusY : maxInvY;
    maxY = maxY > maxColnY ? maxY : maxColnY;
    //minY = minBusY < minInvY ? minBusY : minInvY;
    minY = minInvY < minColnY ? minInvY : minColnY;
    onePoint = (maxY - minY)  / 70;
    long dividedvalue = onePoint/ 1000;
    long remindervalue = onePoint - dividedvalue*1000;
    if (remindervalue!=0) 
        onePoint = (dividedvalue+1)*1000;
    yAxisStart = minY - 15 * onePoint ;
    yAxisLength = 100 * onePoint;
    //NSLog(@"the max y value is %ld and min y value is %ld AND ONE POINT IS %ld", maxY, minY, onePoint);
    

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
        textStyle.fontSize = 25.0f;
        localgraph.titleDisplacement = CGPointMake(0.0f, 20.0f);
    }
    localgraph.titleTextStyle = textStyle;
    //localgraph.titleDisplacement = CGPointMake(0.0f, localgraph.bounds.size.height / 18.0f);
    localgraph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)localgraph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    //plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) length:CPTDecimalFromFloat(NO_OF_DAYS_FOR_LINECHART+1)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat([dataForPlot count]-(noOfYSections-1)) length:CPTDecimalFromFloat(noOfYSections)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat([self yAxisStartValue]) length:CPTDecimalFromFloat([self yAxisLengthValue])];
    plotSpace.globalYRange = plotSpace.yRange;
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([dataForPlot count]+0)];
    plotSpace.delegate = self;
    
    CPTMutableLineStyle *commonlinestyle = [CPTMutableLineStyle lineStyle]; 
    [commonlinestyle setLineWidth:0.2]; 
    [commonlinestyle setLineColor:[CPTColor whiteColor]];
    
    // Axes
    /*if (_regenerateFlag==NO) 
    {*/
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)localgraph.axisSet;
        CPTXYAxis *x = [self generateCustomLabelTicksForXAxis:axisSet]; //   axisSet.xAxis;
        x.majorGridLineStyle = commonlinestyle;
        
        CPTXYAxis *y = [self generateCustomLabelTicksForYAxis:axisSet]; //   axisSet.yAxis;
        y.majorGridLineStyle = commonlinestyle; 
        
        
        // Create a green plot area
        
        [localgraph addPlot:[self getBusinessPlot]];
        
        [localgraph addPlot:[self getInvoicePlot]];
        
        [localgraph addPlot:[self getCollectionPlot]];
    
        localgraph.legend = [CPTLegend legendWithGraph:localgraph];
        localgraph.legend.numberOfColumns = 3;
        localgraph.legend.textStyle = x.titleTextStyle;
        localgraph.legend.fill = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
        localgraph.legend.borderLineStyle = x.axisLineStyle;
        localgraph.legend.cornerRadius = 5.0;
        localgraph.legend.swatchSize = CGSizeMake(25.0, 25.0);
        localgraph.legendAnchor = CPTRectAnchorTopRight;
        localgraph.legendDisplacement = CGPointMake(-20.0, -40.0);  
    /*}

    //_chartGenInProgress = NO;
    _regenerateFlag = NO;*/
    //NSLog(@"chart type %@ and datagenration and chart generation completed", _chartType);
    NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
    [chartInfo setValue:_chartType forKey:@"ChartType"];
    [chartInfo setValue:localgraph forKey:@"LocalGraph"];
    [chartInfo setValue:self forKey:@"ChartDelegate"];
    //[[NSNotifixcationCenter defaultCenter] postNotixficationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
    _chartDataGenerateMethod(chartInfo);
}

- (CPTXYAxis*) generateCustomLabelTicksForXAxis: (CPTXYAxisSet*) mainAxis
{
    CPTXYAxis *xAxis = mainAxis.xAxis;
    customXLabels = [NSMutableArray arrayWithCapacity:NO_OF_DAYS_FOR_LINECHART+1];
    customXTicks = [NSMutableArray arrayWithCapacity:NO_OF_DAYS_FOR_LINECHART+1];
    xAxis.majorIntervalLength = CPTDecimalFromString(@"1");
    xAxis.title = @"For Date";
    xAxis.titleLocation = CPTDecimalFromFloat(onePoint);
	xAxis.titleOffset = 100.0f;
    xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    //int indexadd = NO_OF_DAYS_FOR_LINECHART - [dataForPlot count];
	for (int i= 0 ; i< [dataForPlot count] + 1 ;i++) 
    {
        NSString *disptext;
        if (i<0 || i >= [dataForPlot count]) 
        {
            disptext = [[NSString alloc] initWithString:@""];
            //disptext = [[NSString alloc] initWithFormat:@"%d",i];
        }
        else //if (i < [dataForPlot count])
        {
             NSDictionary *datadict = [dataForPlot objectAtIndex:i];
             NSString *fordatestr =  [[datadict valueForKey:@"FORDATE"] substringToIndex:10];
             NSDateFormatter *df = [[NSDateFormatter alloc] init];
             [df setDateFormat:@"yyyy-MM-dd"];
             NSDate *fordate = [df dateFromString:fordatestr];
             [df setDateFormat:@"dd/MM"];
             disptext = [[NSString alloc] initWithFormat:@"%@", [df stringFromDate:fordate]];
             //NSLog(@"x label location %d",i);
        }
        [customXTicks addObject:[NSNumber numberWithInt:i]];
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:xAxis.labelTextStyle];
        newLabel.tickLocation = [[NSNumber numberWithInt:i] decimalValue]; //  [[[NSString alloc] initWithFormat:@"%f",i] floatValue];
        newLabel.offset = xAxis.labelOffset + xAxis.majorTickLength;
        newLabel.rotation = M_PI_BY_4;
        [customXLabels addObject:newLabel];
        //[newLabel release];
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
    yAxis.majorIntervalLength = CPTDecimalFromDouble(5 * onePoint);
    yAxis.minorTicksPerInterval = onePoint;
    yAxis.orthogonalCoordinateDecimal = CPTDecimalFromDouble([dataForPlot count]-(noOfYSections-0)) ; // - 10 * onePoint);
    //yAxis.title = @"In Dirhams";
    yAxis.titleLocation = CPTDecimalFromFloat(10.5f);
	yAxis.titleOffset = 100.0f;
    yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	for (int i=0; i< 20 ;i++) 
	{
        long dispvalue = yAxisStart +  onePoint * 5 * i;
        NSString *disptext = dispvalue<=0 ? @"" : [[NSString alloc] initWithFormat:@"%ld", dispvalue];
        //NSLog(@"dispva lue %ld and minvalue %ld", dispvalue, minY);
        if (dispvalue > 0 ) [customYTicks addObject:[NSNumber numberWithLong:dispvalue]];
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:yAxis.labelTextStyle];
		newLabel.tickLocation = [[NSNumber numberWithLong:dispvalue] decimalValue]; //  [[[NSString alloc] initWithFormat:@"%ld",dispvalue] decimalValue];
		newLabel.rotation = 0;
        newLabel.offset = 0.5f;
        if (i>0) [customYTicks addObject:[NSNumber numberWithInt:i]];
		[customYLabels addObject:newLabel];
		//[newLabel release];
	}
	yAxis.axisLabels =  [NSSet setWithArray:customYLabels];
    yAxis.majorTickLocations = [NSSet setWithArray:customYTicks];
    return yAxis;
}

- (CPTScatterPlot*) getBusinessPlot
{
	CPTScatterPlot *businesssPlot = [[CPTScatterPlot alloc] init] ;
    businesssPlot.identifier = @"Business Plot";
    businesssPlot.title = @"Business";
    CPTMutableLineStyle *lineStyle = [businesssPlot.dataLineStyle mutableCopy] ;
	lineStyle.lineWidth = 5.0f;
    lineStyle.lineColor = [CPTColor greenColor];
	lineStyle.dashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
    businesssPlot.dataLineStyle = lineStyle;
    businesssPlot.dataSource = self;
    return businesssPlot;
}

- (CPTScatterPlot*) getInvoicePlot
{
	CPTScatterPlot *invoicePlot = [[CPTScatterPlot alloc] init] ;
    invoicePlot.identifier = @"Invoice Plot";
    invoicePlot.title = @"Invoice";
    CPTMutableLineStyle *lineStyle = [invoicePlot.dataLineStyle mutableCopy] ;
    lineStyle = [invoicePlot.dataLineStyle mutableCopy] ;
	lineStyle.lineWidth = 5.0f;
	lineStyle.lineColor = [CPTColor redColor];
    lineStyle.dashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
    invoicePlot.dataLineStyle = lineStyle;
    invoicePlot.dataSource = self;
    return invoicePlot;
}

- (CPTScatterPlot*) getCollectionPlot
{
	CPTScatterPlot *collectionPlot = [[CPTScatterPlot alloc] init] ;
    collectionPlot.identifier = @"Collection Plot";
    collectionPlot.title = @"Colection";
    CPTMutableLineStyle *lineStyle = [collectionPlot.dataLineStyle mutableCopy];
    lineStyle = [collectionPlot.dataLineStyle mutableCopy] ;
	lineStyle.lineWidth = 5.0f;
	lineStyle.lineColor = [CPTColor whiteColor];
    lineStyle.dashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
    collectionPlot.dataLineStyle = lineStyle;
    collectionPlot.dataSource = self;
    return collectionPlot;
}

- (long) yAxisStartValue
{
    return yAxisStart;
    
}

- (long) yAxisLengthValue
{
    return yAxisLength;
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
    //NSLog(@"noof items for plot %d",[dataForPlot count]);
    return [dataForPlot count] + 2;
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    int indexadd = index;
    //NSLog(@" index no is %d",indexadd);
    if (fieldEnum == CPTScatterPlotFieldX) 
    {
        return [NSNumber numberWithDouble:[[[NSString alloc] initWithFormat:@"%d",indexadd] doubleValue]] ;
    }
    else
    {
        if (indexadd>=0 && indexadd<[dataForPlot count]) 
        {
            NSDictionary *tempdata = [dataForPlot objectAtIndex:indexadd];
            if (plot.identifier==@"Business Plot") 
                return [tempdata valueForKey:@"BUSINESS"];    
            else if (plot.identifier==@"Invoice Plot")
                return [tempdata valueForKey:@"INVOICE"];
            else
                return [tempdata valueForKey:@"COLLECTION"];
        }
    }
    return nil;
}


-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
	static CPTMutableTextStyle *whiteText = nil;
	
	if ( !whiteText ) {
		whiteText = [[CPTMutableTextStyle alloc] init];
		whiteText.color = [CPTColor whiteColor];
	}
	
	CPTTextLayer *newLayer = nil;
    //newLayer = [[[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%lu", index] style:whiteText] autorelease];
    newLayer = [[CPTTextLayer alloc] initWithText:@"" style:whiteText] ;
	return newLayer;
}



- (CPTPlotRange *)plotSpace:(CPTPlotSpace *)space
     willChangePlotRangeTo:(CPTPlotRange *)newRange
             forCoordinate:(CPTCoordinate)coordinate {
    if (coordinate==CPTCoordinateX) {
        if (newRange.locationDouble < 0.0F) {
            newRange.location = CPTDecimalFromFloat(0.0);
        }
        if (newRange.locationDouble > ([dataForPlot count]-(noOfYSections-0))) {
            newRange.location = CPTDecimalFromFloat([dataForPlot count]-(noOfYSections-0));
        }
        
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)localgraph.axisSet;
        axisSet.yAxis.orthogonalCoordinateDecimal = newRange.location ;
       // NSLog(@"new range location %@", newRange );
    }
    return newRange;
}

- (BOOL) enablePreviousButton
{
    BOOL retVal = NO;
    return retVal;
}

- (BOOL) enableNextButton
{
    BOOL retVal = NO;
    return retVal;
}

@end
