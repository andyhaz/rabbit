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
    NSLog(@"updateDisplay:%@",myImage);
    [self setNeedsDisplay:YES];
}
-(void) imageScale:(float)newSize{
    xScale = newSize;
    yScale = newSize;
    [self setNeedsDisplay:YES];
}
-(void) imageSize:(float)newSize{
    NSSize mySize = NSMakeSize(newSize, newSize);
    xScale = newSize;
    yScale = newSize;
    [self setFrameSize:mySize];
    [self setNeedsDisplay:YES];
    //
    NSLog(@"new size:%f",newSize);
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
//move nsview to center 520x450
    float locX = (318/2)-(newSize.width/2);
    float locY = (275/2)-(newSize.height/2);
    NSPoint newLocation = NSMakePoint(locX,locY);
    [self setFrameOrigin:newLocation];
  //  NSLog(@"move");
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
//    [[NSColor blackColor]setFill];
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
              operation: NSCompositingOperationSourceOver
             fraction: 1.0];

// NSLog(@"update image");
}
@end
