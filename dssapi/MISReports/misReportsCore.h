//
//  misReportsCore.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface misReportsCore : NSObject <NSXMLParserDelegate>
{
    NSString *_reportType, *_forDate;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;
    NSMutableArray *dictData;
    int _dayOffset, _monthOffset;
    NSString *_notificationName;
}

- (id) initWithReportType:(NSString*) reportType andForDate:(NSString*) forDate andDayoffset:(int) dayOffset andNotificatioName:(NSString*) notificationName;
- (id) initWithReportType:(NSString*) reportType andForMonthOffset:(int) monthOffset andNotificationName:(NSString*) notificationName;
- (void) generateData;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) processAndReturnXMLMessage:(NSString*) p_resmessage;

@end
