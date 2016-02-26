//
//  ViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize profileTextFeild,profileSelectionOutlet,imageViewOutlet;
@synthesize rowDataName,rowDataHeight,rowDataWidth,profileNameArray,profileDataArray;
@synthesize tableView;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    edit = NO;
    profileDataArray = [[NSMutableArray alloc]init];
    profileNameArray = [[NSMutableArray alloc]init];
    rowDataName = [[NSMutableArray alloc]init];
    rowDataWidth = [[NSMutableArray alloc]init];
    rowDataHeight = [[NSMutableArray alloc]init];
    
    NSSize newSize = NSMakeSize(80, 80);
    [self.myView setFrameSize:newSize];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)importItem:(id)sender{
    NSLog(@"import image");
}

- (IBAction)exportItem:(id)sender{
     NSLog(@"export image");
}

- (IBAction)imageViewAction:(id)sender {
    //[imageViewOutlet ];
   // NSImage *imageData = [[NSImage alloc] initWithData:sender];
   // [self.myView setMyImage:sender];
   // [self.myView updateDisplay];
   // [self.imageViewOutlet addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    
  //  NSString *imageName = @"/Users/andyhaz/Documents/game rocket studio loadscreen/grs-loadscrenn(320x480).png";
    
   // NSImage *loadimage = [[NSImage alloc] initByReferencingFile:imageName];
   // NSLog(@"loadImage:%@",loadimage);

   // [self.myView setImageName:imageName];
   // [self.myView updateDisplay];
    
//    NSData *imageData = (NSData *)imageViewOutlet;
    //[imageViewOutlet setImage:<#(NSImage * _Nullable)#>]
    //   NSImage *imageData =  imageViewOutlet;
   // [self.myView setMyImage:imageData];
   // [self.myView updateDisplay];
    
  //  NSLog(@"imageViewAction:%@ - name:%@",[sender stringValue],imageData);
    NSLog(@"image:%@",[sender objectValue]);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageSelected:) name:@"KSImageDroppedNotification" object:nil];

}

- (void)imageSelected:(NSNotification *)notification {
    NSLog(@"imageSelected");
}
//end

- (IBAction)importImageAction:(id)sender {
 //   [self.myView importImage:@"image/name.png"];
}
//
-(void)addDataInfo:(NSString*)data{
    NSLog(@"add template:%@ - %@",data,self.rowDataName);
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
        [cellView.textField setEditable:edit]; // Make Cell Editable!
        
        return cellView;
    }
    //widthID
    if( [tableColumn.identifier isEqualToString:@"widthID"] )
    {
        cellView.textField.stringValue = [self.rowDataWidth objectAtIndex:row];
        [cellView.textField setEditable:edit]; // Make Cell Editable!
        
        return cellView;
    }
    //heightID
    if( [tableColumn.identifier isEqualToString:@"heightID"] )
    {
        cellView.textField.stringValue = [self.rowDataHeight objectAtIndex:row];
        [cellView.textField setEditable:edit]; // Make Cell Editable!
        
        return cellView;
    }
    //  NSLog(@"tableView:%@",tableColumn.identifier);
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.rowDataName count];
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification{
    short row = [[notification object] selectedRow];
    
    NSTextField *textName = [[[notification.object viewAtColumn:0 row:row makeIfNecessary:NO]subviews] lastObject];
    NSTextField *textWidth = [[[notification.object viewAtColumn:1 row:row makeIfNecessary:NO]subviews] lastObject];
    NSTextField *textHeight = [[[notification.object viewAtColumn:2 row:row makeIfNecessary:NO]subviews] lastObject];
    
    [textName selectText:textName.stringValue];
    [textWidth selectText:textWidth.stringValue];
    [textName selectText:textHeight.stringValue];
    
    //update array
    [rowDataName replaceObjectAtIndex:row withObject:[textName stringValue]];
    [rowDataWidth replaceObjectAtIndex:row withObject:[textWidth stringValue]];
    [rowDataHeight replaceObjectAtIndex:row withObject:[textHeight stringValue]];
    
    [self updateDisplay:row];

    NSLog(@"tableViewSelectionDidChange:%hd",row);
}

-(void)updateDisplay:(int)row{
    float w = [[rowDataWidth objectAtIndex:row] floatValue];
    float h = [[rowDataHeight objectAtIndex:row] floatValue];
    
    NSSize newSize = NSMakeSize(w, h);
    [self.myView setFrameSize:newSize];
}

- (IBAction)addTable:(id)sender {
    [rowDataName addObject:@"Icon"];
    [rowDataWidth addObject:@"40"];
    [rowDataHeight addObject:@"40"];
    [tableView reloadData];
    int r = [[rowDataName lastObject] intValue];
    [self updateDisplay:r];
    NSLog(@"add table");
}

- (IBAction)editAction:(id)sender {
    if (edit == NO) {
        edit = YES;
    } else {
        edit = NO;
    }
    [tableView reloadData];
}

- (IBAction)profileTextAction:(id)sender {
    [self profileSettings];
}

- (IBAction)addTextAction:(id)sender {
    [self profileSettings];
}

- (IBAction)profileSelectionAction:(id)sender {
    NSString *str = [profileSelectionOutlet stringValue];
    NSLog(@"%@",str);
}

- (IBAction)update:(id)sender {
    NSLog(@"update");
}

-(void)profileSettings{
    //[profileTextFeild setStringValue:@"hello"];
    NSString *getText = [profileTextFeild stringValue];
    [profileNameArray addObject:getText];
    [profileSelectionOutlet addItemsWithTitles:profileNameArray];
    [profileSelectionOutlet selectItemWithTitle:getText];
    [profileDataArray addObject:profileNameArray];
    [profileDataArray addObject:rowDataName];
    [profileDataArray addObject:rowDataWidth];
    [profileDataArray addObject:rowDataHeight];

    NSLog(@"%@",profileDataArray);
}
@end