//
//  ViewController.h
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoadSaveInterface.h"
#import "myView.h"
#import "cleanDataArray.h"

@interface ViewController : NSViewController {
    BOOL edit;
    NSImage *imageData;
    
    BOOL pngSetting,jpgSetting,tiffSetting;
}

@property (weak) IBOutlet myView *myView;
//
@property (strong) NSMutableArray *rowDataName;
@property (strong) NSMutableArray *rowDataWidth;
@property (strong) NSMutableArray *rowDataHeight;
@property (strong) NSMutableArray *profileNameArray;
@property (strong) NSMutableArray *profileDataArray;

//menu items
- (IBAction)importItem:(id)sender;
- (IBAction)exportItem:(id)sender;

@property (weak) IBOutlet NSTextField *profileTextFeild;
- (IBAction)profileTextAction:(id)sender;
- (IBAction)addTextAction:(id)sender;

@property (weak) IBOutlet NSPopUpButton *profileSelectionOutlet;
- (IBAction)profileSelectionAction:(id)sender;
- (IBAction)update:(id)sender;

- (IBAction)importImageAction:(id)sender;

//table information
@property (weak) IBOutlet NSTableView *tableView;
- (IBAction)addTable:(id)sender;
- (IBAction)editAction:(id)sender;

@property (weak) IBOutlet NSTextField *rotationOutlet;
- (IBAction)rotactionAction:(id)sender;
- (IBAction)sacleAction:(id)sender;
//
- (IBAction)createAction:(id)sender;
//
- (IBAction)pngAction:(id)sender;
- (IBAction)jpgeAction:(id)sender;
- (IBAction)tiffAction:(id)sender;

@end