//
//  dbBar6MonthsDelegates.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseChart.h"


@interface dbBar6MonthsDelegates : baseChart <CPTBarPlotDataSource, NSXMLParserDelegate, userSecuritySoapBindingResponseDelegate>
{
    //CPTBarPlot *barChartPlot;
    NSDate *forDate;
    long onePoint,maxAll;
    int noOfRecs, startNo;
    NSMutableArray *customDataLabelXAxis, *customDataLabelXTicks;
}

- (CPTBarPlot*) getPurchaseBarPlot;
- (CPTBarPlot*) getSalesBarPlot;
- (CPTXYAxis*) generateAddtionalXAxisForDataLabel : (CPTXYAxisSet*) mainAxis;

@end

