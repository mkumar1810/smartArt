//
//  yearSelect.m
//  dssapi
//
//  Created by Imac DOM on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "yearSelect.h"

@implementation yearSelect

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andReturnMethod:(METHODCALLBACK) p_returnMethod
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"getSearch" forFrame:frame];
        intOrientation = p_intOrientation;
        //[[NSNotifixcationCenter defaultCenter] addObserver:self selector:@selector(categoryListDataGenerated:)  name:@"yearListGenerated" object:nil];
        //_notificationName = [[NSString alloc] initWithFormat:@"%@",p_notification];
        _yearSelectReturn = p_returnMethod;
        [actIndicator startAnimating];
        sBar.text = @"";
        sBar.hidden = YES;
        [navTitle setTitle:@"Select a Year"];
        [self generateData];
    }
    return self;
}

- (void) generateData
{
    if (populationOnProgress==NO)
    {
        populationOnProgress = YES;
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys: nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self yearListDataGenerated:p_dictInfo];
        };
        if (refreshTag==1) 
        {
            /*if (dssWSCorecall) 
                [dssWSCorecall release];*/
            [[dssWSCallsProxy alloc] initWithReportType:@"YEARLIST" andInputParams:inputDict andReturnMethod:l_proxyReturn];
            
        }
        else
        {
            NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
            if ([stdDefaults valueForKey:@"ALLYEARS"]==nil) 
            {
                /*if (dssWSCorecall) 
                    [dssWSCorecall release];*/
                [[dssWSCallsProxy alloc] initWithReportType:@"YEARLIST" andInputParams:inputDict andReturnMethod:l_proxyReturn];
            }
            else
            {
                NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
                [returnInfo setValue:[stdDefaults valueForKey:@"ALLYEARS"] forKey:@"data"];
                //[[NSNotificxationCenter defaultCenter] postNotixficationName:@"yearListGenerated" object:self userInfo:returnInfo];
                l_proxyReturn(returnInfo);
            }
        }
        refreshTag = 0;
    }    
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation]; 
}


- (void) yearListDataGenerated:(NSDictionary *)generatedInfo
{
    if (dataForDisplay) {
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
    }
    dataForDisplay = [[NSMutableArray alloc] initWithArray:[generatedInfo valueForKey:@"data"] copyItems:YES];
    if ([sBar.text isEqualToString:@""]) 
    {
        NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
        [stdDefaults setValue:dataForDisplay forKey:@"ALLYEARS"];
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
        key =  [[NSString alloc] initWithString:@"                Select a Year "];
    else
        key =  [[NSString alloc] initWithString:@"                              Select a Year  "];
    key = [key stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
    return key;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"yyyy"];
    int yearValue = [[nsdf stringFromDate:[NSDate date]] intValue] - indexPath.row;
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    [returnInfo setValue:[[NSString alloc] initWithFormat:@"%d",yearValue] forKey:@"data"];
    //[[NSNotificxationCenter defaultCenter] postNotixficationName:_notificationName object:self userInfo:returnInfo];
    _yearSelectReturn(returnInfo);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"yyyy"];
    int yearValue = [[nsdf stringFromDate:[NSDate date]] intValue] - indexPath.row;
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid];
        cell.backgroundColor=[UIColor whiteColor];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:21.0f];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"   %d",yearValue];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
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
    //[[NSNotifixcationCenter defaultCenter] postNotixficationName:_notificationName object:self userInfo:returnInfo];
    _yearSelectReturn(returnInfo);
}

- (void)dealloc
{
    //[super dealloc];
}

@end
