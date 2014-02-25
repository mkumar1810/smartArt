//
//  misLandingPageData.m
//  dssapi
//
//  Created by Raja T S Sekhar on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "misLandingPageData.h"

@implementation misLandingPageData

- (id) initWithUser:(NSString*) p_foruser
{
    self = [super init];
    if (self) 
    {
        _userCode = p_foruser;
        dictData = [[NSMutableArray alloc] init];
        [self generateData];
    }
    return self;
}

- (void) generateData
{
    userSecuritySoapBinding *ussb = [userSecurity userSecuritySoapBinding];
    ussb.logXMLInOut = NO;
    userSecurity_getMISFrontDisplay *usmisFrontDisp= [[userSecurity_getMISFrontDisplay alloc] init];
    [usmisFrontDisp setP_usercode:_userCode];
    [usmisFrontDisp setP_module:@"0"];
    [ussb getMISFrontDisplayAsyncUsingParameters:usmisFrontDisp delegate:self];
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
        
        if([bodyPart isKindOfClass:[userSecurity_getMISFrontDisplayResponse class]]) {
            userSecurity_getMISFrontDisplayResponse *body = (userSecurity_getMISFrontDisplayResponse*)bodyPart;
            NSMutableString *resultmessage = (NSMutableString*) body.getMISFrontDisplayResult;
            webData = (NSMutableData*) [resultmessage dataUsingEncoding:NSUTF8StringEncoding];
            parseElement = [[NSMutableString alloc] initWithString:@""];	
            xmlParser = [[NSXMLParser alloc] initWithData:webData];
            [xmlParser setDelegate:self];
            [xmlParser setShouldResolveExternalEntities:YES];
            [xmlParser parse];
            [xmlParser release];
            NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
            [returnInfo setValue:dictData forKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FDDataGenerated" object:self userInfo:returnInfo];
            continue;
        }
    }    
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
