//
//  login.m
//  aahg
//
//  Created by Raja T S Sekhar on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "login.h"

@implementation login

static bool shouldScroll = true;

- (id) initWithFrame:(CGRect)frame andReturnMethod:(METHODCALLBACK) p_loginReturn
{
    self = [self initWithFrame:frame];
    //_notificationName = [[NSString alloc] initWithString:p_notifyName];
    _loginReturnMethod = p_loginReturn;
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"login"
                                                          owner:self
                                                        options:nil];
    //self = [nibViews objectAtIndex:0];
    [self addSubview:[nibViews objectAtIndex:0]];
    Email.text= @"ed";
    Password.text = @"1234";
    actview.hidesWhenStopped = TRUE;
    actview.transform = CGAffineTransformMakeScale(5.00, 5.00);        
    intOrientationType = UIInterfaceOrientationPortrait;
    //_notificationName = [[NSString alloc] initWithString:@"loginSuccessful"];
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 }
 
*/

- (void)dealloc
{
    //[super dealloc];
}

- (void) setForOrientation:(UIInterfaceOrientation) orientationType
{
    if (UIInterfaceOrientationIsPortrait(orientationType)) 
    {
        intOrientationType = UIInterfaceOrientationPortrait;
        [mainImage setFrame:CGRectMake(36, 70, 696, 321)];
        [loginControl setFrame:CGRectMake(121, 382 , 500, 350)];
        [actview setFrame:CGRectMake(370, 300, 37, 37)];
    }
    else
    {
        intOrientationType = UIInterfaceOrientationLandscapeRight;
        [mainImage setFrame:CGRectMake(150, 50, 696, 250)];
        [loginControl setFrame:CGRectMake(250, 285 , 500, 350)];
        [actview setFrame:CGRectMake(480, 200, 37, 37)];
    }
}


-(IBAction)Login
{
    [actview startAnimating];
    //return;
    //if (_wsProxy) [_wsProxy release];
    NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSString alloc] initWithFormat:@"%@",Email.text], @"p_eMail",[[NSString alloc] initWithFormat:@"%@",Password.text], @"p_passWord" , nil];
    [[dssWSCallsProxy alloc] initWithReportType:@"USERLOGIN" andInputParams:inputDict andReturnMethod:_loginReturnMethod];
}


- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

-(BOOL)validate
{
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    shouldScroll = true;
    [scrollView setContentOffset:scrollOffset animated:YES]; 
    if([textField isEqual:Email])
    {
        [Password becomeFirstResponder];
    }
    else if([textField isEqual:Password])
    {
        [textField resignFirstResponder];
        scrollOffset = scrollView.contentOffset;
        scrollOffset.y = 0;
        if (UIInterfaceOrientationIsPortrait(intOrientationType)==NO)
            [scrollView setContentOffset:scrollOffset animated:YES];  
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (shouldScroll) {
        scrollOffset = scrollView.contentOffset;
        CGPoint scrollPoint;
        CGRect inputFieldBounds = [textField bounds];
        inputFieldBounds = [textField convertRect:inputFieldBounds toView:scrollView];
        scrollPoint = inputFieldBounds.origin;
        scrollPoint.x = 0;
        if([textField isEqual:Email])
            scrollPoint.y = 60;
        else if([textField isEqual:Password])
            scrollPoint.y = 150;
        else
            scrollPoint.y=0;
        
        if (UIInterfaceOrientationIsPortrait(intOrientationType)==NO)
            [scrollView setContentOffset:scrollPoint animated:YES];  
        shouldScroll = false;
    }
}

- (BOOL) textFieldDidEndEditing:(UITextField *) textField {
    
    return YES;
}

- (void) resetValues
{
    Email.text= @"";
    Password.text = @"";
    [actview stopAnimating];
}

@end
