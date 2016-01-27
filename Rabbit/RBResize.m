//
//  RBResize.m
//  Rabbit
//
//  Created by andrew hazlett on 1/27/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "RBResize.h"

@implementation RBResize

-(NSRect)resizeCanvises:(NSRect)frameSize  width:(float)width height:(float)height{
    NSRect f = frameSize;
    f.size.width = width;
    f.size.height = height;
    
    return  f;
}

@end
