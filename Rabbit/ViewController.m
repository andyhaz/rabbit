//
//  ViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize rowDataName,rowDataHeight,rowDataWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    rowDataName = [[NSMutableArray alloc]init];
    rowDataWidth = [[NSMutableArray alloc]init];
    rowDataHeight = [[NSMutableArray alloc]init];
    [rowDataName addObject:@"Icon A"];
    [rowDataWidth addObject:@"40"];
    [rowDataHeight addObject:@"40"];
    
    [rowDataName addObject:@"Icon B"];
    [rowDataWidth addObject:@"400"];
    [rowDataHeight addObject:@"400"];
    
    NSSize newSize = NSMakeSize(80, 80);
    [self.myView setFrameSize:newSize];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)preference:(id)sender{
    pvc = [[preferenceViewContorler alloc] initWithWindowNibName:@"preferenceViewContorler"];
    [pvc showWindow:nil];
}

- (IBAction)importItem:(id)sender{
    NSLog(@"import image");
}

- (IBAction)exportItem:(id)sender{
    if (!evc) {
        evc = [[exportViewControler alloc] initWithWindowNibName:@"exportViewControler"];
    }
    [evc showWindow:nil];
}

- (IBAction)newTemplateButton:(id)sender {
}

- (IBAction)addImageButtonAction:(id)sender{
    [self newTemplate];
}

- (IBAction)importImageAction:(id)sender {
    [self.myView importImage:@"image/name.png"];
}

- (void)newTemplate{
    if (!twc) {
        twc = [[templateWindowsContorller alloc] initWithWindowNibName:@"templateWindowsContorller"];
    }
    [twc showWindow:self];
}
//
-(void)addDataInfo:(NSString*)data{
    NSLog(@"add template:%@",data);
}
//
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Since this is a single-column table view, this would not be necessary.
    // But it's a good practice to do it in order by remember it when a table is multicolumn.
    if( [tableColumn.identifier isEqualToString:@"nameID"] )
    {
        //  ScaryBugDoc *bugDoc = [self.bugs objectAtIndex:row];
        //  cellView.imageView.image = @"";
        cellView.textField.stringValue = [self.rowDataName objectAtIndex:row];
        
        return cellView;
    }
    //widthID
    if( [tableColumn.identifier isEqualToString:@"widthID"] )
    {
        cellView.textField.stringValue = [self.rowDataWidth objectAtIndex:row];
        
        return cellView;
    }
    //heightID
    if( [tableColumn.identifier isEqualToString:@"heightID"] )
    {
        cellView.textField.stringValue = [self.rowDataHeight objectAtIndex:row];
        
        return cellView;
    }
    //  NSLog(@"tableView:%@",tableColumn.identifier);
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.rowDataName count];
}

@end