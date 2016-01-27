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

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    [[NSColor blackColor]setFill];
    NSRectFill(dirtyRect);
    //resizes the display
    RBResize *rbs = [[RBResize alloc]init];
    NSRect f = [rbs resizeCanvises:self.frame width:1575 height:2475];
    //f.origin.x = 10;
   // f.origin.y = 0;
    self.frame = f;
}

@end
