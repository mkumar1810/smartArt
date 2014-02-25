//
//  docApprovalMasterData.m
//  dssapi
//
//  Created by Raja T S Sekhar on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "docApprovalMasterData.h"


@implementation docApprovalMasterData

- (id) initWithDivCode:(NSString*) p_divCode andDocCode:(NSString*) p_docCode andUserStatus:(NSString*) p_userStatus andPopulatMethod:(METHODCALLBACK) p_appPopulateMethod andAppDeAppMethod:(METHODCALLBACK) p_appDeappMethod andDocDescription:(NSString*) p_docDesc andDocDetGenMethod:(METHODCALLBACK) p_docDetGenMethod andMainDocDict:(NSDictionary*) p_docDict
{
    self = [super init];
    if (self) {
        _divcode = p_divCode;
        _doccode = p_docCode;
        _userstatus = p_userStatus;
        /*_appPopulateNotifyName = p_appPopulateNotify;
        _appDeappNotifyName = p_appDeappNotifyName;
        _docDetGenNotifyname = p_docDetGenNotifyName;*/
        appPopulateMethod = p_appPopulateMethod;
        appDeappMethod = p_appDeappMethod;
        docDetGenMethod = p_docDetGenMethod;
        _docdesc = p_docDesc;
        __block id myself = self;
        applCompleteNotify = ^ (NSDictionary* p_dictInfo)
        {
            [myself approvalCompletionNotify:p_dictInfo];
        };
        schemaDict = [[[NSDictionary alloc] initWithDictionary:p_docDict] mutableCopy];
        resultData = [[NSMutableArray alloc] init];
        //NSLog(@"the header info %@",schemaDict);
        [self generateMasterData];
    }
    return self;
}

- (void) generateMasterData
{
    NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:_divcode, @"p_divcode",_doccode,@"p_documentcode",_userstatus, @"p_userstatus" , nil];

    [[dssWSCallsProxy alloc] initWithReportType:@"APPROVALMASTER" andInputParams:inputDict andReturnMethod:appPopulateMethod  andReturnInputs:YES];

}

