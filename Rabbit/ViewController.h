//
//  ViewController.h
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "preferenceViewContorler.h"
#import "templateWindowsContorller.h"
#import "exportViewControler.h"
#import "myView.h"

@interface ViewController : NSViewController {
    templateWindowsContorller *twc;
    exportViewControler *evc;
    preferenceViewContorler *pvc;
}

@property (weak) IBOutlet myView *myView;

@property (strong) NSMutableArray *rowDataName;
@property (strong) NSMutableArray *rowDataWidth;
@property (strong) NSMutableArray *rowDataHeight;


- (IBAction)preference:(id)sender;
- (IBAction)importItem:(id)sender;
- (IBAction)exportItem:(id)sender;

- (IBAction)newTemplateButton:(id)sender;
- (IBAction)addImageButtonAction:(id)sender;

- (IBAction)importImageAction:(id)sender;

@property (weak) IBOutlet NSTableView *tableView;

-(void)addDataInfo:(NSString*)data;

@end