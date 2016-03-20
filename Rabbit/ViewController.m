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
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initz];
}
#pragma mark - initz vaules
-(void)initz {
    popMenu = NO;
    popTitle = @"";
    [self titleLabel:popTitle ourTitleAry:NULL];
    [profileSelectionOutlet removeAllItems];
    NSArray *popup = [[NSArray alloc] initWithObjects:@"None", nil];
    [profileSelectionOutlet addItemsWithTitles:popup];
    rowSelection = 0;
    curentWidth = 510;
    curentHeight = 440;
    imageData = [[NSImage alloc]init];
    [self.myView setMyImage:imageData];
    ourData = [[DataArray alloc]init];
    [tableView reloadData];
    [self updateDisplayView];
}
#pragma mark - new project
- (IBAction)newProject:(id)sender{
    [self initz];
}
#pragma mark - open & saveproject
- (IBAction)openProject:(id)sender{
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    NSMutableDictionary *loadFileData = [[NSMutableDictionary alloc] initWithDictionary:[lsi loadFileData]];
    //get version info
    float versionInfo = [[loadFileData valueForKey:@"version"] floatValue];
    if (versionInfo == 1) {
        NSMutableDictionary *usrDic = [[NSMutableDictionary alloc] initWithDictionary:[loadFileData valueForKey:@"Main"]];
        [ourData setMyData:usrDic];
        //load image
        imageData = [[NSImage alloc] initWithData:[loadFileData valueForKey:@"image"]];
        if (imageData) {
            float newSize = (curentWidth/2)+(curentHeight/2);
            [self.myView setMyImage:imageData];
            [self.myView imageSize:newSize];
            [self.myView updateDisplay];
        }//end if imageData
//set up popup menu
        NSString *setTitle = [[usrDic allKeys] objectAtIndex:0];
        [self titleLabel:popTitle ourTitleAry:NULL];
        [profileSelectionOutlet selectItemWithTitle:setTitle];
        [self updateSubTabile];
        [self updateDisplayView];
        [tableView reloadData];
    }//end imageData
   //  NSLog(@"open%@",loadFileData);
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
    [saveData setObject:[ourData myData] forKey:@"Main"];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi saveFileData:saveData];
  //  NSLog(@"save:%@",saveData);
}

#pragma mark - import & export
- (IBAction)importItem:(id)sender{
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    NSMutableDictionary *importData = [[NSMutableDictionary alloc] initWithDictionary:[lsi importProfile]];
    [ourData setMyData:importData];
    popTitle = [[importData allKeys] objectAtIndex:0];
    [profileSelectionOutlet addItemsWithTitles:[ourData getDictionaryKeyNames]];
    [profileSelectionOutlet selectItemWithTitle:popTitle];
    [self updateSubTabile];
    [self updateDisplayView];
    [tableView reloadData];
    NSLog(@"import settings:%@",importData);
}

- (IBAction)exportItem:(id)sender{
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [self updateSubTabile];
    NSMutableDictionary *exportData = [[NSMutableDictionary alloc] init];
    [exportData setObject:[[ourData myData] valueForKey:popTitle] forKey:popTitle];
   // [lsi exportProfile:exportData];
    NSLog(@"export settings:%@",[[ourData myData] valueForKey:popTitle]);
}

#pragma mark - tableView setup
- (NSView *)tableView:(NSTableView *)mytableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    //nameID
    if( [tableColumn.identifier isEqualToString:@"nameID"] )
    {
        //  cellView.imageView.image = @"";
        cellView.textField.stringValue = [ourData getNameAtIndex:row];
        return cellView;
    }
    //widthID
    if( [tableColumn.identifier isEqualToString:@"widthID"] )
    {
        cellView.textField.stringValue =[ourData getWidthAtIndex:row];
        return cellView;
    }
    //heightID
    if( [tableColumn.identifier isEqualToString:@"heightID"] )
    {
        cellView.textField.stringValue =[ourData getHeightAtIndex:row];
     //   [cellView.textField setEditable:YES]; // Make Cell Editable!
        return cellView;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  //  NSLog(@"row numbers:%lu",(unsigned long)[[ourData nameColom] count]);
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
    rowSelection = row;
}

