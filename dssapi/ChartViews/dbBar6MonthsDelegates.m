//
//  dbBar6MonthsDelegates.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "dbBar6MonthsDelegates.h"

@implementation dbBar6MonthsDelegates

- (void) initializeItems
{
    localgraph.plotAreaFrame.masksToBorder = NO;
    localgraph.paddingLeft = 70.0;
    localgraph.paddingTop = 35.0;
    localgraph.paddingRight = 20.0;
    localgraph.paddingBottom = 80.0;   
}

-(void) generateData
{
    userSecuritySoapBinding *ussb = [userSecurity userSecuritySoapBinding];
    ussb.logXMLInOut = YES;
    userSecurity_getDBDPurchaseSalesForQuarterMonthly *usPurchSales= [[userSecurity_getDBDPurchaseSalesForQuarterMonthly alloc] init];
    NSString *monthOffsetStr = [[NSString alloc] initWithFormat:@"%d", _monthOffset];
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"d-MMM-yyyy"];
    forDate = [NSDate date];
    [usPurchSales setP_fordate:[nsdf stringFromDate:forDate]];
    [usPurchSales setP_monthoffset:monthOffsetStr];
    [ussb getDBDPurchaseSalesForQuarterMonthlyAsyncUsingParameters:usPurchSales delegate:self];
}

- (void) generateGraphComplete
{
    localgraph.title = @"Sales Performance";
    /*if (isSmallView==1)
        localgraph.title = @"Sales Performance";
    else
        localgraph.title = [[NSString alloc] initWithFormat:@"%@ %@", @"Sales Performance", [self getTitleSuffix]]; */
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor whiteColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = localgraph.bounds.size.height / 20.0f;
    localgraph.titleTextStyle = textStyle;
    localgraph.titleDisplacement = CGPointMake(0.0f, localgraph.bounds.size.height / 18.0f);
    localgraph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    //NSLog(@"y axis start and end are %ld and %ld", yAxisStart, yAxisLength);
    if (isSmallView==0) 
        noOfRecs = [dataForPlot count]+1;
    else
        noOfRecs = 8;
    startNo = [dataForPlot count] - noOfRecs + 1;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)localgraph.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(maxAll)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0.0f) length:CPTDecimalFromInt(noOfRecs+1)];
    
    CPTMutableLineStyle *commonlinestyle = [CPTMutableLineStyle lineStyle]; 
    [commonlinestyle setLineWidth:0.2]; 
    [commonlinestyle setLineColor:[CPTColor whiteColor]];
    
    // Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)localgraph.axisSet;
    CPTXYAxis *x = [self generateCustomLabelTicksForXAxis:axisSet]; //   axisSet.xAxis;
    x.majorGridLineStyle = commonlinestyle;    
    
    CPTXYAxis *y = [self generateCustomLabelTicksForYAxis:axisSet]; //   axisSet.yAxis;
    y.majorGridLineStyle = commonlinestyle; 
    
    NSMutableArray *newAxes = [localgraph.axisSet.axes mutableCopy];
    //[newAxes addObject:rightY];
    //CPTXYAxis *newXaxis = [self generateAddtionalXAxisForDataLabel:axisSet]; 
    [newAxes addObject:[self generateAddtionalXAxisForDataLabel:axisSet]];
    localgraph.axisSet.axes = newAxes;
    [newAxes release];

    [localgraph addPlot:[self getSalesBarPlot] toPlotSpace:plotSpace];

}


- (CPTXYAxis*) generateAddtionalXAxisForDataLabel : (CPTXYAxisSet*) mainAxis
{
    CPTXYAxis *newAxis = [[[CPTXYAxis alloc] init] autorelease];
    customDataLabelXAxis = [NSMutableArray arrayWithCapacity:10];
    customDataLabelXTicks = [NSMutableArray arrayWithCapacity:10];
    newAxis.coordinate = CPTCoordinateX;
    newAxis.majorIntervalLength = CPTDecimalFromString(@"3");
    newAxis.tickDirection = CPTSignPositive;
    newAxis.plotSpace = mainAxis.xAxis.plotSpace;
    newAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    
    for (int i= 0; i < noOfRecs+1   ;i++) 
	{
        NSString *disptext;
        if (i!=0 & (startNo + i -1) < [dataForPlot count]) 
        {
            NSDictionary *datadict = [dataForPlot objectAtIndex:startNo+i-1];
            NSDecimalNumber *num = nil;    
            num = [datadict valueForKey:@"SALES"];             
            NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
            [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
            [frm setCurrencySymbol:@""];
            [frm setMaximumFractionDigits:0];
            //NSString *formatted = [frm stringFromNumber:[NSNumber numberWithInt:100000]];
            disptext = [frm stringFromNumber:[NSNumber numberWithInteger:[num integerValue]]];
                        //[[NSString alloc] initWithFormat:@"%d",[num integerValue]]    ];
            [customDataLabelXTicks addObject:[NSNumber numberWithInt:i]];
        }
        else
            disptext = [[NSString alloc] initWithString:@""];
        CPTAxisLabel *newDataLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:mainAxis.xAxis.labelTextStyle];
        newDataLabel.tickLocation = [[[NSString alloc] initWithFormat:@"%d",i] decimalValue];
        newDataLabel.offset = -newAxis.labelOffset;// - xAxis.majorTickLength;
        newDataLabel.alignment = CPTTextAlignmentLeft;
        newDataLabel.rotation = M_PI_2;
        [customDataLabelXAxis addObject:newDataLabel];
        [newDataLabel release];
	}

	newAxis.axisLabels =  [NSSet setWithArray:customDataLabelXAxis];
    newAxis.majorTickLocations = [NSSet setWithArray:customDataLabelXTicks];
    return newAxis;
}


