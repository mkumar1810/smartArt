//
//  CPTestApp_iPadViewController.m
//  CPTestApp-iPad
//
//  Created by Brad Larson on 4/1/2010.
//

#import "mainDashBoard.h"

@implementation mainDashBoard

@synthesize bottomScroll,topView, bottomLeftView, bottomCenterView, bottomRightView;
@synthesize dbbard, dbscd, dbBarSalColn, dbpd;

const CGFloat kScrollObjWidth = 378.0;
const CGFloat kScrollObjHeight = 330.0;

- (void) initialize
{
    //[[NSNotificxationCenter defaultCenter] removeOxbserver:self];
    //[[NSNotificaxxxtionCenter defaultCenter] addObserver:self selector:@selector(ChartDataGenerated:) name:@"ChartDataGenerated" object:nil];
    __block id myself = self;
    _chartDataGenerate = ^(NSDictionary* p_dictInfo)
    {
        [myself ChartDataGenerated:p_dictInfo];
    };
    [bottomScroll setClipsToBounds:YES];
    [bottomScroll setCanCancelContentTouches:NO];
    bottomScroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults valueForKey:@"PLOTLAYOUTOPTIONS"]==nil ) {
        if (!plotLayOptions) {
            plotLayOptions = [[NSMutableDictionary alloc] init];
            [plotLayOptions setValue:@"T" forKey:@"LC"];
            [plotLayOptions setValue:@"BL" forKey:@"PIE"];
            [plotLayOptions setValue:@"BC" forKey:@"BARSC"];
            [plotLayOptions setValue:@"BR" forKey:@"BAR"];
        }
        if (!topChart) 
            topChart = [[NSString alloc] initWithString:@"LC"];
        [standardUserDefaults setObject:plotLayOptions forKey:@"PLOTLAYOUTOPTIONS"];
        [standardUserDefaults setObject:topChart forKey:@"TOPCHART"];
    }
    else
    {
        plotLayOptions = [[NSMutableDictionary alloc] initWithDictionary:[standardUserDefaults valueForKey:@"PLOTLAYOUTOPTIONS"]];
        topChart = [[NSString alloc] initWithFormat:@"%@",[standardUserDefaults valueForKey:@"TOPCHART"]];
    }
    fullScreenMode = NO;
    
    dbbard = [[dbBarDelegates alloc] initWithGraphObject:newbarchart andViewPOS:[plotLayOptions valueForKey:@"BAR"] andMonthOffset:0 andChart:@"BAR" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
    dbBarSalColn = [[dbBarSalesCollectionDelegates alloc] initWithGraphObject:barSalColnChart andViewPOS:[plotLayOptions valueForKey:@"BARSC"] andMonthOffset:0 andChart:@"BARSC" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
    dbscd = [[dbScatterDelegates alloc] initWithGraphObject:linegraph andViewPOS:[plotLayOptions valueForKey:@"LC"] andMonthOffset:0 andChart:@"LC" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
    dbpd = [[dbPieDelegates alloc] initWithGraphObject:piechart andViewPOS:[plotLayOptions valueForKey:@"PIE"] andMonthOffset:0 andChart:@"PIE" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
    initialized = YES;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self initialize];
        initialized = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
        initialized = YES;
    }
    return self;
}

#pragma mark -r
#pragma mark Initialization and teardown

- (void)viewDidLoad 
{
   // NSLog(@"viewdidload is called for this");
    actIndicator.hidesWhenStopped = TRUE;
    actIndicator.transform = CGAffineTransformMakeScale(5.00, 5.00);        
    [actIndicator startAnimating];
    noofGraphsGenerated = 0;
    noofReqdRefresh = 4;
    [actIndicator startAnimating];
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) 
        prevOrientation = UIInterfaceOrientationLandscapeLeft;
    else
        prevOrientation = UIInterfaceOrientationPortrait;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) 
        currOrientation = UIInterfaceOrientationPortrait ;
    else
        currOrientation = UIInterfaceOrientationLandscapeLeft;
    [self initialize];
    [self addPreviousNextButtons];
    [super viewDidLoad];
    [self setChartAndScrollForOrientation:self.interfaceOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    currOrientation = toInterfaceOrientation;
    if (fullScreenMode==YES) 
    {
        [self setFSReadjustmentForOrientation:toInterfaceOrientation];
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) 
            prevOrientation = UIInterfaceOrientationLandscapeLeft;
        else
            prevOrientation = UIInterfaceOrientationPortrait;
        noofGraphsGenerated = 0;
        noofReqdRefresh = 4;
        [self setChartAndScrollForOrientation:toInterfaceOrientation];
        [dbscd swapChartToView:[self getViewToHostForChart:@"LC"]  andViewPosition:[plotLayOptions valueForKey:@"LC"] withOrientation:currOrientation];
        [dbpd swapChartToView:[self getViewToHostForChart:@"PIE"]  andViewPosition:[plotLayOptions valueForKey:@"PIE"] withOrientation:currOrientation];
        [dbBarSalColn swapChartToView:[self getViewToHostForChart:@"BARSC"]  andViewPosition:[plotLayOptions valueForKey:@"BARSC"] withOrientation:currOrientation];
        [dbbard swapChartToView:[self getViewToHostForChart:@"BAR"]  andViewPosition:[plotLayOptions valueForKey:@"BAR"] withOrientation:currOrientation];

        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) 
            [[self.view viewWithTag:-1] setFrame:CGRectMake(60,10,30,30)];
        else
            [[self.view viewWithTag:-1] setFrame:CGRectMake(720,10,30,30)];
        [self setPreviousNextButtonStatuses];
        [self createRefreshButtons];
    }
}

