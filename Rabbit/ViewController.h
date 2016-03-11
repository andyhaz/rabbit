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

@interface ViewController : NSViewController<popOverControllerDelegate> {
    BOOL edit;
    NSImage *imageData;
    BOOL pngSetting,jpgSetting,tiffSetting;
    float w,h;
    int rowSelection;
    DataArray *ourData;
    NSString *popTitle;
}

@property (strong) NSWindow *detachedWindow;
@property (strong) NSPanel *detachedHUDWindow;

@property (weak) IBOutlet myView *myView;
//
@property (nonatomic) NSMutableDictionary *colomData;
@property (nonatomic) NSMutableArray *rowData;
@property (nonatomic) NSMutableDictionary *myData;

/*delete this infomation
@property (nonatomic) NSMutableDictionary *profileRootDictionary;
@property (strong) NSMutableArray *profileNameArray;
@property (strong) NSMutableArray *profileDataArray;
@property (strong) NSMutableArray *rowDataName;
@property (strong) NSMutableArray *rowDataWidth;
@property (strong) NSMutableArray *rowDataHeight;*/

//menu items
- (IBAction)importItem:(id)sender;
- (IBAction)exportItem:(id)sender;

//@property (weak) IBOutlet NSTextField *profileTextFeild;
- (IBAction)profileTextAction:(id)sender;

@property (weak) IBOutlet NSPopUpButton *profileSelectionOutlet;
- (IBAction)profileSelectionAction:(id)sender;
//- (IBAction)popOverAction:(id)sender;

- (IBAction)importImageAction:(id)sender;

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

-(void)profileSettings;


@end