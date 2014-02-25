//
//  misPurchaseSalesImpExp.m
//  dssapi
//
//  Created by Imac DOM on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "misPurchaseSalesImpExp.h"

@implementation misPurchaseSalesImpExp

- (id) initReportForYearOffset:(int) p_yearoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"misBaseReport" forFrame:frame andBackButton:YES];
        _offset = p_yearoffset;
        intOrientation = p_intOrientation;
        //[[NSNotifixcationCenter defaultCenter] addObserver:self selector:@selector(reportCoreDataGenerated:)  name:@"MISPurchSalesImpExpGenerated" object:nil];
        [navTitle setTitle:@"Purchase & Sales With Imp/Exp"];
        [actIndicator startAnimating];
        showScroll = YES;
        scrollWidth = 1400;
        scrollHeight = 500;
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
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", _offset],@"p_offset",@"MIS_PurchaseSalesImpExp",@"p_reporttype",  nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self reportCoreDataGenerated:p_dictInfo];
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISPURCHSALESIMPEXP" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataForDisplay count]/2 + 1;
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
    static NSString *cellid=@"Cell";
    UILabel *lblTitle;
    NSString *strTitle;
    int txtAlign = 2;
    UIColor *lblBackColor;
    BOOL addDivider;
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    int colWidth, xPosition,  xWidth, colHeight;
    NSDictionary *tmpDict;
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    frm.negativePrefix = @"-";
    frm.negativeSuffix = @"";
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
        colWidth= 90;
    else
        colWidth= 90;
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid] ;
    }
    addDivider = YES;
    //if (indexPath.row != maxRecordNo) 
    {
        switch (indexPath.row) 
        {
            case 0:
                xPosition = 2;
                colHeight = 45;
                for (int _lblNo = 0; _lblNo<14; _lblNo++) 
                {
                    switch (_lblNo) {
                        case 0:
                            xWidth = 2*colWidth;
                            strTitle = [[NSString alloc] initWithString:@"Type"];
                            break;
                        case 1:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"January"];
                            break;
                        case 2:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"February"];
                            break;
                        case 3:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"March"];
                            break;
                        case 4:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"April"];
                            break;
                        case 5:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"May"];
                            break;
                        case 6:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"June"];
                            break;
                        case 7:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"July"];
                            break;
                        case 8:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"August"];
                            break;
                        case 9:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"September"];
                            break;
                        case 10:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"October"];
                            break;
                        case 11:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"November"];
                            break;
                        case 12:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"December"];
                            break;
                        case 13:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithString:@"Total"];
                            break;
                        default:
                            break;
                    }
                    lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth, colHeight) andTitle:strTitle andreqColor:cell.textLabel.textColor andAlignment:0];
                    lblTitle.font = [UIFont boldSystemFontOfSize:11.0f];
                    [lblTitle setBackgroundColor:[navidataview backgroundColor]];
                    xPosition +=  xWidth ;
                    [cell.contentView addSubview:lblTitle];
                    //[lblTitle release];
                }
                break;
            default:
                tmpDict = [dataForDisplay objectAtIndex:(indexPath.section*3 + indexPath.row-1)];
                xPosition = 2;
                colHeight = 30;
                for (int _lblNo = 0; _lblNo<14; _lblNo++) 
                {
                    txtAlign = 2;
                    [frm setMaximumFractionDigits:0];
                    switch (_lblNo) {
                        case 0:
                            addDivider = NO;
                            xWidth = 2*colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@" %@",[tmpDict valueForKey:@"TYPES"]];
                            txtAlign = 1;
                            lblBackColor = [UIColor greenColor]; 
                            break;
                        case 1:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"JANUARY"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                            break;
                        case 2:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"FEBRUARY"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                            break;
                        case 3:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"MARCH"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                            break;
                        case 4:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"APRIL"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                            break;
                        case 5:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"MAY"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                        case 6:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"JUNE"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                        case 7:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"JULY"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                        case 8:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"AUGUST"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                        case 9:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"SEPTEMBER"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:200.0f/255.0f green:115.0f/255.0f blue:185.0f/255.0f alpha:1.0];
                        case 10:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"OCTOBER"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:200.0f/255.0f green:115.0f/255.0f blue:185.0f/255.0f alpha:1.0];
                        case 11:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"NOVEMBER"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:200.0f/255.0f green:115.0f/255.0f blue:185.0f/255.0f alpha:1.0];
                        case 12:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@  ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"DECEMBER"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:200.0f/255.0f green:115.0f/255.0f blue:185.0f/255.0f alpha:1.0];
                        case 13:
                            xWidth = colWidth;
                            strTitle = [[NSString alloc] initWithFormat:@"%@: ",[frm stringFromNumber:[NSNumber numberWithInteger:[[tmpDict valueForKey:@"TOTAL"] integerValue]]]];
                            lblBackColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                            
                            break;
                        default:
                            break;
                    }
                    if (indexPath.row==3 & _lblNo!=0) 
                        lblBackColor = [UIColor yellowColor];

                    if (indexPath.row==3 & _lblNo==0) 
                    {
                        strTitle = [[NSString alloc] initWithFormat:@"%@: ",@"TOTAL"];
                        lblBackColor = [navidataview backgroundColor];
                        txtAlign = 2;
                    }
                    lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth-1, colHeight) andTitle:[[NSString stringWithFormat:@"%@ ",strTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:txtAlign];
                    lblTitle.font = [UIFont systemFontOfSize:11.0f];
                    [lblTitle setBackgroundColor:lblBackColor];
                    xPosition +=  xWidth +1;
                    [cell.contentView addSubview:lblTitle];
                    //[lblTitle release];
                }
                break;
        }
    }
    return cell;
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
