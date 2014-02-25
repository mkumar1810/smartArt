//
//  busInvColnReport.m
//  dssapi
//
//  Created by Raja T S Sekhar on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "busInvColnReport.h"

@implementation busInvColnReport

- (id) initReportForDate:(NSString*) p_fordate andDayOffset:(int) p_dayoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"busInvColnReport" forFrame:frame andBackButton:YES];
        _fordate = [[NSString alloc] initWithFormat:@"%@", p_fordate];
        _offset = p_dayoffset;
        intOrientation = p_intOrientation;
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportCoreDataGenerated:)  name:@"MISBusInvColnGenerated" object:nil];
        [actIndicator startAnimating];
        [self generateDataForOffset:0];
    }
    return self;
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation];
    if (UIInterfaceOrientationIsPortrait(p_forOrientation)) 
    {
        [constructionView setHidden:YES];
    }
    else
    {
        [constructionView setHidden:NO];
        [constructionView setFrame:CGRectMake(150 , 400, constructionView.bounds.size.width, constructionView.bounds.size.height)];
    }
    //[self generateTableView];
}

- (void) generateTableView
{
    [super generateTableView];
    [dispTV setDelegate:self];
    [dispTV setDataSource:self];
    [dispTV reloadData];
}

- (void) generateDataForOffset:(int) p_addOffset
{
    if (populationOnProgress==NO)
    {
        populationOnProgress = YES;
        _offset = _offset + p_addOffset;
        if (_offset<0) _offset = 0;
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        NSTimeInterval secondsforNdays = - (_offset+1) * 24 * 60 * 60;
        forDate.text = [nsdf stringFromDate:[[nsdf dateFromString:_fordate] dateByAddingTimeInterval:secondsforNdays]];
        /*if (misRC) [misRC release];
        misRC = [[misReportsCore alloc] initWithReportType:@"MIS_BussInvColn" andForDate:_fordate andDayoffset:_offset andNotificatioName:@"MISBusInvColnGenerated"];*/
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:_fordate, @"p_fordate",[NSString stringWithFormat:@"%d", _offset],@"p_dayoffset",@"MIS_BussInvColn",@"p_reporttype",  nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self reportCoreDataGenerated:p_dictInfo];
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISBUSSINVCOLN" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
    }
}

- (IBAction) goBack:(id) sender
{
    if (dataForDisplay) [dataForDisplay removeAllObjects];
    if (dispTV) [dispTV removeFromSuperview];
    [super goBack:sender];
}


- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo
{
    if (dataForDisplay) {
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
    }
    dataForDisplay = [[NSMutableArray alloc] initWithArray:[generatedInfo valueForKey:@"data"] copyItems:YES];
    //[actIndicator stopAnimating];
    //[self generateTableView];
    populationOnProgress = NO;
    if (_offset==0) 
        nextBtn.enabled = NO; 
    else 
        nextBtn.enabled = YES;
    [self setForOrientation:intOrientation];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //NSLog(@"drawing of rectangel view is invoked");
    [self setForOrientation:intOrientation];
}

*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger l_retval;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
        l_retval = 3;
    else
        l_retval = 4;
    return l_retval;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat l_retval;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        if (indexPath.row<2) 
            l_retval = 211.0f;
        else
            l_retval = 212.0f;
    }
    else
        l_retval = 45.0f;
    
    return  l_retval;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
        return [self getCellForPortraintOrientationForTV:tableView andRowNo:indexPath.row];
    else
        return [self getCellForLandscapeOrientation:tableView andRowNo:indexPath.row];
}

