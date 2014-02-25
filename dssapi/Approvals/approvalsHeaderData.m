//
//  approvalsHeaderData.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "approvalsHeaderData.h"

@implementation approvalsHeaderData

- (id) initWithDivisionCode:(NSString*) p_divcode
{
    self=[super init];
    if (self) 
    {
        l_loggeduser = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggeduser"]; 
        l_divisioncode = p_divcode;
        resultData = [[NSMutableArray alloc] init];
        [self generateHeaderData];
    }
    return self;
}

- (void) generateHeaderData
{
    userSecuritySoapBinding *ussb = [userSecurity userSecuritySoapBinding];
    ussb.logXMLInOut = NO;
    userSecurity_getApprovalsHeaderDetail *usApprovals = [[userSecurity_getApprovalsHeaderDetail alloc] init];
    [usApprovals setP_divcode:l_divisioncode];
    [usApprovals setP_module:@"0"];
    [usApprovals setP_usercode:l_loggeduser];
    [ussb getApprovalsHeaderDetailAsyncUsingParameters:usApprovals delegate:self];
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
        
        if([bodyPart isKindOfClass:[userSecurity_getApprovalsHeaderDetailResponse class]]) {
            userSecurity_getApprovalsHeaderDetailResponse *body = (userSecurity_getApprovalsHeaderDetailResponse*)bodyPart;
            NSMutableString *resultmessage = (NSMutableString*) [self htmlEntityDecode:body.getApprovalsHeaderDetailResult];
            webData = (NSMutableData*) [resultmessage dataUsingEncoding:NSUTF8StringEncoding];
            parseElement = [[NSMutableString alloc] initWithString:@""];	
            xmlParser = [[NSXMLParser alloc] initWithData:webData];
            [xmlParser setDelegate:self];
            [xmlParser setShouldResolveExternalEntities:YES];
            [xmlParser parse];
            [xmlParser release];
            NSMutableDictionary *approvalInfo = [[NSMutableDictionary alloc] init ];
            [approvalInfo setValue:l_divisioncode forKey:@"divisioncode"];
            [approvalInfo setValue:resultData forKey:@"headerdata"];
            NSLog(@"result data before notification %@", resultData);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"approvalsHeaderDataGenerated" object:self userInfo:approvalInfo];
            continue;
        }
    }    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict   
{
    //NSLog(@"element name %@",elementName);
    if([elementName isEqualToString:@"Table"])
    {
        /*if (resultDataStruct) {
            [resultData addObject:resultDataStruct  ];
            [resultDataStruct release];
        }*/
        resultDataStruct = [[NSMutableDictionary alloc] init];
    }
    [parseElement setString:elementName];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"element value %@ for element name %@",string,parseElement);
    if ([parseElement isEqualToString:@""]==NO) 
    {
        if (resultDataStruct)
            [resultDataStruct setValue:string forKey:parseElement];
        else
        {
            if([parseElement isEqualToString:@"RESPONSECODE"])
                respcode = [[NSMutableString alloc] initWithFormat:@"%@", string];
            else if([parseElement isEqualToString:@"RESPONSEMESSAGE"])
                respmessage = [[NSMutableString alloc] initWithFormat:@"%@", string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"end element taga %@", elementName);
    if([elementName isEqualToString:@"Table"])
    {
        if (resultDataStruct) {
            [resultData addObject:resultDataStruct];
            [resultDataStruct release];
        }        
    }
    [parseElement setString:@""];
}

-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return string;
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end
