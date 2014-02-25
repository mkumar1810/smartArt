//
//  custSearch.m
//  salesapi
//
//  Created by Raja T S Sekhar on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "custSearch.h"

@implementation custSearch

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andReturnMethod:(METHODCALLBACK) p_returnMethod forSalesMan:(NSString*) p_salesmancode
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"getSearch" forFrame:frame];
        intOrientation = p_intOrientation;
        _webdataName= [[NSString alloc] initWithFormat:@"%@",@"CUSTOMERSLISTFORSM"];
        _salesmancode = [[NSString alloc] initWithFormat:@"%@",p_salesmancode];
        _cacheName = [[NSString alloc] initWithFormat:@"%@_%@",@"ALLCUSTOMERS", p_salesmancode];
        _searchReturnMethod = p_returnMethod;
        [actIndicator startAnimating];
        sBar.text = @"";
        [self generateData];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andReturnMethod:(METHODCALLBACK) p_returnMethod
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"getSearch" forFrame:frame];
        intOrientation = p_intOrientation;
        _webdataName= [[NSString alloc] initWithFormat:@"%@",@"CUSTOMERSLIST"];
        _cacheName = [[NSString alloc] initWithFormat:@"%@",@"ALLCUSTOMERS"];
        _searchReturnMethod = p_returnMethod;
        [actIndicator startAnimating];
        sBar.text = @"";
        [self generateData];
    }
    return self;
}

- (void) generateData
{
    if (populationOnProgress==NO)
    {
        populationOnProgress = YES;
        NSMutableDictionary *inputDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sBar.text, @"p_searchtext",@"5000",@"p_noofrecs", @"",@"p_lastcode"  , nil];
        if (_salesmancode) 
            [inputDict setValue:_salesmancode forKey:@"p_salesmancode"];

        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self customerListDataGenerated:p_dictInfo];
        };
        if (refreshTag==1) 
        {
            [inputDict setValue:[[NSString alloc] initWithString:@""] forKey:@"p_searchtext"];
            /*if (dssWSCorecall) 
                [dssWSCorecall release];*/
            [[dssWSCallsProxy alloc] initWithReportType:_webdataName andInputParams:inputDict andReturnMethod:l_proxyReturn];
        }
        else
        {
            if ([sBar.text isEqualToString:@""]) 
            {
                NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
                if ([stdDefaults valueForKey:_cacheName]==nil) 
                {
                    [inputDict setValue:[[NSString alloc] initWithString:@""] forKey:@"p_searchtext"];
                    /*if (dssWSCorecall) 
                        [dssWSCorecall release];*/
                    [[dssWSCallsProxy alloc] initWithReportType:_webdataName andInputParams:inputDict andReturnMethod:l_proxyReturn];
                }
                else
                {
                    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
                    [returnInfo setValue:[stdDefaults valueForKey:_cacheName] forKey:@"data"];
                    //[[NSNotifixcationCenter defaultCenter] postNotifixcationName:_proxynotification object:self userInfo:returnInfo];
                    l_proxyReturn(returnInfo);
                }
            }
            else
            {
                /*if (dssWSCorecall) 
                    [dssWSCorecall release];*/
                [[dssWSCallsProxy alloc] initWithReportType:_webdataName andInputParams:inputDict andReturnMethod:l_proxyReturn];
            }
        }
        refreshTag = 0;
    }    
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation]; 
}


- (void) customerListDataGenerated:(NSDictionary *)generatedInfo
{
    if (dataForDisplay) {
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
    }
    dataForDisplay = [[NSMutableArray alloc] initWithArray:[generatedInfo valueForKey:@"data"] copyItems:YES];
    if ([sBar.text isEqualToString:@""]) 
    {
        NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
        [stdDefaults setValue:dataForDisplay forKey:_cacheName];
    }
    populationOnProgress = NO;
    [self setForOrientation:intOrientation];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void) generateTableView
{
    [super generateTableView];
    [dispTV setDelegate:self];
    [dispTV setDataSource:self];
    [dispTV reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key;
    if (UIInterfaceOrientationIsPortrait(intOrientation))
        key =  [[NSString alloc] initWithString:@"     Cust Code                       Customer Name"];
    else
        key =  [[NSString alloc] initWithString:@"     Cust Code                                              Customer Name"];
    key = [key stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
    return key;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataForDisplay count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self removeFromSuperview];
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    [returnInfo setValue:[dataForDisplay objectAtIndex:indexPath.row] forKey:@"data"];
    //[[NSNotifixcationCenter defaultCenter] postNotxificationName:_notificationName object:self userInfo:returnInfo];
    _searchReturnMethod(returnInfo);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NSDictionary *tmpDict = [dataForDisplay objectAtIndex:indexPath.row];
    UILabel *lblcode, *lbldivider, *lblname;
    NSString *custcode, *custname ;
    int labelHeight = 50;
    int labelWidth = 175;
    int dataEntryWidth = 500;
    if (UIInterfaceOrientationIsLandscape(intOrientation)) 
    {
        labelWidth = 225;
        dataEntryWidth = 686;
    }
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid];
        cell.backgroundColor=[UIColor whiteColor];
    }
    //NSLog(@"values in temp dictionary %@", tmpDict);
    
    custcode = [[[NSString alloc] initWithFormat:@"  %@", [tmpDict valueForKey:@"CD"]] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
    custname = [[[NSString alloc] initWithFormat:@"  %@", [tmpDict valueForKey:@"CN"]] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
    lblcode = [[UILabel alloc] initWithFrame:CGRectMake(4, 1, labelWidth, labelHeight-2)];
    lblcode.font = [UIFont systemFontOfSize:18.0f];
    lblcode.text = custcode;
    [lblcode setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView addSubview:lblcode];
    //[lblcode release];
    
    lbldivider = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth+4, 0, 2, labelHeight)];
    [lbldivider setBackgroundColor:[UIColor grayColor]];
    [cell.contentView addSubview:lbldivider];
    //[lbldivider release];

    lblname = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth+6, 1, dataEntryWidth, labelHeight-2)];
    lblname.font = [UIFont systemFontOfSize:18.0f];
    lblname.text = custname;
    [lblname setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView addSubview:lblname];
    //[lblname release];
    return cell;
}

- (IBAction) refreshData:(id) sender
{
    [actIndicator setHidden:NO];
    [actIndicator startAnimating];
    [dispTV removeFromSuperview];
    refreshTag = 1;
    [self generateData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [super searchBarCancelButtonClicked:searchBar];
}

// called when Search (in our case “Done”) button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [super searchBarSearchButtonClicked:searchBar];
    [self generateData];
}

- (IBAction) goBack:(id) sender
{
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    [returnInfo setValue:nil forKey:@"data"];
    //[[NSNotifxicationCenter defaultCenter] postNotifxicationName:_gobacknotifyName object:self userInfo:returnInfo];
    _searchReturnMethod(returnInfo);
}

- (void)dealloc
{
    //[super dealloc];
}

@end
