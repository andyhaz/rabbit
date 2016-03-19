//
//  imageViewController.h
//  Rabbit
//
//  Created by andrew hazlett on 3/18/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoadSaveInterface.h"
#import "alertInfo.h"
@interface imageViewController :  NSViewController {
    BOOL pngSetting,jpgSetting,tiffSetting;
}

@property (nonatomic)NSImage* imageData;
@property (nonatomic)NSArray* dataAray;
@property (nonatomic)NSInteger arraySize;

//
- (IBAction)pngAction:(id)sender;
- (IBAction)jpgeAction:(id)sender;
- (IBAction)tiffAction:(id)sender;

@end