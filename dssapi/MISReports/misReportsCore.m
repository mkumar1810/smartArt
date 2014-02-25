//
//  misReportsCore.m
//  dssapi
//
//  Created by Raja T S Sekhar on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "misReportsCore.h"

@implementation misReportsCore

- (id) initWithReportType:(NSString*) reportType andForDate:(NSString*) forDate andDayoffset:(int) dayOffset andNotificatioName:(NSString*) notificationName
{
    self = [super init];
    if (self) {
        _forDate = [[NSString alloc] initWithFormat:@"%@", forDate];
        _reportType = [[NSString alloc] initWithFormat:@"%@", reportType];
        _notificationName = [[NSString alloc] initWithFormat:@"%@", notificationName];
        _dayOffset = dayOffset;
        dictData = [[NSMutableArray alloc] init];
        [self generateData];
    }
    return self;
}

- (id) initWithReportType:(NSString*) reportType andForMonthOffset:(int) monthOffset andNotificationName:(NSString*) notificationName
{
    self = [super init];
    if (self) {
        _reportType = [[NSString alloc] initWithFormat:@"%@", reportType];
        _notificationName = [[NSString alloc] initWithFormat:@"%@", notificationName];
        _monthOffset = monthOffset;
        dictData = [[NSMutableArray alloc] init];
        [self generateData];
    }
    return self;
}


- (void) generateData
{
    userSecuritySoapBinding *ussb = [userSecurity userSecuritySoapBinding];
    ussb.logXMLInOut = NO;
    if ([_reportType isEqualToString:@"MIS_BussInvColn"]==YES) 
    {
        userSecurity_getMISBusInvColn *usMISbisinvcoln= [[userSecurity_getMISBusInvColn alloc] init];
        [usMISbisinvcoln setP_fordate:_forDate];
        [usMISbisinvcoln setP_dayoffset:[[NSString alloc] initWithFormat:@"%d", _dayOffset]];
        [usMISbisinvcoln setP_reporttype:_reportType];
        [ussb getMISBusInvColnAsyncUsingParameters:usMISbisinvcoln delegate:self];
    }
    if ([_reportType isEqualToString:@"MIS_BussInvDaily"]==YES) 
    {
        userSecurity_getMISBusInvDailyStmt *usMISBusInvDaily = [[userSecurity_getMISBusInvDailyStmt alloc] init];
        [usMISBusInvDaily setP_reporttype:_reportType];
        [usMISBusInvDaily setP_monthoffset:[NSString stringWithFormat:@"%d",_monthOffset]];
        [ussb getMISBusInvDailyStmtAsyncUsingParameters:usMISBusInvDaily delegate:self];
    }
    if ([_reportType isEqualToString:@"MIS_BussInvSalesManwiseMonthly"]==YES) 
    {
        userSecurity_getMISBusInvSalesManMonthly *usMISSMMonthly = [[userSecurity_getMISBusInvSalesManMonthly alloc] init];
        [usMISSMMonthly setP_reporttype:_reportType];
        [usMISSMMonthly setP_monthoffset:[NSString stringWithFormat:@"%d",_monthOffset]];
        [ussb getMISBusInvSalesManMonthlyAsyncUsingParameters:usMISSMMonthly delegate:self];
    }
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
        
        if([bodyPart isKindOfClass:[userSecurity_getMISBusInvColnResponse class]]) {
            userSecurity_getMISBusInvColnResponse *body = (userSecurity_getMISBusInvColnResponse*)bodyPart;
            NSMutableString *resultmessage = (NSMutableString*) body.getMISBusInvColnResult;
            [self processAndReturnXMLMessage:resultmessage];
            continue;
        }
        
        if ([bodyPart isKindOfClass:[userSecurity_getMISBusInvDailyStmtResponse class]]) {
            userSecurity_getMISBusInvDailyStmtResponse *body = (userSecurity_getMISBusInvDailyStmtResponse*) bodyPart;
            NSMutableString *resultmessage = (NSMutableString*) body.getMISBusInvDailyStmtResult;
            [self processAndReturnXMLMessage:resultmessage];
            continue;
        }
        if ([bodyPart isKindOfClass:[userSecurity_getMISBusInvSalesManMonthlyResponse class]]) {
            userSecurity_getMISBusInvSalesManMonthlyResponse *body = (userSecurity_getMISBusInvSalesManMonthlyResponse*) bodyPart;
            NSMutableString *resultmessage = (NSMutableString*) body.getMISBusInvSalesManMonthlyResult;
            [self processAndReturnXMLMessage:resultmessage];
            continue;
        }
    }    
}

- (void) processAndReturnXMLMessage:(NSString*) p_resmessage
{
    webData = (NSMutableData*) [p_resmessage dataUsingEncoding:NSUTF8StringEncoding];
    parseElement = [[NSMutableString alloc] initWithString:@""];	
    xmlParser = [[NSXMLParser alloc] initWithData:webData];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    [xmlParser release];
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    [returnInfo setValue:dictData forKey:@"data"];
    NSLog(@"notification name generated %@",_notificationName);
    [[NSNotificationCenter defaultCenter] postNotificationName:_notificationName object:self userInfo:returnInfo];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict   
{
    [parseElement setString:elementName];
    if ([elementName isEqualToString:@"Table"]) {
        resultDataStruct = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([parseElement isEqualToString:@""]==NO) 
        [resultDataStruct setValue:string forKey:parseElement];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [parseElement setString:@""];
    if ([elementName isEqualToString:@"Table"]) 
    {
        if (resultDataStruct) {
            [dictData addObject:resultDataStruct];
            [resultDataStruct release];
        }
    }
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}


@end
