//
//  misCreditorAgeing.m
//  dssapi
//
//  Created by Imac DOM on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "misCreditorAgeing.h"

@implementation misCreditorAgeing

- (id) initCreditorAgeingReportWithFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"misBaseReport" forFrame:frame andBackButton:YES];
        intOrientation = p_intOrientation;
        hideNaviDataView = YES;
        sortedDispRecs = [[NSMutableArray alloc] init ];
       // [[NSNotifxicationCenter defaultCenter] addObserver:self selector:@selector(reportCoreDataGenerated:)  name:@"MISCreditorAgeingGenerated" object:nil];
        [navTitle setTitle:@"Creditor Ageing"];
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
        [nsdf setDateFormat:@"yyyy"];
        newForDate.text = [[NSString alloc] initWithFormat:@"%d",[[nsdf stringFromDate:[NSDate date]] integerValue] - _offset ];
        [dateLabel setText:@"For Year"];
        /*NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"MIS_DebtorAgeing",@"p_reporttype",  nil];
         [[dssWSCallsProxy alloc] initWithReportType:@"MISDEBTORAGEING" andInputParams:inputDict andNotificatioName:@"MISDebtorAgeingGenerated" andReturnInputs:NO];*/
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self reportCoreDataGenerated:p_dictInfo];
        };
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"MIS_CreditorAgeing",@"p_reporttype",  nil];
        [[dssWSCallsProxy alloc] initWithReportType:@"MISCREDITORAGEING" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
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
        // Initialization code
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataForDisplay count] + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float l_returnval;
    if (indexPath.row==0) 
        l_returnval = 45.0f;
    else
        l_returnval = 30.0f;
    return  l_returnval;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    int maxRecordNo;
    NSDictionary *tmpDict;
    maxRecordNo = [dataForDisplay count] ;
    switch (indexPath.row) 
    {
        case 0:
            return [self getHeaderCellforTableView:tableView];
            break;
        default:
            tmpDict = [dataForDisplay objectAtIndex:indexPath.row-1];
            if (indexPath.row == maxRecordNo) 
                return [self getSummaryCell:tableView andData:tmpDict];
            else
                return [self getDetailCell:tableView andData:tmpDict forRowNo:indexPath.row];                
            break;
    }
    return nil;
}

- (UITableViewCell*) getDetailCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict forRowNo:(int) p_rowNo
{
    static NSString *cellid=@"CellDetail";
    UILabel *lblTitle;
    NSString *strTitle;
    int txtAlign = 2;
    UIColor *lblBackColor;
    BOOL addDivider;
    UITableViewCell  *cell = [p_dispTV dequeueReusableCellWithIdentifier:cellid];
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    int colWidth, xPosition, slWidth, smWidth, xWidth, colHeight,maxRecordNo;
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:2];
    NSNumber *totalValue;
    colHeight = 30;
    maxRecordNo = [dataForDisplay count] ;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        colWidth= 90;
        slWidth = 33;
        smWidth = 110;
    }
    else
    {
        colWidth= 120;
        slWidth = 43;
        smWidth = 146;
    }
    if(cell == nil) 
    {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        xPosition = 2;
        colHeight = 30;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            txtAlign = 2;
            switch (_lblNo) {
                case 0:
                    addDivider = NO;
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo];
                    txtAlign = 0;
                    lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                    break;
                case 1:
                    xWidth = colWidth-30;
                    strTitle = [[NSString alloc] initWithFormat:@"%@ ",[p_dataDict valueForKey:@"SLEDCODE"]];
                    txtAlign = 1;
                    lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                    break;
                case 2:
                    xWidth = smWidth+30;
                    strTitle = [[NSString alloc] initWithFormat:@"%@ ",[p_dataDict valueForKey:@"SLEDDESC"]];
                    txtAlign = 1;
                    lblBackColor = [UIColor whiteColor];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P1"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P2"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P3"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 6:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P4"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:225.0f/255.0f green:180.0f/255.0f blue:165.0f/255.0f alpha:1.0];
                    break;
                case 7:
                    xWidth = colWidth;
                    totalValue = [NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P1"] doubleValue] + [[p_dataDict valueForKey:@"P2"] doubleValue] + [[p_dataDict valueForKey:@"P3"] doubleValue] + [[p_dataDict valueForKey:@"P4"] doubleValue] - [[p_dataDict valueForKey:@"PDC"] doubleValue]];
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:totalValue]];
                    lblBackColor = [UIColor colorWithRed:175.0f/255.0f green:205.0f/255.0f blue:215.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth-1, colHeight) andTitle:[[NSString stringWithFormat:@"%@ ",strTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:txtAlign];
            lblTitle.font = [UIFont systemFontOfSize:11.0f];
            [lblTitle setBackgroundColor:lblBackColor];
            lblTitle.tag = 100 + _lblNo;
            xPosition +=  xWidth +1;
            [cell.contentView addSubview:lblTitle];
        }
    }
    else
    {
        xPosition = 2;
        colHeight = 30;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            txtAlign = 2;
            switch (_lblNo) {
                case 0:
                    strTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo];
                    break;
                case 1:
                    strTitle = [[NSString alloc] initWithFormat:@"%@ ",[p_dataDict valueForKey:@"SLEDCODE"]];
                    break;
                case 2:
                    strTitle = [[NSString alloc] initWithFormat:@"%@ ",[p_dataDict valueForKey:@"SLEDDESC"]];
                    break;
                case 3:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P1"] doubleValue]]]];
                    break;
                case 4:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P2"] doubleValue]]]];
                    break;
                case 5:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P3"] doubleValue]]]];
                    break;
                case 6:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P4"] doubleValue]]]];
                    break;
                case 7:
                    totalValue = [NSNumber numberWithDouble:[[p_dataDict valueForKey:@"P1"] doubleValue] + [[p_dataDict valueForKey:@"P2"] doubleValue] + [[p_dataDict valueForKey:@"P3"] doubleValue] + [[p_dataDict valueForKey:@"P4"] doubleValue] - [[p_dataDict valueForKey:@"PDC"] doubleValue]];
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:totalValue]];
                    break;
                default:
                    break;
            }
            lblTitle = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblTitle.text = strTitle;
        }
    }
    return cell;
}