#pragma mark-update Display
-(void)updateDisplayView {
   // NSLog(@"update Display View");
    if (imageData) {
        float w = curentWidth;
        float h = curentHeight;

        NSSize newSize = NSMakeSize(w, h);
        float newScale = (w/2)+(h/2);
        
        [self.myView imageSize:newScale];
        [self.myView setFrameSize:newSize];
        [self.myView updateDisplay];
    }//end image data
}//end updateDusplayView

#pragma mark handly table manubar
- (IBAction)segmentedAction:(id)sender {
    NSInteger clickedSegment = [sender selectedSegment];
    NSInteger clickedSegmentTag = [[sender cell] tagForSegment:clickedSegment];
    if (popMenu ==YES) {
        if (clickedSegmentTag == 0) {
            [self performSegueWithIdentifier:@"addSegue" sender:self];
//NSLog(@"add");
        }//end clicked Segment Tag
        
        if (clickedSegmentTag == 1 ) {
//NSLog(@"sub table");
            [self  removeItemFormTable];
        }
    }//end if popMenu
    
    if (clickedSegmentTag == 2) {
        imageData = [[NSImage alloc]init];
        LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
        imageData = [lsi loadFileImage];
        [self.myView setMyImage:imageData];
        [self updateDisplayView];
    }
    
    if (clickedSegmentTag == 3) {
          [self performSegueWithIdentifier:@"imageSegue" sender:self];
    }
//NSLog(@"myDate%@",[ourData myData]);
}//end srgmentedAction

- (IBAction)sacleAction:(id)sender {
    float imageScale = [sender floatValue];
    [self.myView imageSize:imageScale];
  //  NSLog(@"sacle:%f",imageScale);
}

//handly delegat
#pragma mark Delegat functions
-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pvcSegue"]) {
        //NSLog(@"todo");
        profilesViewControler *pvc = segue.destinationController;
        pvc.delegate = self;
        [pvc popOverData:[ourData getDictionaryKeyNames]];
    }
    if ([segue.identifier isEqualToString:@"addSegue"]) {
      //  NSLog(@"add Segue");
        addTableViewController *atv =  segue.destinationController;
        atv.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"imageSegue"]) {
       // NSLog(@"imageSegue");
        DataArray *cda = [[DataArray alloc]init];
        imageViewController *ivc = segue.destinationController;
        NSInteger aryLenght = (long)[[ourData myData] count];
        [ivc setImageData:imageData];
        [ivc setArraySize:aryLenght];
        [ivc setDataAray:[cda cleanArray:[ourData nameColom] width:[ourData widthColom] height:[ourData hightColom]]];
      //  NSLog(@"clean Array:%@",[cda cleanArray:[ourData nameColom] width:[ourData widthColom] height:[ourData hightColom]]);
    }
}

- (void)titleLabel:(NSString*)ourTitle ourTitleAry:(NSArray*)ourTitleAry {
//NSLog(@"title ary:%@",ourTitleAry);
    if ([ourTitleAry isNotEqualTo:@""]) {
        popMenu = YES;
        NSString *ourTitleString = [ourTitleAry lastObject];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
        [temp setValuesForKeysWithDictionary:[ourData newData:ourTitleString]];
        [ourData setMyData:temp];
        [self createPopup:ourTitleAry];
        popTitle = ourTitleString;
        [self updateDisplayView];
        [tableView reloadData];
       // NSLog(@"titleLabel ourData:%@",[ourData myData]);
    }
}
//end handly delgate
-(void)createPopup:(NSArray*)popupTitle{
    NSDictionary *oldMyData = [ourData myData];
    NSMutableDictionary *rootDic = [[NSMutableDictionary alloc] initWithDictionary:[ourData createMainData:popupTitle oldData:oldMyData]];
    popTitle = [[ourData getDictionaryKeyNames] objectAtIndex:0];
    //creat new root
    [ourData setMyData:rootDic];
    [profileSelectionOutlet addItemsWithTitles:[ourData getDictionaryKeyNames]];
    [profileSelectionOutlet selectItemWithTitle:popTitle];
    
    [self updateSubTabile];
    [tableView reloadData];
  //  NSLog(@"createPopup ourData:%@",[ourData myData]);
}

