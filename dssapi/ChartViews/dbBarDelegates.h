//
//  dbBarDelegates.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseChart.h"

@interface dbBarDelegates : baseChart <CPTBarPlotDataSource>
{
    //CPTBarPlot *barChartPlot;
    //NSDate *forDate;
    long onePoint,maxAll;
    int noOfBars;
    NSMutableArray *customDataLabelXAxis, *customDataLabelXTicks;
}

- (CPTBarPlot*) getPurchaseBarPlot;
- (CPTBarPlot*) getSalesBarPlot;
- (CPTXYAxis*) generateAddtionalXAxisForDataLabel : (CPTXYAxisSet*) mainAxis;

@end