- (UITableViewCell*) getSummaryCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict
{
    static NSString *cellid=@"CellSummary";
    UILabel *lblTitle;
    NSString *strTitle;
    int txtAlign = 2;
    UIColor *lblBackColor;
    UITableViewCell  *cell = [p_dispTV dequeueReusableCellWithIdentifier:cellid];
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    int colWidth, xPosition, slWidth, smWidth, xWidth, colHeight;
    NSDictionary *tmpDict;
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:2];
    NSNumber *totalValue;
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        colWidth= 90;
        slWidth = 33;
        smWidth = 110;
    }
    else
    {
        colWidth= 120;
        slWidth = 43;
        smWidth = 146;
    }
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        xPosition = 2;
        colHeight = 30;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            txtAlign = 2;
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithString:@""];
                    lblBackColor = [navidataview backgroundColor];
                    break;
                case 1:
                    xWidth = colWidth-30;
                    strTitle = [[NSString alloc] initWithString:@""];
                    txtAlign = 2;
                    lblBackColor = [navidataview backgroundColor];
                    break;
                case 2:
                    xWidth = smWidth+30;
                    strTitle = [[NSString alloc] initWithFormat:@"%@: ",[tmpDict valueForKey:@"SLEDDESC"]];
                    txtAlign = 2;
                    lblBackColor = [navidataview backgroundColor];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P1"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P2"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P3"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 6:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P4"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:225.0f/255.0f green:180.0f/255.0f blue:165.0f/255.0f alpha:1.0];
                    break;
                case 7:
                    xWidth = colWidth;
                    totalValue = [NSNumber numberWithDouble:[[tmpDict valueForKey:@"P1"] doubleValue] + [[tmpDict valueForKey:@"P2"] doubleValue] + [[tmpDict valueForKey:@"P3"] doubleValue] + [[tmpDict valueForKey:@"P4"] doubleValue] - [[tmpDict valueForKey:@"PDC"] doubleValue]];
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:totalValue]];
                    lblBackColor = [UIColor colorWithRed:175.0f/255.0f green:205.0f/255.0f blue:215.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth-1, colHeight) andTitle:[[NSString stringWithFormat:@"%@ ",strTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:txtAlign];
            lblTitle.font = [UIFont systemFontOfSize:11.0f];
            [lblTitle setBackgroundColor:lblBackColor];
            lblTitle.tag = 100 + _lblNo;
            xPosition +=  xWidth +1;
            [cell.contentView addSubview:lblTitle];
            //[lblTitle release];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    strTitle = [[NSString alloc] initWithString:@""];
                    break;
                case 1:
                    strTitle = [[NSString alloc] initWithString:@""];
                    break;
                case 2:
                    strTitle = [[NSString alloc] initWithFormat:@"%@: ",[tmpDict valueForKey:@"SLEDDESC"]];
                    break;
                case 3:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P1"] doubleValue]]]];
                    break;
                case 4:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P2"] doubleValue]]]];
                    break;
                case 5:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P3"] doubleValue]]]];
                    break;
                case 6:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithDouble:[[tmpDict valueForKey:@"P4"] doubleValue]]]];
                    break;
                case 7:
                    totalValue = [NSNumber numberWithDouble:[[tmpDict valueForKey:@"P1"] doubleValue] + [[tmpDict valueForKey:@"P2"] doubleValue] + [[tmpDict valueForKey:@"P3"] doubleValue] + [[tmpDict valueForKey:@"P4"] doubleValue] - [[tmpDict valueForKey:@"PDC"] doubleValue]];
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:totalValue]];
                    break;
                default:
                    break;
            }
            lblTitle = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblTitle.text = strTitle;
            //[lblTitle release];
        }
    }
    return cell;
}