- (void) setChartAndScrollForOrientation:(UIInterfaceOrientation) intOrientation
{
    if (intOrientation == prevOrientation) return;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        //NSLog(@"setchartandscroll for orientation for portrait");
        [topView setFrame:CGRectMake(5, 44, 755, 494)];
        [bottomScroll setFrame:CGRectMake(0, 526, 1140, 421)];
        [self layoutScrollImages:intOrientation];
        bottomScroll.showsHorizontalScrollIndicator = YES;
        bottomScroll.alwaysBounceHorizontal = YES;
        bottomScroll.showsVerticalScrollIndicator = NO;
        bottomScroll.alwaysBounceVertical = NO;
    }
    else
    {
        //NSLog(@"setchartandscroll for orientation for landscape");
        [topView setFrame:CGRectMake(5, 50, 632, 659)];
        [bottomScroll setFrame:CGRectMake(633, 44, 378, 1000)];
        [self layoutScrollImages:intOrientation];
        bottomScroll.showsHorizontalScrollIndicator = NO;
        bottomScroll.alwaysBounceHorizontal = NO;
        bottomScroll.showsVerticalScrollIndicator = YES;
        bottomScroll.alwaysBounceVertical = YES;
    }
    prevOrientation = intOrientation;
}

- (void) layoutScrollImages:(UIInterfaceOrientation) intOrientation
{
    if (fullScreenMode==YES) return;
	UIView *view = nil;
	NSArray *subviews = [bottomScroll subviews];
	CGFloat curXLoc = 5;
    CGFloat curYLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[CPTGraphHostingView class]])
		{
            if (UIInterfaceOrientationIsPortrait(intOrientation)==YES)
            {
                CGRect frame = view.frame;
                if ([view isEqual:bottomLeftView]==YES) curXLoc = 0;
                if ([view isEqual:bottomCenterView]==YES) curXLoc = kScrollObjWidth;
                if ([view isEqual:bottomRightView]==YES) curXLoc = 2*kScrollObjWidth;
                frame.origin = CGPointMake(curXLoc, 0);
                frame.size = CGSizeMake(kScrollObjWidth, 421);
                view.frame = frame;
                //curXLoc += (kScrollObjWidth);
            }
            else
            {
                CGRect frame = view.frame;
                if ([view isEqual:bottomLeftView]==YES) curYLoc = 0;
                if ([view isEqual:bottomCenterView]==YES) curYLoc = kScrollObjHeight;
                if ([view isEqual:bottomRightView]==YES) curYLoc = 2*kScrollObjHeight;
                frame.origin = CGPointMake(0, curYLoc);
                frame.size = CGSizeMake(378, kScrollObjHeight);
                view.frame = frame;
                //curYLoc += (kScrollObjHeight);
            }
		}
	}
	// set the content size so it can be scrollable
    if (UIInterfaceOrientationIsPortrait(intOrientation)==YES)
        [bottomScroll setContentSize:CGSizeMake((4 * kScrollObjWidth), [bottomScroll bounds].size.height)];
    else
        [bottomScroll setContentSize:CGSizeMake([bottomScroll bounds].size.width, 4 * kScrollObjHeight)];
        
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    //NSLog(@"viewdidunload is called");
    //[[NSNotificationCenter defaultCenter] removeOxbserver:self];
    //if (dbscd) [dbscd release];
    //if (dbpd) [dbpd release];
    //if (dbBarSalColn) [dbBarSalColn release];
    //if (dbbard) [dbbard release];
    //[leftButton release];
    //[rightButton release];
}

