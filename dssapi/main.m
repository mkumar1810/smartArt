//
//  main.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "dssapiAppDelegate.h"

int main(int argc, char *argv[])
{
    /*NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;*/
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([dssapiAppDelegate class]));
    }
}