- (UITableViewCell*) getHeaderCellforTableView:(UITableView*) p_dispTV;
{
    static NSString *cellid=@"CellHeader";
    UILabel *lblTitle;
    UIButton *btnSorting;
    NSString *strTitle;
    UITableViewCell  *cell = [p_dispTV dequeueReusableCellWithIdentifier:cellid];
    int colWidth, xPosition, slWidth, smWidth, xWidth, colHeight,maxRecordNo;
    colHeight = 30;
    maxRecordNo = [dataForDisplay count] ;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        colWidth= 90;
        slWidth = 33;
        smWidth = 110;
    }
    else
    {
        colWidth= 120;
        slWidth = 43;
        smWidth = 146;
    }
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        xPosition = 2;
        colHeight = 45;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithString:@"Sl"];
                    break;
                case 1:
                    xWidth = colWidth-30;
                    strTitle = [[NSString alloc] initWithString:@"Code"];
                    break;
                case 2:
                    xWidth = smWidth+30;
                    strTitle = [[NSString alloc] initWithString:@"Customer"];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"0-30"];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"31-60"];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"61-90"];
                    break;
                case 6:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"91 Above"];
                    break;
                case 7:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Total"];
                    break;
                default:
                    break;
            }
            if (_lblNo==1 | _lblNo ==2) 
            {
                btnSorting = [[UIButton alloc] initWithFrame:CGRectMake(xPosition+1, 2, xWidth-2, colHeight-4)];
                btnSorting.titleLabel.font = [UIFont boldSystemFontOfSize:11.0f]; 
                [btnSorting setTitle:strTitle forState:UIControlStateNormal];
                [btnSorting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnSorting setBackgroundColor:[navidataview backgroundColor]];
                [btnSorting addTarget:self action:@selector(performSortingByColumn:) forControlEvents:UIControlEventTouchDown];
                [cell.contentView addSubview:btnSorting];
                //[btnSorting release];
            }
            else
            {
                lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth, colHeight) andTitle:strTitle andreqColor:cell.textLabel.textColor andAlignment:0];
                lblTitle.font = [UIFont boldSystemFontOfSize:11.0f];
                [lblTitle setBackgroundColor:[navidataview backgroundColor]];
                [cell.contentView addSubview:lblTitle];
                //[lblTitle release];
            }
            xPosition +=  xWidth ;
        }
    }
    return cell;
}

- (void) performSortingByColumn:(id) sender
{
    UIButton *btnRecd = (UIButton*) sender;
    int tagval = btnRecd.tag;
    switch (tagval) {
        case 1:
            orderColumn = [NSString stringWithFormat:@"%@",@"SLEDCODE"];
            isAscending = !isAscending;
            break;
        case 2:
            orderColumn = [NSString stringWithFormat:@"%@",@"SLEDDESC"];
            isAscending = !isAscending;
            break;
        case 7:
            orderColumn = [NSString stringWithFormat:@"%@",@"TOTAL"];
            isAscending = !isAscending;
            break;
        default:
            break;
    }
    [sortedDispRecs removeAllObjects];
    //[sortedDispRecs release];
    if ([dataForDisplay count]>0) 
    {
        NSDictionary *totalData = [dataForDisplay objectAtIndex:[dataForDisplay count]-1];
        [dataForDisplay removeLastObject];
        NSSortDescriptor *sortingDesc =  [[NSSortDescriptor alloc] initWithKey:orderColumn ascending:isAscending selector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray *sortArray = [NSArray arrayWithObjects:sortingDesc, nil];
        [dataForDisplay sortUsingDescriptors:sortArray];
        sortedDispRecs = [[NSMutableArray alloc] initWithArray:dataForDisplay copyItems:YES];
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
        dataForDisplay = [[NSMutableArray alloc] initWithArray:sortedDispRecs copyItems:YES];
        [dataForDisplay addObject:totalData];
    }
    [self generateTableView];
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
