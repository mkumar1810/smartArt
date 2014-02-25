//
//  misSalesManMonthly.m
//  dssapi
//
//  Created by Raja T S Sekhar on 4/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "misSalesManMonthly.h"


@implementation misSalesManMonthly

- (id) initReportForDayOffset:(int) p_Dayoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addNIBView:@"misSalesManMonthly" forFrame:frame andBackButton:YES];
        _offset = p_Dayoffset;
        intOrientation = p_intOrientation;
        //[[NSNotificxationCenter defaultCenter] addObserver:self selector:@selector(reportCoreDataGenerated:)  name:@"MISSalesManMonthlyGenerated" object:nil];
        [actIndicator startAnimating];
        [self generateDataForOffset:0];
    }
    return self;    
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation];
}

- (void) generateTableView
{
    [super generateTableView];
    [dispTV setBackgroundColor:[navidataview backgroundColor]];
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
        forMonth.text = [self getOffsetMonthForDisp];
        /*if (misRC) [misRC release];
        misRC = [[misReportsCore alloc] initWithReportType:@"MIS_BussInvSalesManwiseMonthly" andForMonthOffset:_offset andNotificationName:@"MISSalesManMonthlyGenerated"];*/
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self reportCoreDataGenerated:p_dictInfo];
        };
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", _offset],@"p_monthoffset",@"MIS_BussInvSalesManwiseMonthly",@"p_reporttype",  nil];
        [[dssWSCallsProxy alloc] initWithReportType:@"MISBUSSINVSMDAILY" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
    }
}

- (IBAction) goBack:(id) sender
{
    if (dataForDisplay) [dataForDisplay removeAllObjects];
    if (dispTV) [dispTV removeFromSuperview];
    [super goBack:sender];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo
{
    if (dataForDisplay) {
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
    }
    dataForDisplay = [[NSMutableArray alloc] initWithArray:[generatedInfo valueForKey:@"data"] copyItems:YES];
    populationOnProgress = NO;
    if (_offset==0) 
        nextBtn.enabled = NO; 
    else 
        nextBtn.enabled = YES;
    [self setForOrientation:intOrientation];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataForDisplay count] + 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  30.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int maxRecordNo;
    NSDictionary *tmpDict;
    maxRecordNo = [dataForDisplay count] + 1;
    if (indexPath.row != maxRecordNo) 
    {
        switch (indexPath.row) {
            case 0:
                return [self getMainHeaderCellforTV:tableView];
                break;
            case 1:
                return [self getSecondHeaderCellforTV:tableView];
                break;
            default:
                tmpDict = [dataForDisplay objectAtIndex:indexPath.row-2];
                return [self getDetailCell:tmpDict forTV:tableView inRowNo:indexPath.row];
                //NSLog(@"the tmp dict values %@",tmpDict);
                break;
        }
    }
    else
    {
        tmpDict = [dataForDisplay objectAtIndex:indexPath.row-2];
        return [self getTotalSummaryCell:tmpDict forTV:tableView];
    }
    return  nil;
}

