//
//  baseChart.h
//  dssapi
//
//  Created by Raja T S Sekhar on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chartProtocol.h"

@interface baseChart : NSObject <chartProtocol>
{
	NSMutableArray *dataForPlot, *customXLabels, *customXTicks, *customYLabels, *customYTicks;
    CPTXYGraph *localgraph;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;
    int isSmallView;
    int _monthOffset;
    NSString *_chartType, *_viewPosition;
    BOOL _dataGenInProgress;
    NSDate *forDate;
	NSDate *mtdsalesfordate;
    double totalsalesvalue, firstFiveTotal;
    int numOfRecs;
    BOOL isFullScreenMode;
	NSDate *businvenddate, *businvstartdate;
    NSMutableArray *dataCache;
    //NSString *_notificationName;
    METHODCALLBACK _proxyReturnMethod;
    METHODCALLBACK _chartDataGenerateMethod;
    UIInterfaceOrientation intOrientation;
}

@end