-(UITableViewCell*) getCellForLandscapeOrientation:(UITableView*) tv andRowNo:(int) rowNo
{
    static NSString *cellid = @"Cell";
    int startPoint, colwidth;
    UILabel *slLabel, *divLabel, *dataLabel;
    UIColor *dataColor;
    NSString *reqPrefix, *disptext, *columnName;
    int xStartPos;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    colwidth = 87;
    startPoint = 0;
    NSString *title;
    UITableViewCell  *cell = [tv dequeueReusableCellWithIdentifier:cellid];
    xStartPos = 2;
    if (cell==nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid] ;
    }
    switch (rowNo) 
    {
        case 0:
            cell.backgroundColor = [UIColor clearColor];
            title = [[NSString alloc] initWithString:@" Sl#       Division         Business      Invoicing      Collection        Business      Invoicing      Collection       Business      Invoicing      Collection  "]; 
            title = [title stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
            cell.textLabel.text = title;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            break;
        case 1:
            cell.backgroundColor = [self backgroundColor];
            title = [NSString stringWithFormat:@"%d",rowNo];
            slLabel = [self getDefaultlabelForLandScape:CGRectMake(xStartPos, 1 , 20, 44) andTitle:title andreqColor:[UIColor blackColor] andAlignment:0];
            slLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
            [cell.contentView addSubview:slLabel];
            //[slLabel release];
            break;
        case 2:
            cell.backgroundColor = [self backgroundColor];
            title = [NSString stringWithFormat:@"%d",rowNo];
            slLabel = [self getDefaultlabelForLandScape:CGRectMake(xStartPos, 1, 20, 44) andTitle:title andreqColor:[UIColor blackColor] andAlignment:0];
            slLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
            [cell.contentView addSubview:slLabel];
            //[slLabel release];
            break;
        case 3:
            cell.backgroundColor = [self backgroundColor];
            break;
        default:
            break;
    }        
    if (rowNo!=0) 
    {
        NSDictionary *tmpDict = [dataForDisplay objectAtIndex:rowNo-1];
        xStartPos += 20 + 2;
        if (rowNo!=3) 
            title = [tmpDict valueForKey:@"DIV_CODE"];
        else
            title = [NSString stringWithFormat:@"%@%@",[tmpDict valueForKey:@"DIV_CODE"],@":"];
        divLabel = [self getDefaultlabelForLandScape:CGRectMake(xStartPos, 1, colwidth, 44) andTitle:title andreqColor:[UIColor blackColor] andAlignment:1];
        divLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
        if (rowNo==3)
        {
            divLabel.textAlignment = UITextAlignmentRight;
            divLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            divLabel.backgroundColor = [UIColor clearColor];
        }
        [cell.contentView addSubview:divLabel];
        //[divLabel release];
        for (int l_counter=1; l_counter<10; l_counter++) 
        {
            int wholerowno = (l_counter-1) / 3;
            int wholedivider = l_counter - wholerowno * 3;
            dataColor = [UIColor yellowColor];
            switch (wholerowno) {
                case 0:
                    reqPrefix = [[NSString alloc] initWithFormat:@"%@", @"ONDATE"];
                    if (rowNo!=3)
                        dataColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0]; 
                    break;
                case 1:
                    reqPrefix = [[NSString alloc] initWithFormat:@"%@", @"MONTHDATE"];
                    if (rowNo!=3)
                        dataColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 2:
                    reqPrefix = [[NSString alloc] initWithFormat:@"%@", @"TOTALYEAR"];
                    if (rowNo!=3)
                        dataColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            switch (wholedivider) 
            {
                case 1:
                    columnName = [[NSString alloc] initWithFormat:@"%@%@", reqPrefix, @"ORDER"];
                    break;
                case 2:
                    columnName = [[NSString alloc] initWithFormat:@"%@%@", reqPrefix, @"INVOICE"];
                    break;
                case 3:
                    columnName = [[NSString alloc] initWithFormat:@"%@%@", reqPrefix, @"COLLECTION"];
                    break;
                default:
                    break;
            }
            xStartPos += colwidth + 2;
            disptext = [frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:columnName] integerValue]]];
            dataLabel = [self getDefaultlabelForLandScape:CGRectMake(xStartPos, 1, colwidth, 44) andTitle:[[NSString stringWithFormat:@"%@ ",disptext] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:2];
            [dataLabel setBackgroundColor:dataColor];
            [cell.contentView addSubview:dataLabel];
            //[dataLabel release];
        }
    }
    return cell;
}