- (UITableViewCell*) getDetailCell:(NSDictionary*) p_dataDict forTV:(UITableView*) p_TV inRowNo:(int) p_rowNo
{
    static NSString *cellid=@"CellDetail";
    int lblTextAlignment;
    int colWidth, xPosition,slWidth, xWidth;
    NSString *lblTitle;
    UIColor *dataColor;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    UILabel *lblData;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth = 79;
        slWidth = 25;
        [frm setMaximumFractionDigits:0];
    }
    else
    {
        colWidth = 107;
        slWidth = 36;
        [frm setMaximumFractionDigits:2];
    }
    UITableViewCell  *cell = [p_TV dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        [cell setBackgroundColor:[UIColor whiteColor]];
        xPosition = 2;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            lblTextAlignment = 2;
            xWidth = colWidth;
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    lblTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo - 1]; 
                    dataColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    lblTextAlignment = 0;
                    break;
                case 1:
                    xWidth = 2*colWidth+2;
                    lblTitle = [[NSString alloc] initWithFormat:@"%@",[p_dataDict valueForKey:@"SALESMANNAME"]];
                    dataColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    lblTextAlignment = 1;
                    break;
                case 2:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMPLASTICORDER"] integerValue]]];
                    dataColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 3:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMFLEXORDER"] integerValue]]];
                    dataColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 4:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMTOTALORDER"] integerValue]]];
                    dataColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 5:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMPLASTICINV"] integerValue]]];
                    dataColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                case 6:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMFLXINV"] integerValue]]];
                    dataColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                case 7:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMTOTINVOICE"] integerValue]]];
                    dataColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            lblData = [self getDefaultlabel:CGRectMake(xPosition, 2, xWidth, 28) andTitle:[[NSString stringWithFormat:@"%@ ",lblTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:lblTextAlignment];
            lblData.font = [UIFont systemFontOfSize:11.0f];;
            [lblData setBackgroundColor:dataColor];
            lblData.tag = 100 + _lblNo;
            xPosition +=  xWidth + 2;
            [cell.contentView addSubview:lblData];
            //[lblData release];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    lblTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo - 1]; 
                    break;
                case 1:
                    lblTitle = [[NSString alloc] initWithFormat:@"%@",[p_dataDict valueForKey:@"SALESMANNAME"]];
                    break;
                case 2:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMPLASTICORDER"] integerValue]]];
                    break;
                case 3:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMFLEXORDER"] integerValue]]];
                    break;
                case 4:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMTOTALORDER"] integerValue]]];
                    break;
                case 5:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMPLASTICINV"] integerValue]]];
                    break;
                case 6:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMFLXINV"] integerValue]]];
                    break;
                case 7:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SUMTOTINVOICE"] integerValue]]];
                    break;
                default:
                    break;
            }
            lblData = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblData.text = lblTitle;
        }
    }
    return cell;
}


- (UITableViewCell*) getSecondHeaderCellforTV:(UITableView*) p_TV
{
    static NSString *cellid=@"CellHeader2";
    int colWidth, xPosition,slWidth, xWidth;
    NSString *lblTitle;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    UILabel *lblData;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth = 79;
        slWidth = 25;
    }
    else
    {
        colWidth = 107;
        slWidth = 36;
    }
    UITableViewCell  *cell = [p_TV dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        [cell setBackgroundColor:[UIColor whiteColor]];
        xPosition = 2;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            xWidth = colWidth;
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    lblTitle = [[NSString alloc] initWithString:@"Sl#"];
                    break;
                case 1:
                    xWidth = 2*colWidth + 2;
                    lblTitle = [[NSString alloc] initWithString:@"Salesman Name"];
                    break;
                case 2:
                    lblTitle = [[NSString alloc] initWithString:@"Plastic"];
                    break;
                case 3:
                    lblTitle = [[NSString alloc] initWithString:@"Flexible"];
                    break;
                case 4:
                    lblTitle = [[NSString alloc] initWithString:@"Total"];
                    break;
                case 5:
                    lblTitle = [[NSString alloc] initWithString:@"Plastic"];
                    break;
                case 6:
                    lblTitle = [[NSString alloc] initWithString:@"Flexible"];
                    break;
                case 7:
                    lblTitle = [[NSString alloc] initWithString:@"Total"];
                    break;
                default:
                    break;
            }
            lblData = [self getDefaultlabel:CGRectMake(xPosition, 2, xWidth, 28) andTitle:lblTitle andreqColor:cell.textLabel.textColor andAlignment:0];
            lblData.font = [UIFont boldSystemFontOfSize:12.0f];
            [lblData setBackgroundColor:[navidataview backgroundColor]];
            xPosition +=  xWidth + 2;
            [cell.contentView addSubview:lblData];
            //[lblData release];
        }
    }
    return cell;
}


