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
#import "alertInfo.h"

@interface ViewController : NSViewController<popOverControllerDelegate> {
    NSImage *imageData;
    BOOL pngSetting,jpgSetting,tiffSetting,popMenu;
    int rowSelection;
    DataArray *ourData;
    NSString *popTitle;
    NSString *curentName;
    float curentWidth,curentHeight;
}

@property (strong) NSWindow *detachedWindow;
@property (strong) NSPanel *detachedHUDWindow;

@property (weak) IBOutlet myView *myView;
//
//@property (nonatomic) NSMutableDictionary *colomData;
//@property (nonatomic) NSMutableDictionary *myData;
//@property (nonatomic) NSMutableArray *tableRowData;

//new project
- (IBAction)newProject:(id)sender;
//open and Save
- (IBAction)openProject:(id)sender;
- (IBAction)SaveProject:(id)sender;

//menu items
- (IBAction)importItem:(id)sender;
- (IBAction)exportItem:(id)sender;

//@property (weak) IBOutlet NSTextField *profileTextFeild;

@property (weak) IBOutlet NSPopUpButton *profileSelectionOutlet;
- (IBAction)profileSelectionAction:(id)sender;
//table information
@property (weak) IBOutlet NSTableView *tableView;
- (IBAction)nameAction:(id)sender;
- (IBAction)widthTableAction:(id)sender;
- (IBAction)heightTableAction:(id)sender;

- (IBAction)segmentedAction:(id)sender;
//
- (IBAction)createAction:(id)sender;
//
- (IBAction)pngAction:(id)sender;
- (IBAction)jpgeAction:(id)sender;
- (IBAction)tiffAction:(id)sender;
@end