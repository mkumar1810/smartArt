//
//  dbPieDelegates.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseChart.h"

@interface dbPieDelegates : baseChart  <CPTPieChartDataSource>
{
    CPTPieChart *piePlot;
}

@end