- (UITableViewCell*) getMainHeaderCellforTV:(UITableView*) p_TV
{
    static NSString *cellid=@"CellHeader1";
    int colWidth, xPosition,slWidth, xWidth;
    NSString *lblTitle;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    UILabel *lblData;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth = 79;
        slWidth = 25;
    }
    else
    {
        colWidth = 107;
        slWidth = 36;
    }
    UITableViewCell  *cell = [p_TV dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        [cell setBackgroundColor:[UIColor whiteColor]];
        xPosition = 2;
        xPosition = 2;
        for (int _lblNo = 0; _lblNo<4; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    lblTitle = [[NSString alloc] initWithString:@""];
                    break;
                case 1:
                    xWidth = 2*colWidth+2;
                    lblTitle = [[NSString alloc] initWithString:@""];
                    break;
                case 2:
                    xWidth = 3*colWidth+4;
                    lblTitle = [[NSString alloc] initWithString:@"Business"];
                    break;
                case 3:
                    xWidth = 3*colWidth+4;
                    lblTitle = [[NSString alloc] initWithString:@"Invoicing"];
                    break;
                default:
                    break;
            }
            lblData = [self getDefaultlabel:CGRectMake(xPosition, 2, xWidth, 28) andTitle:lblTitle andreqColor:cell.textLabel.textColor andAlignment:0];
            lblData.font = [UIFont boldSystemFontOfSize:12.0f];
            [lblData setBackgroundColor:[navidataview backgroundColor]];
            xPosition +=  xWidth + 2;
            [cell.contentView addSubview:lblData];
            //[lblData release];
        }
    }
    return cell;
}


- (UITableViewCell*) getTotalSummaryCell:(NSDictionary*) p_totalDict forTV:(UITableView*) p_TV
{
    static NSString *cellid=@"CellTotal";
    NSString *lblTitle;
    UIColor *dataColor;
    UILabel *lblData;
    int lblTextAlignment;
    int colWidth, xPosition, slWidth, xWidth, maxRecordNo;
    maxRecordNo = [dataForDisplay count] + 1;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth = 79;
        slWidth = 25;
        [frm setMaximumFractionDigits:0];
    }
    else
    {
        colWidth = 107;
        slWidth = 36;
        [frm setMaximumFractionDigits:2];
    }
    UITableViewCell  *cell = [p_TV dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        [cell setBackgroundColor:[UIColor whiteColor]];
        xPosition = 0;
        for (int _lblNo = 0; _lblNo<7; _lblNo++) 
        {
            dataColor = [UIColor yellowColor];
            lblTextAlignment = 2;
            xWidth = colWidth;
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth  + colWidth*2 + 6 ;
                    lblTitle = [[NSString alloc] initWithFormat:@"%@ : ",[self getValidStringForDate:[p_totalDict valueForKey:@"SALESMANNAME"]]];
                    dataColor = [navidataview backgroundColor];
                    break;
                case 1:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMPLASTICORDER"] integerValue]]];
                    break;
                case 2:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMFLEXORDER"] integerValue]]];
                    break;
                case 3:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMTOTALORDER"] integerValue]]];
                    break;
                case 4:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMPLASTICINV"] integerValue]]];
                    break;
                case 5:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMFLXINV"] integerValue]]];
                    break;
                case 6:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMTOTINVOICE"] integerValue]]];
                    break;
                default:
                    break;
            }
            lblData = [self getDefaultlabel:CGRectMake(xPosition, 2, xWidth, 28) andTitle:[[NSString stringWithFormat:@"%@ ",lblTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:lblTextAlignment];
            lblData.font = [UIFont boldSystemFontOfSize:12.0f];
            [lblData setBackgroundColor:dataColor];
            lblData.tag = 100 + _lblNo;
            xPosition +=  xWidth + 2;
            [cell.contentView addSubview:lblData];
            //[lblData release];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<7; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    lblTitle = [[NSString alloc] initWithFormat:@"%@ : ",[self getValidStringForDate:[p_totalDict valueForKey:@"SALESMANNAME"]]];
                    break;
                case 1:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMPLASTICORDER"] integerValue]]];
                    break;
                case 2:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMFLEXORDER"] integerValue]]];
                    break;
                case 3:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMTOTALORDER"] integerValue]]];
                    break;
                case 4:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMPLASTICINV"] integerValue]]];
                    break;
                case 5:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMFLXINV"] integerValue]]];
                    break;
                case 6:
                    lblTitle = [frm stringFromNumber:[NSNumber numberWithInteger:[[p_totalDict valueForKey:@"SUMTOTINVOICE"] integerValue]]];
                    break;
                default:
                    break;
            }
            lblData = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblData.text = lblTitle;
        }
    }
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    //[super dealloc];
}


@end
