//
//  ViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize profileSelectionOutlet;
@synthesize myData,colomData;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    rowSelection = 0;
    curentWidth = 80;
    curentHeight = 80;
    pngSetting = YES;
    jpgSetting = YES;
    tiffSetting = YES;
    
    ourData = [[DataArray alloc]init];
    myData = [[NSMutableDictionary alloc]init];
    colomData = [[NSMutableDictionary alloc]init];
}
#pragma mark - new project
- (IBAction)newProject:(id)sender{
    NSLog(@"new project");
    popTitle = @"";
    [self titleLabel:popTitle];
    [profileSelectionOutlet removeAllItems];
    NSArray *popup = [[NSArray alloc] initWithObjects:@"None", nil];
    [profileSelectionOutlet addItemsWithTitles:popup];
    rowSelection = 0;
    curentWidth = 80;
    curentHeight = 80;
    imageData = [[NSImage alloc]init];
    [self.myView setMyImage:imageData];
    ourData = [[DataArray alloc]init];
    myData = [[NSMutableDictionary alloc]init];
    colomData = [[NSMutableDictionary alloc]init];
    [tableView reloadData];
}

#pragma mark - open & saveproject
- (IBAction)openProject:(id)sender{
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    NSMutableDictionary *loadFileData = [[NSMutableDictionary alloc] initWithDictionary:[lsi loadFileData]];
    NSLog(@"open%@",loadFileData);
    
    //get version info
    float versionInfo = [[loadFileData valueForKey:@"version"] floatValue];
    if (versionInfo == 1) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[loadFileData valueForKey:@"Main"]];
        [ourData setMyData:dic];
        
        //load image
        imageData = [[NSImage alloc] initWithData:[loadFileData valueForKey:@"image"]];
       // NSLog(@"image data:%@",imageData);
        if (imageData) {
         //   NSLog(@"display image:%@",imageData);
            float newSize = (curentWidth/2)+(curentHeight/2);
            [self.myView setMyImage:imageData];
            [self.myView imageSize:newSize];
            [self.myView updateDisplay];
        }//end if imageData
        
        //set up main data are
        NSString *setTitle = [[dic allKeys] lastObject];
        [self titleLabel:setTitle];
        
        NSArray *dicData = [[NSArray alloc] initWithArray:[[ourData myData] valueForKey:setTitle]];
        
        NSMutableArray *createNameData = [[NSMutableArray alloc]init];
        NSMutableArray *createWidthData = [[NSMutableArray alloc]init];
        NSMutableArray *createHeightData = [[NSMutableArray alloc]init];
        
        short lenght = [dicData count];
        
        for (int i = 0; i < lenght; i++) {
            //NSLog(@"names:%@",[[dicData objectAtIndex:i] valueForKey:@"Name"]);
            [createNameData addObject:[[dicData objectAtIndex:i] valueForKey:@"Name"]];
            [createWidthData addObject:[[dicData objectAtIndex:i] valueForKey:@"Width"]];
            [createHeightData addObject:[[dicData objectAtIndex:i] valueForKey:@"Height"]];
        }
        
        [ourData setNameColom:createNameData];
        [ourData setWidthColom:createWidthData];
        [ourData setHightColom:createHeightData];
   //     NSLog(@"dic:%@",dic);
    }
}

