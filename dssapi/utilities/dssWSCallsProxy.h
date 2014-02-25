//
//  dssWSCallsProxy.h
//  dssapi
//
//  Created by Imac DOM on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "defaults.h"

@interface dssWSCallsProxy : NSObject  <NSXMLParserDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSString *_reportType;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;
    NSMutableArray *dictData;
    NSString *_notificationName;
    NSDictionary *inputParms;
    BOOL _returnInputParams;
    METHODCALLBACK _postProxyReturn;
}

- (void) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andReturnMethod:(METHODCALLBACK) p_returnMethod;
- (void) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andReturnMethod:(METHODCALLBACK) p_returnMethod andReturnInputs:(BOOL) p_retInputs;
/*- (id) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andNotificatioName:(NSString*) notificationName;
- (id) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andNotificatioName:(NSString*) notificationName andReturnInputs:(BOOL) p_retInputs;*/
- (void) generateData;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) processAndReturnXMLMessage;
-(NSString *)htmlEntityDecode:(NSString *)string;
-(NSString *)htmlEntitycode:(NSString *)string;
@end
