//
//  chartProtocol.h
//  dssapi
//
//  Created by Raja T S Sekhar on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"
#import "dssWSCallsProxy.h"

@protocol chartProtocol <NSObject>


@optional

- (id) initWithGraphObject:(CPTXYGraph*) graph andViewPOS:(NSString*) viewPosition andMonthOffset:(int) monthOffset andChart:(NSString*) typeChart withOrientation:(UIInterfaceOrientation) passIntOrientation andDataGenerateMethod:(METHODCALLBACK) p_generateMethod;
- (void) generateData;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) generateGraphComplete:(NSDictionary*) dataInfo;
- (void) reDrawGraphsFornewView:(CPTGraphHostingView*) holderView;
- (NSString*) htmlEntityDecode:(NSString *)string;
- (void) initializeItems;
- (CPTXYAxis*) generateCustomLabelTicksForXAxis: (CPTXYAxisSet*) mainAxis;
- (CPTXYAxis*) generateCustomLabelTicksForYAxis: (CPTXYAxisSet*) mainAxis;
- (BOOL) enablePreviousButton;
- (BOOL) enableNextButton;
- (int) getCurrentOffset;
- (NSString*) getTitleSuffix;
- (void) swapChartToView:(CPTGraphHostingView*) newHostView andViewPosition: (NSString*) viewPos withOrientation:(UIInterfaceOrientation) passIntOrientation;
- (BOOL) allowGraphRemoval;
- (void) makeFullScreenModewithOrientation:(UIInterfaceOrientation) passIntOrientation;
@end
