//
//  VCWindowController.m
//  Rabbit
//
//  Created by andrew hazlett on 4/11/20.
//  Copyright © 2020 andrew hazlett. All rights reserved.
//

#import "VCWindowController.h"

@interface VCWindowController ()

@end

@implementation VCWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller’s window has been loaded from its nib file.
}
- (BOOL)windowShouldClose:(id)sender {
   // [NSApp hide:nil];
    [NSApp terminate:nil];
    return YES;
}

@end