- (IBAction)SaveProject:(id)sender{
    NSMutableDictionary *saveData = [[NSMutableDictionary alloc] init];
    [saveData setObject:[NSNumber numberWithFloat:1.0] forKey:@"version"];
    //save image data
    
    NSInteger sizeY = 100;
    NSInteger sizeX = 100;
    //create image
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                             initWithBitmapDataPlanes:NULL
                             pixelsWide:sizeY
                             pixelsHigh:sizeX
                             bitsPerSample:8
                             samplesPerPixel:4
                             hasAlpha:YES
                             isPlanar:NO
                             colorSpaceName:NSCalibratedRGBColorSpace
                             bytesPerRow:0
                             bitsPerPixel:0];
                            [rep setSize:NSMakeSize(sizeX, sizeY)];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
    
    [imageData drawInRect:NSMakeRect(0, 0, sizeX, sizeY) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    
    [NSGraphicsContext restoreGraphicsState];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    
    NSData *iData = [rep representationUsingType:NSPNGFileType properties:options];
    
    [saveData setObject:iData forKey:@"image"];
    
    
    //[saveData setObject:imageData forKey:@"image"];
    
    [saveData setObject:[ourData myData] forKey:@"Main"];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi saveFileData:saveData];
    NSLog(@"save:%@",saveData);
    
}
- (IBAction)importItem:(id)sender{
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[lsi importProfile]];
    NSString *setTitle = [[dic allKeys] objectAtIndex:0];
     [self titleLabel:setTitle];
   // NSLog(@"dic:%@",dic);
    [ourData setMyData:dic];
    NSArray *dicData = [[NSArray alloc] initWithArray:[[ourData myData] valueForKey:setTitle]];
    
    NSMutableArray *createNameData = [[NSMutableArray alloc]init];
    NSMutableArray *createWidthData = [[NSMutableArray alloc]init];
    NSMutableArray *createHeightData = [[NSMutableArray alloc]init];

    short lenght = [dicData count];
    
    for (int i = 0; i < lenght; i++) {
        //NSLog(@"names:%@",[[dicData objectAtIndex:i] valueForKey:@"Name"]);
        [createNameData addObject:[[dicData objectAtIndex:i] valueForKey:@"Name"]];
        [createWidthData addObject:[[dicData objectAtIndex:i] valueForKey:@"Width"]];
        [createHeightData addObject:[[dicData objectAtIndex:i] valueForKey:@"Height"]];
    }
   
        [ourData setNameColom:createNameData];
        [ourData setWidthColom:createWidthData];
        [ourData setHightColom:createHeightData];
    
   // NSLog(@"createData info:%@",createNameData);
    NSLog(@"name Colom:%@",[ourData nameColom]);

  //
    [self updateDisplayView];
    [tableView reloadData];

}

#pragma mark - import & export
- (IBAction)exportItem:(id)sender{
    NSMutableDictionary *exportData = [[NSMutableDictionary alloc] init];
    [exportData setObject:[[ourData myData] valueForKey:popTitle] forKey:popTitle];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi exportProfile:exportData];
    NSLog(@"export settings:%@",exportData);
}

#pragma mark table setup
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    //nameID
    if( [tableColumn.identifier isEqualToString:@"nameID"] )
    {
        //  cellView.imageView.image = @"";
        cellView.textField.stringValue = [ourData getNameAtIndex:row];// [self.rowDataName objectAtIndex:row];
        
        return cellView;
    }
    //widthID
    if( [tableColumn.identifier isEqualToString:@"widthID"] )
    {
        cellView.textField.stringValue =[ourData getWidthAtIndex:row];
        [cellView.textField setEditable:YES]; // Make Cell Editable!
        
        return cellView;
    }
    //heightID
    if( [tableColumn.identifier isEqualToString:@"heightID"] )
    {
        cellView.textField.stringValue =[ourData getHeightAtIndex:row];
        [cellView.textField setEditable:YES]; // Make Cell Editable!
        
        return cellView;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSLog(@"row numbers:%lu",(unsigned long)[[ourData nameColom] count]);
    return [[ourData nameColom] count];
}

#pragma mark select table item
-(void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    short row = [[notification object] selectedRow];
    
    NSTextField *textName = [[[notification.object viewAtColumn:0 row:row makeIfNecessary:NO]subviews] lastObject];
    NSTextField *textWidth = [[[notification.object viewAtColumn:1 row:row makeIfNecessary:NO]subviews] lastObject];
    NSTextField *textHeight = [[[notification.object viewAtColumn:2 row:row makeIfNecessary:NO]subviews] lastObject];
   
    [textName selectText:textName.stringValue];
    [textWidth selectText:textWidth.stringValue];
    [textHeight selectText:textHeight.stringValue];
    
    curentName = [textName stringValue];
    curentWidth = [textWidth floatValue];
    curentHeight = [textHeight floatValue];
    
    rowSelection = row;
}

