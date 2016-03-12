//
//  myView.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "myView.h"
#import "RBResize.h"

@implementation myView

@synthesize myImage,imageName;

-(void)updateDisplay{
    [self setNeedsDisplay:YES];
}

-(void) imageSize:(float)newSize{
    xScale = newSize;
    yScale = newSize;
    [self setNeedsDisplay:YES];
}

- (void) setFrameSize:(NSSize)newSize {
    [super setFrameSize:newSize];
    // A change in size has required the view to be invalidated.
    if ([self inLiveResize]) {
        NSRect rects[4];
        NSInteger count;
        [self getRectsExposedDuringLiveResize:rects count:&count];
        while (count-- > 0) {
            [self setNeedsDisplayInRect:rects[count]];
        }
    } else {
        [self setNeedsDisplay:YES];
    }
//  move nsview to center 520x450
    float locX = (520/2)-(newSize.width/2);
    float locY = (450/2)-(newSize.height/2);
    NSPoint newLocation = NSMakePoint(locX,locY);
    [self setFrameOrigin:newLocation];
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    [[NSColor blackColor]setFill];
    NSRectFill(dirtyRect);
    //
    [[NSGraphicsContext currentContext]
     setImageInterpolation: NSImageInterpolationHigh];
    
    NSSize viewSize  = [self bounds].size;
    NSSize imageSize = { xScale, yScale };
    
    NSPoint viewCenter;
    viewCenter.x = viewSize.width  * 0.50;
    viewCenter.y = viewSize.height * 0.50;
    
    NSPoint imageOrigin = viewCenter;
    imageOrigin.x -= imageSize.width  * 0.50;
    imageOrigin.y -= imageSize.height * 0.50;
    
    NSRect destRect;
    destRect.origin = imageOrigin;
    destRect.size = imageSize;
    
    [myImage drawInRect: destRect
             fromRect: NSZeroRect
            operation: NSCompositeSourceOver
             fraction: 1.0];
    NSLog(@"draw");
}
@end