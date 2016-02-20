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

-(void)importImage :(NSString*)fileName{
    NSLog(@"import image");
}

- (void) setFrameSize:(NSSize)newSize {
    [super setFrameSize:newSize];
    
    // A change in size has required the view to be invalidated.
    if ([self inLiveResize])
    {
        NSRect rects[4];
        NSInteger count;
        [self getRectsExposedDuringLiveResize:rects count:&count];
        while (count-- > 0)
        {
            [self setNeedsDisplayInRect:rects[count]];
        }
    }
    else
    {
        [self setNeedsDisplay:YES];
    }
//move nsview to center
   //width:520 - height: 450
  //  NSPoint newLocation = NSMakePoint(newSize.width-520, newSize.height-450);
    NSPoint newLocation = NSMakePoint(10,10);
    [self setFrameOrigin:newLocation];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    [[NSColor blackColor]setFill];
    NSRectFill(dirtyRect);
}

@end