#pragma mark-update Display
-(void)updateDisplayView {
   // NSLog(@"update Display View");
    float w = curentWidth;
    float h = curentHeight;

    NSSize newSize = NSMakeSize(w, h);
    float newScale = (w/2)+(h/2);
    
    [self.myView imageSize:newScale];
    [self.myView setFrameSize:newSize];
    [self.myView setFrameSize:newSize];
    [self.myView updateDisplay];
}//end updateDusplayView

- (IBAction)nameAction:(id)sender {
    NSString *updateName = [sender stringValue];
    NSMutableArray *subRowData = [[NSMutableArray alloc] initWithArray:[ourData getRowData:popTitle]];
    NSMutableArray *newSubArray = [[NSMutableArray alloc] initWithArray:[ourData replaceSubArray:subRowData atIndex:rowSelection setStrValue:updateName valueForKey:@"Name"]];
    [ourData setNameColom:newSubArray];
    [myData setObject:newSubArray forKey:popTitle];
    curentName = updateName;
    
    [self updateDisplayView];
   // NSLog(@"ourData:%@",ourData);
  //  NSLog(@"name action:%@ - %d",updateName,rowSelection);
}
#pragma mark - Width Table Action
- (IBAction)widthTableAction:(id)sender {
    float newFloat = [sender floatValue];
    NSMutableArray *usersColome = [[NSMutableArray alloc] initWithArray:[ourData widthColom]];
    [usersColome replaceObjectAtIndex:rowSelection withObject:[NSNumber numberWithFloat:newFloat]];
    [ourData setWidthColom:usersColome];
  //  NSMutableArray *newNumSubArray = [[NSMutableArray alloc] initWithArray:[ourData replaceSubArray:subRowData atIndex:rowSelection setNumberValue:newFloat valueForKey:@"Width"]];
    curentWidth = newFloat;
    [self updateDisplayView];
}

- (IBAction)heightTableAction:(id)sender {
    float newFloat = [sender floatValue];
    NSMutableArray *usersColome = [[NSMutableArray alloc] initWithArray:[ourData hightColom]];
    [usersColome replaceObjectAtIndex:rowSelection withObject:[NSNumber numberWithFloat:newFloat]];
    [ourData setHightColom:usersColome];
    curentHeight = newFloat;
    [self updateDisplayView];
}

#pragma mark handly table manubar
- (IBAction)segmentedAction:(id)sender {
    
    NSInteger clickedSegment = [sender selectedSegment];
    NSInteger clickedSegmentTag = [[sender cell] tagForSegment:clickedSegment];

    NSMutableArray *tempName = [[NSMutableArray alloc] initWithArray:[ourData nameColom]];
    NSMutableArray *tempWidh = [[NSMutableArray alloc] initWithArray:[ourData widthColom]];
    NSMutableArray *tempHeight = [[NSMutableArray alloc] initWithArray:[ourData hightColom]];

    if (clickedSegmentTag == 0) {
        //NSLog(@"add");
       //add to the array
        [tempName addObject:@"Icon"];
        [tempWidh addObject:[NSNumber numberWithFloat:40]];
        [tempHeight addObject:[NSNumber numberWithFloat:40]];
        
        [ourData setNameColom:tempName];
        [ourData setWidthColom:tempWidh];
        [ourData setHightColom:tempHeight];
        
        [self updateDisplayView];
        [tableView reloadData];
    }//end clicked Segment Tag
    
    if (clickedSegmentTag == 1 ) {
//NSLog(@"sub table");
        if (tempName >= 0) {
            [tempName removeLastObject];
            [tempWidh removeLastObject];
            [tempHeight removeLastObject];
            
            [ourData setNameColom:tempName];
            [ourData setWidthColom:tempWidh];
            [ourData setHightColom:tempHeight];
            
            [self updateDisplayView];
            [tableView reloadData];
        }//error handyling
    }
    [myData setObject:[ourData createNewData] forKey:popTitle];
//NSLog(@"myDate%@",[ourData myData]);
}//end srgmentedAction

