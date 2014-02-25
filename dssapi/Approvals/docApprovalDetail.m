//
//  docApprovalDetail.m
//  dssapi
//
//  Created by Raja T S Sekhar on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "docApprovalDetail.h"


@implementation docApprovalDetail

- (id) initWithDivCode:(NSString*) p_divcode andDocCode:(NSString*) p_doccode andDocNo:(NSString*) p_docno andDocDesc:(NSString*) p_docDesc andMainDocDict:(NSDictionary*) p_docDict
{
    self =[super init];
    if (self) {
        _divcode = p_divcode;
        _doccode =p_doccode;
        _docno = p_docno;
        _docdesc = p_docDesc;
        schemaDict = [[[NSDictionary alloc] initWithDictionary:p_docDict] mutableCopy];
        resultData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) setinterfaceOrientation:(UIInterfaceOrientation) p_intOrientation 
{
    //resultData = [[NSMutableArray alloc] init];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Executing ceeforrowindex path");
    static NSString *cellid=@"Cell";
    UILabel  *lblfield1, *lblfield2, *lblfield3, *lblfield4, *lblfield5;    
    UILabel *lbldivider0, *lbldivider1, *lbldivider2, *lbldivider3, *lbldivider4; //, *lbldivider5;    
    //UIImage *notapproveimage = [UIImage imageNamed:@"No.png"];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    int xPosition, xWidth, yHeight;
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid];
        cell.backgroundColor=[UIColor clearColor];
        
        if (UIInterfaceOrientationIsPortrait(intOrientation)) 
            yHeight = 60;
        else
            yHeight = 30;
        
        xPosition = 0;
        xWidth = 1;
        
        lbldivider0 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        lbldivider0.backgroundColor = [UIColor grayColor];
        lbldivider0.text= @"";
        [cell.contentView addSubview:lbldivider0];
        
        xPosition += xWidth + 2;
        xWidth = [self getXPositionSub:1];
        lblfield1 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        lblfield1.textColor = cell.textLabel.textColor;
        lblfield1.font = [UIFont systemFontOfSize:14.0f];
        lblfield1.backgroundColor = [UIColor clearColor];
        lblfield1.textAlignment = [self getAlignmentPosition:1];
        lblfield1.tag = 1;
        lblfield1.numberOfLines = 2;
        [cell.contentView addSubview:lblfield1];        
        
        xPosition += xWidth + 2;
        xWidth = 1;
        lbldivider1 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        lbldivider1.backgroundColor = [UIColor grayColor];
        lbldivider1.text= @"";
        [cell.contentView addSubview:lbldivider1];
        
        xPosition += xWidth + 2;
        xWidth = [self getXPositionSub:2];
        lblfield2 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        lblfield2.textColor = cell.textLabel.textColor;
        lblfield2.font = [UIFont systemFontOfSize:14.0f];
        lblfield2.backgroundColor = [UIColor clearColor];
        lblfield2.textAlignment = [self getAlignmentPosition:2];
        lblfield2.tag = 2;
        lblfield2.numberOfLines = 2;
        [cell.contentView addSubview:lblfield2];        
        
        xPosition += xWidth + 2;
        xWidth = 1;
        lbldivider2 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        lbldivider2.backgroundColor = [UIColor grayColor];
        lbldivider2.text= @"";
        [cell.contentView addSubview:lbldivider2];
        
        xPosition += xWidth + 2;
        xWidth = [self getXPositionSub:3];
        lblfield3 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        lblfield3.textColor = cell.textLabel.textColor;
        lblfield3.font = [UIFont systemFontOfSize:14.0f];
        lblfield3.backgroundColor = [UIColor clearColor];
        lblfield3.textAlignment = [self getAlignmentPosition:3];
        lblfield3.tag = 3;
        lblfield3.numberOfLines = 2;
        [cell.contentView addSubview:lblfield3];        
        
        xPosition += xWidth + 2;
        xWidth = 1;
        lbldivider3 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        lbldivider3.backgroundColor = [UIColor grayColor];
        lbldivider3.text= @"";
        [cell.contentView addSubview:lbldivider3];
        
        xPosition += xWidth + 2;
        xWidth = [self getXPositionSub:4];
        
        lblfield4 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
        lblfield4.textColor = cell.textLabel.textColor;
        lblfield4.font = [UIFont systemFontOfSize:14.0f];
        lblfield4.backgroundColor = [UIColor clearColor];
        lblfield4.textAlignment = [self getAlignmentPosition:4];
        lblfield4.tag = 4;
        lblfield4.numberOfLines = 2;
        if (lblfield4.frame.size.width>0) 
        {
            [cell.contentView addSubview:lblfield4];        
            
            xPosition += xWidth + 2;
            xWidth = 1;
            lbldivider4 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
            lbldivider4.backgroundColor = [UIColor grayColor];
            lbldivider4.text= @"";
            [cell.contentView addSubview:lbldivider4];
            
            xPosition += xWidth + 2;
            xWidth = [self getXPositionSub:5];
            lblfield5 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, 0, xWidth, yHeight)];
            lblfield5.textColor = cell.textLabel.textColor;
            lblfield5.font = [UIFont systemFontOfSize:14.0f];
            lblfield5.backgroundColor = [UIColor clearColor];
            lblfield5.textAlignment = [self getAlignmentPosition:5];
            lblfield5.tag = 5;
            lblfield5.numberOfLines = 2;
            [cell.contentView addSubview:lblfield5];        
        }
        
        
        /*xPosition += xWidth + 2;
        xWidth = 1;
        lbldivider5 = [[UILabel alloc] initWithFrame:CGRectMake(xPosition,0, xWidth, yHeight)];
        lbldivider5.backgroundColor = [UIColor grayColor];
        lbldivider5.text= @"";
        [cell.contentView addSubview:lbldivider5];*/
        //cell.accessoryView.frame = frame;
        //cell.accessoryView = btnapprove;
        
        //[cell setAccessoryType:UITableViewCellAccessoryCheckmark];    
        
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
    lblfield3.text = [curData valueForKey:@"FIELD3"] ;
    if (lblfield3.textAlignment==UITextAlignmentCenter) 
        lblfield3.text =[self getValidStringForDate:[curData valueForKey:@"FIELD3"]];
    
    lblfield4 = (UILabel*) [cell.contentView viewWithTag:4];
    if (lblfield4) 
    {
        lblfield4.text = [curData valueForKey:@"FIELD4"] ;
        if (lblfield4.textAlignment==UITextAlignmentCenter) 
            lblfield4.text =[self getValidStringForDate:[curData valueForKey:@"FIELD4"]];
        
        lblfield5 = (UILabel*) [cell.contentView viewWithTag:5];
        lblfield5.text = [curData valueForKey:@"FIELD5"] ;
        if (lblfield5.textAlignment==UITextAlignmentCenter) 
            lblfield5.text =[self getValidStringForDate:[curData valueForKey:@"FIELD5"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //NSString *key = [[NSString alloc] initWithFormat:@"Details for %@ : %@ ",_docdesc,_docno] ;
    NSString *key = [[NSString alloc] initWithString:@"."] ;
    return key;
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}


- (int) getXPositionSub :(int) subLblNo
{
    NSString *keyName = [[NSString alloc] initWithFormat:@"F%dS%@W",subLblNo, UIInterfaceOrientationIsPortrait(intOrientation)? @"P":@"L" ];
    int xval = [[schemaDict valueForKey:keyName] intValue];
    return xval;
}

- (UITextAlignment) getAlignmentPosition:(int) lblNo
{
    UITextAlignment l_retval;
    NSString *keyName = [[NSString alloc] initWithFormat:@"F%dSDT",lblNo];
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

@end