-(UITableViewCell*) getCellForPortraintOrientationForTV:(UITableView*) tv andRowNo:(int) rowNo
{
    static NSString *cellid=@"Cell";
    UIColor *lblColor = [UIColor greenColor];
    UIColor *dataColor;
    NSString *labeltitle, *reqPrefix, *disptext;
    int startPoint, colwidth;
    UILabel *mainTitleLabel;
    UILabel *busLabel, *invLabel, *colnLabel;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    colwidth = 140;
    UITableViewCell  *cell = [tv dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid] ;
    }
    switch (rowNo) {
        case 0:
            labeltitle = [[NSString alloc] initWithFormat:@"%@", @"On \n Date"];
            reqPrefix = [[NSString alloc] initWithFormat:@"%@", @"ONDATE"];
            cell.backgroundColor = [UIColor yellowColor];
            dataColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
            break;
        case 1:
            labeltitle = [[NSString alloc] initWithFormat:@"%@", @"Month \n To \n Date "];
            reqPrefix = [[NSString alloc] initWithFormat:@"%@", @"MONTHDATE"];
            cell.backgroundColor = [UIColor yellowColor];
            dataColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
            break;
        case 2:
            labeltitle = [[NSString alloc] initWithFormat:@"%@", @"Year \n To \n Date "];
            reqPrefix = [[NSString alloc] initWithFormat:@"%@", @"TOTALYEAR"];
            cell.backgroundColor = [UIColor yellowColor];
            dataColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
            break;
        default:
            break;
    }
    mainTitleLabel = [self getDefaultlabel:CGRectMake(1, 1, 110, 209) andTitle:labeltitle andreqColor:cell.textLabel.textColor andAlignment:0];
    [mainTitleLabel setBackgroundColor:cell.backgroundColor];
    [cell.contentView addSubview:mainTitleLabel];
    //[mainTitleLabel release];
    
    busLabel = [self getDefaultlabel:CGRectMake(112, 1, colwidth, 69) andTitle:[[NSString stringWithFormat:@"    %@",  @"Business"] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:1];
    [busLabel setBackgroundColor:lblColor];
    [cell.contentView addSubview:busLabel];
    //[busLabel release];
    
    invLabel = [self getDefaultlabel:CGRectMake(112, 71, colwidth, 69) andTitle:[[NSString stringWithFormat:@"    %@",  @"Invoice"] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:1];
    [invLabel setBackgroundColor:lblColor];
    [cell.contentView addSubview:invLabel];
    //[invLabel release];
    
    colnLabel = [self getDefaultlabel:CGRectMake(112, 141, colwidth, 69) andTitle:[[NSString stringWithFormat:@"    %@",  @"Collection"] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:1];
    [colnLabel setBackgroundColor:lblColor];
    [cell.contentView addSubview:colnLabel];
    //[colnLabel release];
    
    for (NSDictionary *tmpDict in dataForDisplay) 
    {
        NSString *divcode = [tmpDict valueForKey:@"DIV_CODE"];
        if ([divcode isEqualToString:@"Al Ahli Plastic"]==YES) startPoint = 253;
        if ([divcode isEqualToString:@"Al Ahli Flexible"]==YES) startPoint = 394;
        if ([divcode isEqualToString:@"TOTAL"]==YES) 
        {
            startPoint = 535;
            colwidth = 142;
        }
        
        disptext = [frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:[NSString stringWithFormat:@"%@ORDER",reqPrefix]] integerValue]]];
        
        busLabel = [self getDefaultlabel:CGRectMake(startPoint, 1, colwidth, 69) andTitle:[[NSString stringWithFormat:@"%@ ",disptext] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:2];
        [busLabel setBackgroundColor:dataColor];
        [cell.contentView addSubview:busLabel];
        //[busLabel release];
        
        disptext = [frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:[NSString stringWithFormat:@"%@INVOICE",reqPrefix]] integerValue]]];
        invLabel = [self getDefaultlabel:CGRectMake(startPoint, 71, colwidth, 69) andTitle:[[NSString stringWithFormat:@"%@ ",disptext] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:2];
        [invLabel setBackgroundColor:dataColor];
        [cell.contentView addSubview:invLabel];
        //[invLabel release];
        
        disptext = [frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:[NSString stringWithFormat:@"%@COLLECTION",reqPrefix]] integerValue]]];
        colnLabel = [self getDefaultlabel:CGRectMake(startPoint, 141, colwidth, 69) andTitle:[[NSString stringWithFormat:@"%@ ",disptext] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:2];
        [colnLabel setBackgroundColor:dataColor];
        [cell.contentView addSubview:colnLabel];
       // [colnLabel release];
    }
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key;
    if (UIInterfaceOrientationIsPortrait(intOrientation))
        key =  [[NSString alloc] initWithString:@"                                                               API                    FLX               TOTAL"];
    else
        key=   [[NSString alloc] initWithString:@"                                              On Date                               Month to Date                           Year to Date"];
    key = [key stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
    return key;
}

- (void)dealloc
{
    //[super dealloc];
}

@end