- (void) setinterfaceOrientation:(UIInterfaceOrientation) p_intOrientation
{
    intOrientation = p_intOrientation;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"no of ites for division  nd count is %d",[currentData count] );
    return [resultData count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
        return 60;
    else
        return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *docNo, *docDetailId;
    NSDictionary* curData =(NSDictionary*) [resultData objectAtIndex:indexPath.row];      
    docNo =  [curData valueForKey:@"FIELD6"];
    docDetailId = [[NSString alloc] initWithFormat:@"%@%@%@", _divcode, _doccode, docNo];
    NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:_divcode, @"p_divcode",_doccode,@"p_documentcode",docNo, @"p_documentno" ,_docdesc, @"p_docdesc",schemaDict,@"p_docdict",  nil];
    [[dssWSCallsProxy alloc] initWithReportType:@"APPROVALDOCDETAIL" andInputParams:inputDict andReturnMethod:docDetGenMethod  andReturnInputs:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Executing ceeforrowindex path");
    static NSString *cellid=@"Cell";
    UILabel  *lblfield1, *lblfield2, *lblfield3, *lblfield4, *lblfield5;    
    UILabel *lbldivider0, *lbldivider1, *lbldivider2, *lbldivider3, *lbldivider4, *lbldivider5;    
    UIButton *btnapprove;
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    int approvalflag;
    NSString *approvalFlagStr;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:2];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        cell.backgroundColor=[UIColor clearColor];
        CGRect frame;
        int xWidth, xPosition, yHeight, noOfLines;
        if (UIInterfaceOrientationIsPortrait(intOrientation)) 
        {
            yHeight = 60;
            noOfLines = 3;
            frame = CGRectMake(694, 0, 45, 60);
        }
        else
        {
            yHeight = 30;
            noOfLines = 2;
            frame = CGRectMake(930, 0, 45, 30);
        }
        xPosition = 0;
        xWidth = 1;
        lbldivider0 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth,yHeight)];
        xPosition += xWidth + 2;
        xWidth = [self getXPosition:1];
        lblfield1 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        xPosition += xWidth + 2;
        xWidth = 1;
        lbldivider1 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        xPosition += xWidth + 2;
        xWidth = [self getXPosition:2];
        lblfield2 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        xPosition += xWidth + 2;
        xWidth =1;
        lbldivider2 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        xPosition += xWidth + 2;
        xWidth = [self getXPosition:3];
        lblfield3 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        xPosition += xWidth +2;
        xWidth = 1;
        lbldivider3 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        xPosition += xWidth + 2;
        xWidth = [self getXPosition:4];
        lblfield4 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        xPosition += xWidth +2;
        xWidth = 1;
        lbldivider4 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        xPosition += xWidth + 2;
        xWidth = [self getXPosition:5];
        lblfield5 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        xPosition += xWidth +2;
        xWidth = 1;
        lbldivider5 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];

        lbldivider0.backgroundColor = [UIColor grayColor];
        lbldivider0.text= @"";
        [cell.contentView addSubview:lbldivider0];
        
        lblfield1.textColor = cell.textLabel.textColor;
        lblfield1.font = [UIFont systemFontOfSize:14.0f];
        lblfield1.backgroundColor = [UIColor clearColor];
        lblfield1.numberOfLines = noOfLines;
        lblfield1.textAlignment = [self getAlignmentPosition:1];
        lblfield1.tag = 1;
        [cell.contentView addSubview:lblfield1];        
        
        lbldivider1.backgroundColor = [UIColor grayColor];
        lbldivider1.text= @"";
        [cell.contentView addSubview:lbldivider1];

        lblfield2.textColor = cell.textLabel.textColor;
        lblfield2.font = [UIFont systemFontOfSize:14.0f];
        lblfield2.backgroundColor = [UIColor clearColor];
        lblfield2.numberOfLines = noOfLines;
        lblfield2.textAlignment = [self getAlignmentPosition:2];
        lblfield2.tag = 2;
        [cell.contentView addSubview:lblfield2];        
        
        lbldivider2.backgroundColor = [UIColor grayColor];
        lbldivider2.text= @"";
        [cell.contentView addSubview:lbldivider2];

        lblfield3.textColor = cell.textLabel.textColor;
        lblfield3.font = [UIFont systemFontOfSize:14.0f];
        lblfield3.backgroundColor = [UIColor clearColor];
        lblfield3.numberOfLines = noOfLines;
        lblfield3.textAlignment = [self getAlignmentPosition:3];
        lblfield3.tag = 3;
        [cell.contentView addSubview:lblfield3];        
        
        lbldivider3.backgroundColor = [UIColor grayColor];
        lbldivider3.text= @"";
        [cell.contentView addSubview:lbldivider3];

        lblfield4.textColor = cell.textLabel.textColor;
        lblfield4.font = [UIFont systemFontOfSize:14.0f];
        lblfield4.backgroundColor = [UIColor clearColor];
        lblfield4.numberOfLines = noOfLines;
        lblfield4.textAlignment = [self getAlignmentPosition:4];
        lblfield4.tag = 4;
        [cell.contentView addSubview:lblfield4];        
        
        lbldivider4.backgroundColor = [UIColor grayColor];
        lbldivider4.text= @"";
        [cell.contentView addSubview:lbldivider4];

        lblfield5.textColor = cell.textLabel.textColor;
        lblfield5.font = [UIFont systemFontOfSize:14.0f];
        lblfield5.backgroundColor = [UIColor clearColor];
        lblfield5.numberOfLines = noOfLines;
        lblfield5.textAlignment = [self getAlignmentPosition:5];
        lblfield5.tag = 5;
        if (lblfield5.frame.size.width>0) 
        {
            [cell.contentView addSubview:lblfield5];        
        
            lbldivider5.backgroundColor = [UIColor grayColor];
            lbldivider5.text= @"";
            [cell.contentView addSubview:lbldivider5];
        }
        btnapprove = [UIButton buttonWithType:UIButtonTypeCustom];
        btnapprove.frame = frame;
        btnapprove.backgroundColor = [UIColor clearColor];
        btnapprove.tag = 6;
        [cell.contentView addSubview:btnapprove];
    
    }
    NSDictionary* curData =(NSDictionary*) [resultData objectAtIndex:indexPath.row];
    
    lblfield1 = (UILabel*) [cell.contentView viewWithTag:1];
    lblfield1.text = [curData valueForKey:@"FIELD1"];
    if (lblfield1.textAlignment==UITextAlignmentCenter) 
        lblfield1.text =[self getValidStringForDate:[curData valueForKey:@"FIELD1"]];

    lblfield2 = (UILabel*) [cell.contentView viewWithTag:2];
    lblfield2.text = [curData valueForKey:@"FIELD2"];
    if (lblfield2.textAlignment==UITextAlignmentCenter) 
        lblfield2.text =[self getValidStringForDate:[curData valueForKey:@"FIELD2"]];
    
    lblfield3 = (UILabel*) [cell.contentView viewWithTag:3];
    lblfield3.text = [curData valueForKey:@"FIELD3"];
    if (lblfield3.textAlignment==UITextAlignmentCenter) 
        lblfield3.text =[self getValidStringForDate:[curData valueForKey:@"FIELD3"]];
    
    lblfield4 = (UILabel*) [cell.contentView viewWithTag:4];
    lblfield4.text = [curData valueForKey:@"FIELD4"] ;
    if (lblfield4.textAlignment==UITextAlignmentCenter) 
        lblfield4.text =[self getValidStringForDate:[curData valueForKey:@"FIELD4"]];
    
    lblfield5 = (UILabel*) [cell.contentView viewWithTag:5];
    if (lblfield5) 
    {
        lblfield5.text = [curData valueForKey:@"FIELD5"] ;
        if (lblfield5.textAlignment==UITextAlignmentCenter) 
            lblfield5.text =[self getValidStringForDate:[curData valueForKey:@"FIELD5"]];
    }
    
    btnapprove = (UIButton*) [cell.contentView viewWithTag:6];
    btnapprove.titleLabel.text = [[NSString alloc] initWithFormat:@"%d", indexPath.row];
    btnapprove.titleLabel.textColor = [UIColor clearColor];
    approvalFlagStr = [curData valueForKey:@"Approved"];
    if (approvalFlagStr) 
        approvalflag= [approvalFlagStr intValue];
    else
        approvalflag = 0;
    [btnapprove setBackgroundImage:approvalflag==0 ? [UIImage imageNamed:@"No.png"]:[UIImage imageNamed:@"Checkmark.png"] forState:UIControlStateNormal];
    [btnapprove addTarget:self action:@selector(checkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (NSString*) getValidStringForDate:(NSString*) dateStr
{
    NSString *retVal = [[NSString alloc] init];
    @try {
        NSString *fieldval = [[NSString alloc] init];
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"YYYY-MM-dd"];
        fieldval = [dateStr substringToIndex:10];
        NSDate *dateval = [nsdf dateFromString:fieldval];
        [nsdf setDateFormat:@"dd-MM-YYYY"];
        retVal = [nsdf stringFromDate:dateval];
    }
    @catch (NSException *exception) {
        retVal = dateStr;
    }
    @finally {
    }
    return  retVal;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [[NSString alloc] initWithString:@"."];
    return key;
}


- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

- (void) checkButtonPressed : (id) sender
{
    UIButton *btnpressed = (UIButton*) sender;
    NSMutableDictionary* curData = [[NSMutableDictionary alloc] initWithDictionary:[resultData objectAtIndex:[btnpressed.titleLabel.text intValue]]];
    int approvalflag;
    //NSLog(@"current data %@", curData);
    NSString *approvalFlagStr;
    approvalFlagStr = [curData valueForKey:@"Approved"];
    if (approvalFlagStr) 
        approvalflag= [approvalFlagStr intValue];
    else
        approvalflag = 0;
    [btnpressed setBackgroundImage:approvalflag==1 ? [UIImage imageNamed:@"No.png"]:[UIImage imageNamed:@"Checkmark.png"] forState:UIControlStateNormal];
    [curData setValue:[[NSString alloc] initWithFormat:@"%d",approvalflag==0?1:0]  forKey:@"Approved"];
    [resultData replaceObjectAtIndex:[btnpressed.titleLabel.text intValue] withObject:curData];
    //[[NSNotificaxtionCenter defaultCenter] postNotificxationName:_appDeappNotifyName object:self userInfo:curData];
    appDeappMethod(curData);
}

- (int) getXPosition :(int) lblNo
{
    NSString *keyName = [[NSString alloc] initWithFormat:@"F%d%@W",lblNo, UIInterfaceOrientationIsPortrait(intOrientation)? @"P":@"L" ];
    int xval = [[schemaDict valueForKey:keyName] intValue];
    return xval;
}

- (UITextAlignment) getAlignmentPosition:(int) lblNo
{
    UITextAlignment l_retval;
    NSString *keyName = [[NSString alloc] initWithFormat:@"F%dDT",lblNo];
    NSString *alignVal = [[NSString alloc] initWithFormat:@"%@",[schemaDict valueForKey:keyName]];
    if ([alignVal isEqualToString:@"S"]==YES) l_retval = UITextAlignmentLeft;
    if ([alignVal isEqualToString:@"D"]==YES) l_retval = UITextAlignmentCenter;
    if ([alignVal isEqualToString:@"N"]==YES) l_retval = UITextAlignmentRight;
    return  l_retval;
}

- (void) setTableViewData:(NSArray*) p_tvdata
{
    if (resultData) {
        [resultData removeAllObjects];
        //[resultData release];
    }
    resultData = [[NSMutableArray alloc] initWithArray:p_tvdata copyItems:YES];
}

- (void) updateAllApprovals:(METHODCALLBACK) p_completeReturn
{
    updateCompleteReturn = p_completeReturn;
    [self updateNextApprovalFrom:0];
}

- (void) updateNextApprovalFrom:(int) p_startNo
{
    NSString *approvalFlagStr;
    int approvalflag;
    if (p_startNo > ([resultData count]-1))
    {
        updateCompleteReturn(nil);
        return;
    }
    for (int l_counter=p_startNo; l_counter < [resultData count]; l_counter++) 
    {
        NSDictionary *tmpDict = [resultData objectAtIndex:l_counter];
        approvalFlagStr = [tmpDict valueForKey:@"Approved"];
        if (approvalFlagStr) 
            approvalflag= [approvalFlagStr intValue];
        else
            approvalflag = 0;
        if (approvalflag==1) 
        {
            //NSLog(@"the schema dictionary %@", schemaDict);
            //NSLog(@"the data dictionary %@", tmpDict);
            NSMutableDictionary *wsApproveData = [[NSMutableDictionary alloc] init];
            [wsApproveData setValue:_divcode forKey:@"p_divcode"];
            [wsApproveData setValue:@"API" forKey:@"p_compcode"];
            [wsApproveData setValue:_doccode forKey:@"p_doccode"];
            [wsApproveData setValue:_userstatus forKey:@"p_usercode"];
            [wsApproveData setValue:[NSString stringWithFormat:@"%@",[tmpDict valueForKey:@"FILED7"]] forKey:@"p_yearcode"];
            [wsApproveData setValue:[NSString stringWithFormat:@"%@",[schemaDict valueForKey:@"APPTAB1"]] forKey:@"p_apptab1"];
            [wsApproveData setValue:[NSString stringWithFormat:@"%@", [tmpDict valueForKey:@"FIELD6"]] forKey:@"p_intdocno"];
            [wsApproveData setValue:[NSString stringWithFormat:@"%@", [schemaDict valueForKey:@"TAB1INTDOC"]] forKey:@"p_tab1intdoc"];
            [wsApproveData setValue:[NSString stringWithFormat:@"%@", [schemaDict valueForKey:@"DOCLVL"]] forKey:@"p_doclvl"];
            if ([schemaDict valueForKey:@"OTHERCON"]!=nil)   
                [wsApproveData setValue:[schemaDict valueForKey:@"OTHERCON"] forKey:@"p_other"];
            else
                [wsApproveData setValue:@"" forKey:@"p_other"];
            
            if ([schemaDict valueForKey:@"USERDOCLVL"]!=nil)   
                [wsApproveData setValue:[schemaDict valueForKey:@"USERDOCLVL"] forKey: @"p_userdoclevl"];
            else
                [wsApproveData setValue:@"" forKey: @"p_userdoclevl"];
            
            [wsApproveData setValue:[NSString stringWithFormat:@"%d", l_counter] forKey:@"p_objectindex"];
            
            //NSLog(@"key input for ws %@", wsApproveData);
            [[dssWSCallsProxy alloc] initWithReportType:@"APPROVEDOCUMENT" andInputParams:wsApproveData andReturnMethod:applCompleteNotify  andReturnInputs:YES];
            return;
        }
    }
    updateCompleteReturn(nil);
}

- (void) approvalCompletionNotify:(NSDictionary*) p_completedStatus
{
    NSLog(@"received outut from service %@", p_completedStatus);
    NSMutableArray *approvalResultArray = [p_completedStatus valueForKey:@"data"];
    NSDictionary *approvalResult = [approvalResultArray objectAtIndex:0];
    NSDictionary *inputParams = [p_completedStatus valueForKey:@"inputs"];
    int l_respCode = [[approvalResult valueForKey:@"RESPONSECODE"] intValue];
    int l_objectindex = [[inputParams valueForKey:@"p_objectindex"] intValue];
    NSString *respMsg = [[NSString alloc] initWithFormat:@"%@",[approvalResult valueForKey:@"RESPONSEMESSAGE"]];
    if (l_respCode == 0)
    {
        [resultData removeObjectAtIndex:l_objectindex];
        [self updateNextApprovalFrom:l_objectindex];
    }
    else
    {
        [self showAlertMessage:respMsg];
        [self updateNextApprovalFrom:l_objectindex+1];
    }
}

@end