#pragma mark Change PopUp title
- (IBAction)profileSelectionAction:(id)sender {
    popTitle = [sender titleOfSelectedItem];
    //update
    [self updateSubTabile];
    [tableView reloadData];
  //  NSLog(@"profileSelectionAction:%@ root data:%@",popTitle,[ourData myData]);
}

#pragma mark - Add data to tableView
- (void)addTableName:(NSString*)titleName width:(float)width height:(float)height{
    NSLog(@"add table name %@ %f %f",titleName,width,height);
    //get old add to add
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:[[ourData myData] valueForKey:popTitle]];
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
    //add to array
    [tempArray addObject:[ourData newTableData]];
    [[tempArray lastObject] setObject:titleName forKey:@"Name"];
    [[tempArray lastObject] setObject:[NSNumber numberWithFloat:width] forKey:@"Width"];
    [[tempArray lastObject] setObject:[NSNumber numberWithFloat:height] forKey:@"Height"];
    [tempDic setObject:tempArray forKey:popTitle];
    [ourData setMyData:tempDic];
    [self updateSubTabile];
    [self updateDisplayView];
    [tableView reloadData];
     NSLog(@"addTableName:%@",tempArray);
}
#pragma mark - Remove data
-(void)removeItemFormTable{
   // NSLog(@"remove");
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
    NSMutableArray *dicDataAry = [[NSMutableArray alloc] initWithArray:[[ourData myData] valueForKey:popTitle]];
    NSMutableArray *tempName = [[NSMutableArray alloc] initWithArray:[ourData nameColom]];
    NSMutableArray *tempWidh = [[NSMutableArray alloc] initWithArray:[ourData widthColom]];
    NSMutableArray *tempHeight = [[NSMutableArray alloc] initWithArray:[ourData hightColom]];
    if (dicDataAry > 0) {
        [tempName removeLastObject];
        [tempWidh removeLastObject];
        [tempHeight removeLastObject];
        [dicDataAry removeLastObject];
        [tempDic setObject:dicDataAry forKey:popTitle];
        [ourData setMyData:tempDic];
        // NSLog(@"subtract tempDic:%@",tempDic);
        [self updateSubTabile];
        [self updateDisplayView];
        [tableView reloadData];
    }//error handyling
}

#pragma mark - update table
-(void)updateTable:(NSString*)titleName width:(float)width height:(float)height{
    
}

#pragma mark - update subtable
-(void)updateSubTabile {
    NSArray *dicData = [[NSArray alloc] initWithArray:[[ourData myData] valueForKey:popTitle]];
    NSMutableArray *createNameData = [[NSMutableArray alloc]init];
    NSMutableArray *createWidthData = [[NSMutableArray alloc]init];
    NSMutableArray *createHeightData = [[NSMutableArray alloc]init];
    short lenght = [dicData count];
    
    for (int i = 0; i < lenght; i++) {
        [createNameData addObject:[[dicData objectAtIndex:i] valueForKey:@"Name"]];
        [createWidthData addObject:[[dicData objectAtIndex:i] valueForKey:@"Width"]];
        [createHeightData addObject:[[dicData objectAtIndex:i] valueForKey:@"Height"]];
    }//end loop
    [ourData setNameColom:createNameData];
    [ourData setWidthColom:createWidthData];
    [ourData setHightColom:createHeightData];
    NSLog(@"updateSubTabile Item:%@",[ourData myData]);
}
@end