- (CPTBarPlot*) getPurchaseBarPlot
{
    CPTBarPlot *purchasePlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor redColor] horizontalBars:NO];
    purchasePlot.baseValue = CPTDecimalFromString(@"0");
    purchasePlot.dataSource = self;
    purchasePlot.barOffset = CPTDecimalFromFloat(0.5f);
    purchasePlot.barWidth = CPTDecimalFromFloat(1.0f);
    purchasePlot.identifier = @"Purchase";
    return purchasePlot;
}

- (CPTBarPlot*) getSalesBarPlot
{
    CPTBarPlot *salesPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor magentaColor] horizontalBars:NO];
    //salesPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    salesPlot.dataSource = self;
    salesPlot.baseValue = CPTDecimalFromString(@"0");
    salesPlot.barOffset = CPTDecimalFromFloat(0.4f);
    salesPlot.barWidth = CPTDecimalFromFloat(1.0f);
    //salesPlot.barCornerRadius = 2.0f;
    salesPlot.identifier = @"Sales";
    return salesPlot;
}

- (CPTXYAxis*) generateCustomLabelTicksForXAxis: (CPTXYAxisSet*) mainAxis
{
    CPTXYAxis *xAxis = mainAxis.xAxis;
    customXLabels = [NSMutableArray arrayWithCapacity:10];
    customXTicks = [NSMutableArray arrayWithCapacity:10];
    xAxis.majorIntervalLength = CPTDecimalFromString(@"3");
    xAxis.orthogonalCoordinateDecimal = CPTDecimalFromInt(0);
    xAxis.title = @"Month & Year";
    xAxis.titleLocation = CPTDecimalFromFloat(7.5f);
	xAxis.titleOffset = 55.0f;
    xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    for (int i= 0; i < noOfRecs+1   ;i++) 
	{
        NSString *disptext;
        if (i!=0 & (startNo + i -1) < [dataForPlot count]) 
        {
            NSDictionary *datadict = [dataForPlot objectAtIndex:startNo+i-1];
            NSString *monthname = [[datadict valueForKey:@"MONTHS"] substringToIndex:3];
            NSString *yearcode = [[datadict valueForKey:@"YEARCODE"] substringFromIndex:2];
            disptext = [[NSString alloc] initWithFormat:@"%@,%@", monthname, yearcode];
            [customXTicks addObject:[NSNumber numberWithInt:i]];
        }
        else
            disptext = [[NSString alloc] initWithString:@""];
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:xAxis.labelTextStyle];
		newLabel.tickLocation = [[[NSString alloc] initWithFormat:@"%d",i] decimalValue];
		newLabel.offset = xAxis.labelOffset + xAxis.majorTickLength;
		newLabel.rotation = M_PI_BY_4;
		[customXLabels addObject:newLabel];
		[newLabel release];
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
    yAxis.title = @"Dirhams   ";
    yAxis.titleLocation = CPTDecimalFromFloat(-150.0f);
	yAxis.titleOffset = 20.0f;
    yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	yAxis.axisLabels =  [NSSet setWithArray:customYLabels];
    yAxis.majorTickLocations = [NSSet setWithArray:customYTicks];
	
    for (int i=0; i< 10 ;i++) 
	{
        long dispvalue = onePoint * 2 * i;
        NSString *disptext = dispvalue<=0 ? @"" : [[NSString alloc] initWithFormat:@"%ld", dispvalue];
        if (dispvalue > 0) [customYTicks addObject:[NSNumber numberWithLong:dispvalue]];
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:disptext textStyle:yAxis.labelTextStyle];
		newLabel.tickLocation = [[[NSString alloc] initWithFormat:@"%ld",dispvalue] decimalValue];
		newLabel.rotation = 0;
        newLabel.offset = 1.0f;
        [customYTicks addObject:[NSNumber numberWithInt:2*i]];
		[customYLabels addObject:newLabel];
		[newLabel release];
	}
	yAxis.axisLabels =  [NSSet setWithArray:customYLabels];
    yAxis.majorTickLocations = [NSSet setWithArray:customYTicks];
    return yAxis;
}