- (IBAction)sacleAction:(id)sender {
    float imageScale = [sender floatValue];
    [self.myView imageSize:imageScale];
  //  NSLog(@"sacle:%f",imageScale);
}

- (IBAction)profileTextAction:(id)sender {
    NSLog(@"profileTextAction");
}

#pragma mark Change PopUp title
- (IBAction)profileSelectionAction:(id)sender {
//NSLog(@"profileSelectionAction:%@",myData);
    [ourData setMyData:myData];
    NSString *newTitle = [sender titleOfSelectedItem];
    popTitle = newTitle;
    //update
    [self changeTable:newTitle];
    [tableView reloadData];
}

#pragma mark
- (IBAction)importImageAction:(id)sender {
    imageData = [[NSImage alloc]init];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    imageData = [lsi loadFileImage];
    NSLog(@"imageData:%@",imageData);
    
    float newSize = (curentWidth/2)+(curentHeight/2);
    
    [self.myView setMyImage:imageData];
    [self.myView imageSize:newSize];
    [self.myView updateDisplay];
//NSLog(@"import Image:%@ - size:%f",imageData,newSize);
}

-(void)createPopup:(NSString*)popupTitle{
    [profileSelectionOutlet addItemsWithTitles:[ourData getDictionaryKeyNames]];
    NSString *lastTitieName =  [[ourData getDictionaryKeyNames] lastObject];
    [profileSelectionOutlet selectItemWithTitle:lastTitieName];
//NSLog(@"last titlw:%@",lastTitieName);
}

#pragma mark Change Table
-(void)changeTable:(NSString*)tableTitle{
    NSMutableArray *tableRowData = [[NSMutableArray alloc] initWithArray:[ourData getRowData:tableTitle]];
    [ourData setNameColom:[tableRowData valueForKey:@"Name"]];
    [ourData setWidthColom:[tableRowData valueForKey:@"Width"]];
    [ourData setHightColom:[tableRowData valueForKey:@"Height"]];
}

//handly delegat
#pragma mark Delegat functions
- (void)titleLabel:(NSString*)ourTitle {
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
    [temp setValuesForKeysWithDictionary:[ourData newData:ourTitle]];
    [ourData setMyData:temp];
    
    [self createPopup:ourTitle];
    [self changeTable:ourTitle];
    popTitle = ourTitle;
    
    [self updateDisplayView];
    NSLog(@"titleLabel ourData:%@",[ourData myData]);
    [tableView reloadData];
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pvcSegue"]) {
        //NSLog(@"todo");
        profilesViewControler *pvc = segue.destinationController;
        pvc.delegate = self;
    }
}
//end handly delgate
#pragma mark handles expoing images
- (IBAction)createAction:(id)sender {
   // NSLog(@"create action");
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    DataArray *cda = [[DataArray alloc]init];
    [lsi setPng:pngSetting];
    [lsi setJpg:jpgSetting];
    [lsi setTiff:tiffSetting];
  //  NSLog(@"rowDataWidth:%@f %@f",[ourData widthColom],[ourData hightColom]);
    if (pngSetting == YES || jpgSetting == YES || tiffSetting == YES) {
       [lsi exportFileImages:imageData :[cda cleanArray:[ourData nameColom] width:[ourData widthColom] height:[ourData hightColom]]];
    }//end
}//end creteation

#pragma mark impage export setteings
- (IBAction)pngAction:(id)sender {
    if (pngSetting == YES) {
        pngSetting = NO;
    } else {
        pngSetting = YES;
    }
}

- (IBAction)jpgeAction:(id)sender {
    if (jpgSetting == YES) {
        jpgSetting = NO;
    } else {
        jpgSetting = YES;
    }
}

- (IBAction)tiffAction:(id)sender {
    if (tiffSetting == YES) {
        tiffSetting = NO;
    } else {
        tiffSetting = YES;
    }
}
@end