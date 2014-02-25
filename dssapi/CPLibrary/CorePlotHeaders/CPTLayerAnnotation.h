#import <Foundation/Foundation.h>
#import "CPTAnnotation.h"
#import "CPTDefinitions.h"

@class CPTConstraints;

@interface CPTLayerAnnotation : CPTAnnotation {
@private
	__unsafe_unretained CPTLayer *anchorLayer;
	CPTConstraints *xConstraints;
    CPTConstraints *yConstraints;
    CPTRectAnchor rectAnchor;
}

@property (nonatomic, readonly, assign) __unsafe_unretained CPTLayer *anchorLayer;
@property (nonatomic, readwrite, assign) CPTRectAnchor rectAnchor;

-(id)initWithAnchorLayer:(CPTLayer *)anchorLayer;

@end