- (void) operation:(userSecuritySoapBindingOperation *)operation completedWithResponse:(userSecuritySoapBindingResponse *)response
{
    NSArray *responseHeaders = response.headers;
    NSArray *responseBodyParts = response.bodyParts;    
    for(id header in responseHeaders) {
        // here do what you want with the headers, if there's anything of value in them
    }
    for(id bodyPart in responseBodyParts) 
    {
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
            [self showAlertMessage:((SOAPFault *)bodyPart).simpleFaultString];
            return;
        }
        
        if([bodyPart isKindOfClass:[userSecurity_getDBDPurchaseSalesForQuarterMonthlyResponse class]]) {
            userSecurity_getDBDPurchaseSalesForQuarterMonthlyResponse *body = (userSecurity_getDBDPurchaseSalesForQuarterMonthlyResponse*)bodyPart;
            NSMutableString *resultmessage = (NSMutableString*) [self htmlEntityDecode:body.getDBDPurchaseSalesForQuarterMonthlyResult];
            webData = (NSMutableData*) [resultmessage dataUsingEncoding:NSUTF8StringEncoding];
            parseElement = [[NSMutableString alloc] initWithString:@""];	
            xmlParser = [[NSXMLParser alloc] initWithData:webData];
            [xmlParser setDelegate:self];
            [xmlParser setShouldResolveExternalEntities:YES];
            [xmlParser parse];
            [xmlParser release];
            //long maxPurchase = [[dataForBar valueForKeyPath:@"@max.PURCHASES"] longValue];
            long maxSales = [[dataForPlot valueForKeyPath:@"@max.SALES"] longValue];
            maxAll = maxSales; // (maxPurchase > maxSales ? maxPurchase : maxSales);
            onePoint = maxAll / 16;
            maxAll = onePoint * 20;
            
            NSMutableDictionary *chartInfo = [[NSMutableDictionary alloc] init];
            [chartInfo setValue:@"BAR6" forKey:@"ChartType"];
            [chartInfo setValue:localgraph forKey:@"LocalGraph"];
            [chartInfo setValue:self forKey:@"ChartDelegate"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChartDataGenerated" object:self userInfo:chartInfo];
            continue;
        }
    }    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict   
{
	//NSLog(@"Element starting is %@ ", elementName);
    [parseElement setString:elementName];
    if ([elementName isEqualToString:@"Table"]) {
        resultDataStruct = [[NSMutableDictionary alloc] init];
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"element value %@ for element name %@",string,parseElement);
    if([parseElement isEqualToString:@"PURCHASES"])
    {
        [resultDataStruct setValue:[NSNumber numberWithDouble:[string doubleValue]] forKey:parseElement];
    }
    else if([parseElement isEqualToString:@"MONTHS"] || [parseElement isEqualToString:@"YEARCODE"])
        [resultDataStruct setValue:string forKey:parseElement];
    else if([parseElement isEqualToString:@"SALES"])
        [resultDataStruct setValue:[NSNumber numberWithDouble:[string doubleValue]] forKey:parseElement];
    else if([parseElement isEqualToString:@"RESPONSECODE"])
    {
        respcode = [[NSMutableString alloc] initWithFormat:@"%@", string];
    }
    else if([parseElement isEqualToString:@"RESPONSEMESSAGE"])
        respmessage = [[NSMutableString alloc] initWithFormat:@"%@", string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [parseElement setString:@""];
	//NSLog(@"The ending element is %@", elementName);
    if ([elementName isEqualToString:@"Table"]) {
        if (resultDataStruct) {
            [dataForPlot addObject:resultDataStruct];
            [resultDataStruct release];
        }
    }
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
    //NSLog(@"no of records 7 returned");
    return [dataForPlot count] +1;
    //return noOfRecs;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    //if (index==0 | index > [dataForPlot count] - startNo + 1) return nil;
    NSDecimalNumber *num = nil;
    switch ( fieldEnum) 
    {
        case CPTBarPlotFieldBarLocation:
            num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
            break;
        case CPTBarPlotFieldBarTip:
            if (!(index!=0 & (startNo + index -1) < [dataForPlot count])) return nil;
            NSDictionary *tempdata = [dataForPlot objectAtIndex:startNo+index-1];
            num = [tempdata valueForKey:@"SALES"];            
            break;
    }
    //NSLog(@"number for bar plot is %@",num);
    return num;
}


@end