- (void)dealloc 
{
    //NSLog(@"viewcontroller dealloc is called");
    //[[NSNotificationCenter defaultCenter] removexObserver:self];
    //if (dbscd) [dbscd release];
    //if (dbpd) [dbpd release];
    //if (dbBarSalColn) [dbBarSalColn release];
    //if (dbbard) [dbbard release];
    //[super dealloc];
}

#pragma mark -
#pragma mark Plot construction methods

- (void) ChartDataGenerated : (NSDictionary*) chartGenInfo
{
    
    //baseChart *recdDelegate = [recdItems valueForKey:@"ChartDelegate"];
    NSString *chartType = [chartGenInfo valueForKey:@"ChartType"];
    //[self removeButtonsFromChart:chartType];
    
    //[self setChartAndScrollForOrientation:self.interfaceOrientation];
    //[recdDelegate generateGraphComplete];
    if ( [chartGenInfo valueForKey:@"LocalGraph"]!=nil) 
    {
        [self getViewToHostForChart:chartType].hostedGraph = [chartGenInfo valueForKey:@"LocalGraph"];
        [self setActivityIndicatorProperly];
    }
}

- (IBAction) refreshCharts : (id) sender
{
    noofGraphsGenerated=0;
    noofReqdRefresh =4;
    [actIndicator startAnimating];
    [self reLoadChartForTag:1001];
    [self reLoadChartForTag:1002];
    [self reLoadChartForTag:1003];
    [self reLoadChartForTag:1004];
    
}

- (void) setActivityIndicatorProperly
{
    noofGraphsGenerated++;
    
    if (noofGraphsGenerated>=noofReqdRefresh) {
        [actIndicator stopAnimating];
        actIndicator.hidden=TRUE;
        noofReqdRefresh = 0;
        noofGraphsGenerated = 0;
        [self setPreviousNextButtonStatuses];
        [self createRefreshButtons];
    }
}


- (void) createRefreshButtons
{
    [self addButtonsToChart:@"LC" andTag:1001];
    [self addButtonsToChart:@"PIE" andTag:1002];
    [self addButtonsToChart:@"BARSC" andTag:1003];
    [self addButtonsToChart:@"BAR" andTag:1004];
}

- (IBAction) prevNextOffsetTopChart:(id) sender
{
    //baseChart *bc;
    UIButton *sendBtn = (UIButton*) sender;
    int monthOffset = sendBtn.tag;
    int refreshBtnTag;
    if (fullScreenMode==NO) {
        if ([topChart isEqualToString:@"LC"]) refreshBtnTag = 1001;
        if ([topChart isEqualToString:@"PIE"]) refreshBtnTag = 1002;
        if ([topChart isEqualToString:@"BARSC"]) refreshBtnTag = 1003;
        if ([topChart isEqualToString:@"BAR"]) refreshBtnTag = 1004;
    }
    else
    {
        if ([fullScreenChart isEqualToString:@"LC"]) refreshBtnTag = 1001;
        if ([fullScreenChart isEqualToString:@"PIE"]) refreshBtnTag = 1002;
        if ([fullScreenChart isEqualToString:@"BARSC"]) refreshBtnTag = 1003;
        if ([fullScreenChart isEqualToString:@"BAR"]) refreshBtnTag = 1004;
    }
    [self reLoadChartForTag:refreshBtnTag withOffsetval:monthOffset];
}

- (IBAction) refreshParticularChart:(id) sender
{
    UIButton *sendBtn = (UIButton*) sender;
    int tagValue = sendBtn.tag;
    noofGraphsGenerated=0;
    noofReqdRefresh += 1;
    [self reLoadChartForTag:tagValue];
}

