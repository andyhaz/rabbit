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
#import "DataArray.h"
#import "profilesViewControler.h"
#import "imageViewController.h"
#import "alertInfo.h"
#import "addTableViewController.h"

@interface ViewController : NSViewController<popOverControllerDelegate,addTableControllerDelegate> {
    BOOL popMenu;
    NSImage *imageData;
    int rowSelection;
    DataArray *ourData;
    NSString *popTitle;
    NSString *curentName;
    float curentWidth,curentHeight;
}

@property (strong) NSWindow *detachedWindow;
@property (strong) NSPanel *detachedHUDWindow;
@property (weak) IBOutlet myView *myView;

//new project
- (IBAction)newProject:(id)sender;
//open and Save
- (IBAction)openProject:(id)sender;
- (IBAction)SaveProject:(id)sender;

//menu items
- (IBAction)importItem:(id)sender;
- (IBAction)exportItem:(id)sender;

@property (weak) IBOutlet NSPopUpButton *profileSelectionOutlet;
- (IBAction)profileSelectionAction:(id)sender;
//table information
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)segmentedAction:(id)sender;
//
@end