//
//  templateWindowsContorller.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "templateWindowsContorller.h"

@interface templateWindowsContorller ()

@end

@implementation templateWindowsContorller

- (NSString*)test :(NSString*)myString{
    NSLog(@"test founction:%@",myString);
    return myString;
}

- (IBAction)addAction:(id)sender {
    NSLog(@"add action");
  // vc.
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
