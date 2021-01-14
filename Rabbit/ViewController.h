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
#import "imageViewController.h"
#import "alertInfo.h"
#import "profileClass.h"
//profileViewController - popOverControllerDelegate
@interface ViewController : NSViewController {
    BOOL popMenu;
    BOOL updateTable;
    BOOL imageEmpty;
    BOOL pngSetting,jpgSetting,tiffSetting;
    NSImage *imageData;
    int rowSelection;
    DataArray *ourData;
    NSString *popTitle;
  //  NSArray *popup;
    NSString *curentName;
    float curentWidth,curentHeight;
    NSArray *popListData;//???
}

@property IBOutlet NSWindow *window;

@property (strong) NSWindow *detachedWindow;
@property (strong) NSPanel *detachedHUDWindow;
@property (weak) IBOutlet myView *myView;

//new project
- (IBAction)newProject:(id)sender;
//menu items
- (IBAction)openImageAction:(id)sender;
- (IBAction)saveImageAction:(id)sender;
- (IBAction)saveScreenAction:(id)sender;


- (IBAction)pngAction:(id)sender;
- (IBAction)jpgeAction:(id)sender;
- (IBAction)tiffAction:(id)sender;

@property (weak) IBOutlet NSPopUpButton *profileSelectionOutlet;
- (IBAction)profileSelectionAction:(id)sender;
//table information
@end
