//
//  ViewController.h
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "myView.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet myView *myView;

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


//table information
@property (weak) IBOutlet NSTableView *tableView;


- (IBAction)importImageAction:(id)sender;


@end