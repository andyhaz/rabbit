//
//  myView.h
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface myView : NSView {
     NSImage *image;
}

@property (retain) NSImage *myImage;
@property (retain) NSString *imageName;

-(void)setFrameSize:(NSSize)newSize;
-(void)importImage :(NSString*)fileName;
-(void)updateDisplay;

@end