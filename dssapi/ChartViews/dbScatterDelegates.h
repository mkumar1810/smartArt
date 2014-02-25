//
//  dbScatterDelegates.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseChart.h"

@interface dbScatterDelegates : baseChart  <CPTPlotDataSource ,CPTPlotSpaceDelegate>
{
    long onePoint,yAxisStart,yAxisLength,maxY,minY;
    int noOfYSections;
}

- (long) yAxisStartValue;
- (long) yAxisLengthValue;
- (CPTScatterPlot*) getBusinessPlot;
- (CPTScatterPlot*) getInvoicePlot;
- (CPTScatterPlot*) getCollectionPlot;

@end