- (IBAction) swapParticularChartToTop:(id) sender
{
    UIButton *sendBtn = (UIButton*) sender;
    int tagValue = sendBtn.tag;
    switch (tagValue) {
        case 2001:
            [self swapToTopFromChart:@"LC"];
            [dbscd swapChartToView:[self getViewToHostForChart:@"LC"] andViewPosition:@"T" withOrientation:currOrientation];
            break;
        case 2002:
            [self swapToTopFromChart:@"PIE"];
            [dbpd swapChartToView:[self getViewToHostForChart:@"PIE"] andViewPosition:@"T" withOrientation:currOrientation];
            break;
        case 2003:
            [self swapToTopFromChart:@"BARSC"];
            [dbBarSalColn swapChartToView:[self getViewToHostForChart:@"BARSC"] andViewPosition:@"T" withOrientation:currOrientation];
            break;
        case 2004:
            [self swapToTopFromChart:@"BAR"];
            [dbbard swapChartToView:[self getViewToHostForChart:@"BAR"] andViewPosition:@"T" withOrientation:currOrientation];
            break;
        default:
            break;
    }
    [self setPreviousNextButtonStatuses];
    [self createRefreshButtons];
}

- (void) swapToTopFromChart:(NSString*) fromChart;
{
    NSString *curView = [[NSString alloc] init];
    NSString *curtopView = [[NSString alloc] initWithFormat:@"%@",topChart];
    curView = [plotLayOptions valueForKey:fromChart];
    //NSLog(@"before swapping dictionary %@", plotLayOptions);
    [self removeButtonsFromChart:fromChart];
    [self removeButtonsFromChart:topChart];
    [plotLayOptions setValue:@"T" forKey:fromChart];
    [plotLayOptions setValue:curView forKey:topChart];
    topChart= [[NSString alloc] initWithString:fromChart];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:plotLayOptions forKey:@"PLOTLAYOUTOPTIONS"];
    [standardUserDefaults setObject:topChart forKey:@"TOPCHART"];
    //NSLog(@"after swapping dictionary %@", plotLayOptions);
    if ([curtopView isEqualToString:@"LC"]) 
        //[self refreshTheSwapedViewChartType:@"LC" andViewTag:1001 andBaseChart:dbscd andToPos:curView];
        [dbscd swapChartToView:[self getViewToHostForChart:@"LC"] andViewPosition:curView withOrientation:currOrientation];
    
    if ([curtopView isEqualToString:@"PIE"]) 
        //[self refreshTheSwapedViewChartType:@"PIE" andViewTag:1002 andBaseChart:dbpd andToPos:curView];
        [dbpd swapChartToView:[self getViewToHostForChart:@"PIE"] andViewPosition:curView withOrientation:currOrientation];

    if ([curtopView isEqualToString:@"BARSC"]) 
        //[self refreshTheSwapedViewChartType:@"BARSC" andViewTag:1003 andBaseChart:dbBarSalColn andToPos:curView];
        [dbBarSalColn swapChartToView:[self getViewToHostForChart:@"BARSC"] andViewPosition:curView withOrientation:currOrientation];

    if ([curtopView isEqualToString:@"BAR"]) 
        //[self refreshTheSwapedViewChartType:@"BAR" andViewTag:1004 andBaseChart:dbbard andToPos:curView];
        [dbbard swapChartToView:[self getViewToHostForChart:@"BAR"] andViewPosition:curView withOrientation:currOrientation];
}


- (void) reLoadChartForTag:(int) tagValue
{
    [self reLoadChartForTag:tagValue withOffsetval:0];
}

