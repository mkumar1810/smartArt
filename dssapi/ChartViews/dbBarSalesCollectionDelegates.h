//
//  dbBarSalesCollectionDelegates.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseChart.h"


@interface dbBarSalesCollectionDelegates : baseChart <CPTBarPlotDataSource>
{
    long onePoint,maxAll;
    int noOfBars;
    NSMutableArray *customDataLabelXAxis, *customDataLabelXTicks;
}

- (CPTBarPlot*) getCollectionBarPlot;
- (CPTBarPlot*) getSalesBarPlot;
- (CPTXYAxis*) generateAddtionalXAxisForDataLabel : (CPTXYAxisSet*) mainAxis;

@end