- (void) reLoadChartForTag:(int) tagValue withOffsetval:(int) monthOffset
{
    int currentOffset, newOffset;
    if (tagValue==1001) 
    {
        [self removeButtonsFromChart:@"LC"];
        if (dbscd) 
        {
            currentOffset = [dbscd getCurrentOffset];
            //[dbscd release];
        }
        newOffset = currentOffset + monthOffset;
        if (fullScreenMode==NO) 
            dbscd = [[dbScatterDelegates alloc] initWithGraphObject:linegraph andViewPOS:[plotLayOptions valueForKey:@"LC"] andMonthOffset:newOffset andChart:@"LC" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
        else
            dbscd = [[dbScatterDelegates alloc] initWithGraphObject:linegraph andViewPOS:@"F" andMonthOffset:newOffset andChart:@"LC" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
            
        return;
    }
    if (tagValue==1002) 
    {
        [self removeButtonsFromChart:@"PIE"];
        if (dbpd) 
        {
            currentOffset = [dbpd getCurrentOffset];
            //[dbpd release];
        }
        newOffset = currentOffset + monthOffset;
        if (fullScreenMode==NO) 
            dbpd = [[dbPieDelegates alloc] initWithGraphObject:piechart andViewPOS:[plotLayOptions valueForKey:@"PIE"] andMonthOffset:newOffset andChart:@"PIE" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
        else
            dbpd = [[dbPieDelegates alloc] initWithGraphObject:piechart andViewPOS:@"F" andMonthOffset:newOffset andChart:@"PIE" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
            
        return;
    }
    if (tagValue==1003) 
    {
        [self removeButtonsFromChart:@"BARSC"];
        if (dbBarSalColn) 
        {
            currentOffset = [dbBarSalColn getCurrentOffset];
            //[dbBarSalColn release];
        }
        newOffset = currentOffset + monthOffset;
        if (fullScreenMode==NO) 
            dbBarSalColn = [[dbBarSalesCollectionDelegates alloc] initWithGraphObject:barSalColnChart andViewPOS:[plotLayOptions valueForKey:@"BARSC"] andMonthOffset:newOffset andChart:@"BARSC" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
        else
            dbBarSalColn = [[dbBarSalesCollectionDelegates alloc] initWithGraphObject:barSalColnChart andViewPOS:@"F" andMonthOffset:newOffset andChart:@"BARSC" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
            
        return;
    }
    if (tagValue==1004) 
    {
        [self removeButtonsFromChart:@"BAR"];
        if (dbbard) 
        {
            currentOffset = [dbbard getCurrentOffset];
            //[dbbard release];
        }
        newOffset = currentOffset + monthOffset;
        if (fullScreenMode==NO) 
            dbbard = [[dbBarDelegates alloc] initWithGraphObject:newbarchart andViewPOS:[plotLayOptions valueForKey:@"BAR"] andMonthOffset:newOffset andChart:@"BAR" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
        else
            dbbard = [[dbBarDelegates alloc] initWithGraphObject:newbarchart andViewPOS:@"F" andMonthOffset:newOffset andChart:@"BAR" withOrientation:currOrientation andDataGenerateMethod:_chartDataGenerate];
            
        return;
    }
}

- (CPTGraphHostingView*) getViewToHostForChart:(NSString*) chartType
{
    NSString *chartViewName = [plotLayOptions valueForKey:chartType];
    if ([chartViewName isEqualToString:@"T"]) return topView;
    if ([chartViewName isEqualToString:@"BL"]) return bottomLeftView;
    if ([chartViewName isEqualToString:@"BC"]) return bottomCenterView;
    if ([chartViewName isEqualToString:@"BR"]) return bottomRightView;
    return nil;
}

- (void) addButtonsToChart:(NSString*) chartType andTag:(int) tagValue
{
    BOOL addFullScreenbtn;
    CPTGraphHostingView *tmpView = [self getViewToHostForChart:chartType];
    UIButton *btnRefresh = (UIButton*)  [tmpView viewWithTag:tagValue];
    if (btnRefresh) [btnRefresh removeFromSuperview];
    UIImage *refreshImage = [UIImage imageNamed:@"refresh.png"];
    CGRect btnRefreshframe = CGRectMake(20, tmpView.frame.size.height- 30 , 20, 20);
    btnRefresh = [[UIButton alloc] initWithFrame:btnRefreshframe];
    btnRefresh.backgroundColor = [UIColor darkGrayColor];
    [btnRefresh setImage:refreshImage forState:UIControlStateNormal];
    [btnRefresh addTarget:self action:@selector(refreshParticularChart:) forControlEvents:UIControlEventTouchDown];
    btnRefresh.tag = tagValue;
    [tmpView addSubview:btnRefresh];
    
    addFullScreenbtn = YES;
    if (fullScreenMode==YES) 
    {
        if ([fullScreenChart isEqualToString:chartType]) 
        {
            addFullScreenbtn = NO;
        }
    }
    UIButton *btnRestore = (UIButton*)  [tmpView viewWithTag:tagValue+3000];
    if (btnRestore) [btnRestore removeFromSuperview];
    UIButton *btnFullscreen = (UIButton*)  [tmpView viewWithTag:tagValue+2000];
    if (btnFullscreen) [btnFullscreen removeFromSuperview];
    CGRect btnfullscreenframe = CGRectMake(50, tmpView.frame.size.height- 30 , 20, 20);
    if (addFullScreenbtn==YES) 
    {
        UIImage *fullscreenImage = [UIImage imageNamed:@"fullscreenicon.PNG"];
        btnFullscreen = [[UIButton alloc] initWithFrame:btnfullscreenframe];
        btnFullscreen.backgroundColor = [UIColor darkGrayColor];
        [btnFullscreen setImage:fullscreenImage forState:UIControlStateNormal];
        [btnFullscreen addTarget:self action:@selector(makeFullScreen:) forControlEvents:UIControlEventTouchDown];
        btnFullscreen.tag = tagValue+2000;
        [tmpView addSubview:btnFullscreen];
    }
    else
    {
        UIImage *restoreImage = [UIImage imageNamed:@"restoreicon.PNG"];
        btnRestore = [[UIButton alloc] initWithFrame:btnfullscreenframe];
        btnRestore.backgroundColor = [UIColor darkGrayColor];
        [btnRestore setImage:restoreImage forState:UIControlStateNormal];
        [btnRestore addTarget:self action:@selector(restoreOldMode:) forControlEvents:UIControlEventTouchDown];
        btnRestore.tag = tagValue+3000;
        [tmpView addSubview:btnRestore];
    }
    
    UIButton *btnSwap = (UIButton*) [tmpView viewWithTag:tagValue+1000];
    if (btnSwap) [btnSwap removeFromSuperview];
    if (fullScreenMode==NO) 
    {
        if ([chartType isEqualToString:topChart]==NO) 
        {
            UIImage *swapImage = [UIImage imageNamed:@"maximize1.png"];
            CGRect btnSwapframe = CGRectMake(tmpView.frame.size.width - 40.0, tmpView.frame.size.height- 30 , 20, 20);
            btnSwap = [[UIButton alloc] initWithFrame:btnSwapframe];
            btnSwap.backgroundColor = [UIColor darkGrayColor];
            [btnSwap setImage:swapImage forState:UIControlStateNormal];
            [btnSwap addTarget:self action:@selector(swapParticularChartToTop:) forControlEvents:UIControlEventTouchDown];
            btnSwap.tag = tagValue+1000;
            [tmpView addSubview:btnSwap];
        }
    }
}

- (void) addPreviousNextButtons
{
    
    UIImage *leftbuttonImage = [UIImage imageNamed:@"previous.png"];
    UIImage *rightbuttonImage = [UIImage imageNamed:@"Next.png"];

    leftButton =(UIButton*) [self.view viewWithTag:1];
    if (!leftButton)  
    {
        
        leftButton = [[UIButton alloc] initWithFrame:CGRectMake(15,10,30,30)];
        leftButton.titleLabel.text=@"Previous";
        leftButton.tag = 1;
        [leftButton setImage:leftbuttonImage forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(prevNextOffsetTopChart:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:leftButton];
    }
    
    rightButton =(UIButton*) [self.view viewWithTag:-1];
    if (!rightButton) 
    {
        if (UIInterfaceOrientationIsPortrait(currOrientation)==YES)
            rightButton = [[UIButton alloc] initWithFrame:CGRectMake(720,10,30,30)];
        else
            rightButton = [[UIButton alloc] initWithFrame:CGRectMake(60,10,30,30)];
        rightButton.titleLabel.text=@"Next";
        rightButton.tag = -1;
        [rightButton setImage:rightbuttonImage forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(prevNextOffsetTopChart:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:rightButton];
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(currOrientation)==YES)
            [rightButton setFrame:CGRectMake(720,10,30,30)];
        else
            [rightButton setFrame:CGRectMake(60,10,30,30)];
    }
}


- (void) removeButtonsFromChart:(NSString*) chartType
{
    if ([chartType isEqualToString:@"LC"]==YES) 
    {
        [[[self getViewToHostForChart:@"LC"] viewWithTag:1001] removeFromSuperview];
        [[[self getViewToHostForChart:@"LC"] viewWithTag:2001] removeFromSuperview];
        [[[self getViewToHostForChart:@"LC"] viewWithTag:3001] removeFromSuperview];
        [[self getViewToHostForChart:@"LC"].hostedGraph removeFromSuperlayer];
        
        return;
    }
    if ([chartType isEqualToString:@"PIE"]==YES) 
    {
        [[[self getViewToHostForChart:@"PIE"] viewWithTag:1002] removeFromSuperview];
        [[[self getViewToHostForChart:@"PIE"] viewWithTag:2002] removeFromSuperview];
        [[[self getViewToHostForChart:@"PIE"] viewWithTag:3002] removeFromSuperview];
        [[self getViewToHostForChart:@"PIE"].hostedGraph removeFromSuperlayer];
        return;
    }
    if ([chartType isEqualToString:@"BARSC"]==YES) 
    {
        [[[self getViewToHostForChart:@"BARSC"] viewWithTag:1003] removeFromSuperview];
        [[[self getViewToHostForChart:@"BARSC"] viewWithTag:2003] removeFromSuperview];
        [[[self getViewToHostForChart:@"BARSC"] viewWithTag:3003] removeFromSuperview];
        [[self getViewToHostForChart:@"BARSC"].hostedGraph removeFromSuperlayer];
        return;
    }
    if ([chartType isEqualToString:@"BAR"]==YES) 
    {
        [[[self getViewToHostForChart:@"BAR"] viewWithTag:1004] removeFromSuperview];
        [[[self getViewToHostForChart:@"BAR"] viewWithTag:2004] removeFromSuperview];
        [[[self getViewToHostForChart:@"BAR"] viewWithTag:3004] removeFromSuperview];
        [[self getViewToHostForChart:@"BAR"].hostedGraph removeFromSuperlayer];
        return;
    }
}

- (void) setPreviousNextButtonStatuses
{
    baseChart *bc;
    if (fullScreenMode==NO) 
    {
        if ([topChart isEqualToString:@"LC"]) bc = dbscd;
        if ([topChart isEqualToString:@"PIE"]) bc = dbpd;
        if ([topChart isEqualToString:@"BARSC"]) bc = dbBarSalColn;
        if ([topChart isEqualToString:@"BAR"]) bc = dbbard;
    }
    else
    {
        if ([fullScreenChart isEqualToString:@"LC"]) bc = dbscd;
        if ([fullScreenChart isEqualToString:@"PIE"]) bc = dbpd;
        if ([fullScreenChart isEqualToString:@"BARSC"]) bc = dbBarSalColn;
        if ([fullScreenChart isEqualToString:@"BAR"]) bc = dbbard;
    }
    leftButton.hidden = [bc enablePreviousButton]==YES? NO : YES;
    rightButton.hidden = [bc enableNextButton]==YES? NO : YES;
}

- (IBAction) makeFullScreen:(id)sender
{
    UIButton *fullscreenBtn = (UIButton*) sender;
    int tagValue = fullscreenBtn.tag;
    CPTGraphHostingView *tmpHostView;
    fullScreenMode = YES;
    CGRect newFrame;
    if (UIInterfaceOrientationIsPortrait(currOrientation)==YES) 
        newFrame = CGRectMake(5, 44, 755, 915);
    else
        newFrame = CGRectMake(5,50,1028, 659);
    if (tagValue==3001) 
    {
        tmpHostView = [self getViewToHostForChart:@"LC"];
        frameBeforeFullScreen = tmpHostView.frame;
        [tmpHostView setFrame:newFrame];
        [self.view addSubview:tmpHostView];
        [self removeButtonsFromChart:@"LC"];
        fullScreenChart = [[NSString alloc] initWithFormat:@"%@",@"LC"];
        [dbscd makeFullScreenModewithOrientation:currOrientation];
    }
    if (tagValue==3002) 
    {
        tmpHostView = [self getViewToHostForChart:@"PIE"];
        frameBeforeFullScreen = tmpHostView.frame;
        [tmpHostView setFrame:newFrame];
        [self.view addSubview:tmpHostView];
        [self removeButtonsFromChart:@"PIE"];
        fullScreenChart = [[NSString alloc] initWithFormat:@"%@",@"PIE"];
        [dbpd makeFullScreenModewithOrientation:currOrientation];
    }
    if (tagValue==3003) 
    {
        tmpHostView = [self getViewToHostForChart:@"BARSC"];
        frameBeforeFullScreen = tmpHostView.frame;
        [tmpHostView setFrame:newFrame];
        [self.view addSubview:tmpHostView];
        [self removeButtonsFromChart:@"BARSC"];
        fullScreenChart = [[NSString alloc] initWithFormat:@"%@",@"BARSC"];
        [dbBarSalColn makeFullScreenModewithOrientation:currOrientation];
    }
    if (tagValue==3004) 
    {
        tmpHostView = [self getViewToHostForChart:@"BAR"];
        frameBeforeFullScreen = tmpHostView.frame;
        [tmpHostView setFrame:newFrame];
        [self.view addSubview:tmpHostView];
        [self removeButtonsFromChart:@"BAR"];
        fullScreenChart = [[NSString alloc] initWithFormat:@"%@",@"BAR"];
        [dbbard makeFullScreenModewithOrientation:currOrientation];
    }
    [self addPreviousNextButtons];
    [self setPreviousNextButtonStatuses];
    [bottomScroll setHidden:YES];
    if ([tmpHostView isEqual:topView]==NO) [topView setHidden:YES]; 
}

- (IBAction) restoreOldMode:(id)sender
{
    baseChart *bc;
    UIButton *restoreBtn = (UIButton*) sender;
    int tagValue = restoreBtn.tag;
    CPTGraphHostingView *tmpHostView;
    fullScreenMode = NO;
    tmpHostView = [self getViewToHostForChart:fullScreenChart];
    [tmpHostView setFrame:frameBeforeFullScreen];
    if ([tmpHostView isEqual:topView]==NO) 
        [bottomScroll addSubview:tmpHostView];
    else
        [self.view addSubview:tmpHostView];
    [self removeButtonsFromChart:fullScreenChart];
    if (tagValue==4001) 
        bc = dbscd;
    if (tagValue==4002) 
        bc = dbpd;
    if (tagValue==4003) 
        bc = dbBarSalColn;
    if (tagValue==4004) 
        bc = dbbard;
    [bc swapChartToView:tmpHostView andViewPosition:[plotLayOptions valueForKey:fullScreenChart] withOrientation:currOrientation];
    fullScreenMode=NO;
    fullScreenChart = [[NSString alloc] initWithFormat:@"%@",@""];
    [bottomScroll setHidden:NO];
    [topView setHidden:NO]; 
    [self setChartAndScrollForOrientation:currOrientation];
    [self createRefreshButtons];
    [self addPreviousNextButtons];
    [self setPreviousNextButtonStatuses];
}

- (void) setFSReadjustmentForOrientation:(UIInterfaceOrientation) p_toOrientation
{
    CPTGraphHostingView *tmpHostView;
    CGRect newFrame;
    if (UIInterfaceOrientationIsPortrait(p_toOrientation)) 
        newFrame = CGRectMake(5, 44, 755, 915);
    else
        newFrame = CGRectMake(5,50,1028, 659);
    
    tmpHostView = [self getViewToHostForChart:fullScreenChart];
    frameBeforeFullScreen = tmpHostView.frame;
    [tmpHostView setFrame:newFrame];
    [self.view addSubview:tmpHostView];
    [self removeButtonsFromChart:fullScreenChart];
    if ([fullScreenChart isEqualToString:@"LC"]==YES) 
        [dbscd makeFullScreenModewithOrientation:currOrientation];
    if ([fullScreenChart isEqualToString:@"PIE"]==YES) 
        [dbpd makeFullScreenModewithOrientation:currOrientation];
    if ([fullScreenChart isEqualToString:@"BARSC"]==YES) 
        [dbBarSalColn makeFullScreenModewithOrientation:currOrientation];
    if ([fullScreenChart isEqualToString:@"BAR"]==YES) 
        [dbbard makeFullScreenModewithOrientation:currOrientation];
}

@end
