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
//@synthesize myData,colomData;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    rowSelection = 0;
    curentWidth = 510;
    curentHeight = 440;
    popMenu = NO;
    
    ourData = [[DataArray alloc]init];
    [self updateDisplayView];
}
#pragma mark - new project
- (IBAction)newProject:(id)sender{
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
       // NSLog(@"image data:%@",imageData);
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
      //  NSLog(@"title label:%@",setTitle);
        //end p=popup menu
        
        [self updateSubTabile];
        
        [self updateDisplayView];
        [tableView reloadData];
//        NSLog(@"dicData:%@ / %@",dicData,[[ourData myData] valueForKey:setTitle]);
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
    NSString *setTitle = [[importData allKeys] objectAtIndex:0];
    [self titleLabel:popTitle ourTitleAry:NULL];
    popTitle = setTitle;
    [self updateSubTabile];
    [ourData setMyData:importData];
    [self updateDisplayView];
    [self changeTable:popTitle];
    [tableView reloadData];
    NSLog(@"import settings:%@",importData);

}

- (IBAction)exportItem:(id)sender{
    NSMutableDictionary *exportData = [[NSMutableDictionary alloc] init];
    [exportData setObject:[[ourData myData] valueForKey:popTitle] forKey:popTitle];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi exportProfile:exportData];
    NSLog(@"export settings:%@",exportData);
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
        [cellView.textField setEditable:YES]; // Make Cell Editable!

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
  //  curentName = [textName stringValue];
  //  curentWidth = [textWidth floatValue];
  //  curentHeight = [textHeight floatValue];
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
    [self.myView updateDisplay];
}//end updateDusplayView

#pragma mark - Name Table Action
- (IBAction)nameAction:(id)sender {
    NSString *updateName = [sender stringValue];
    NSMutableArray *subRowData = [[NSMutableArray alloc] initWithArray:[ourData getRowData:popTitle]];
    NSMutableArray *newSubArray = [[NSMutableArray alloc] initWithArray:[ourData replaceSubArray:subRowData atIndex:rowSelection setStrValue:updateName valueForKey:@"Name"]];
    [ourData setNameColom:newSubArray];
    [[[[ourData myData] valueForKey:popTitle] objectAtIndex:rowSelection] setObject:updateName forKey:@"Width"];

    curentName = updateName;
}

#pragma mark Width Table Action
- (IBAction)widthTableAction:(id)sender {
    float newFloat = [sender floatValue];
    NSMutableArray *usersColome = [[NSMutableArray alloc] initWithArray:[ourData widthColom]];
    [usersColome replaceObjectAtIndex:rowSelection withObject:[NSNumber numberWithFloat:newFloat]];
    [ourData setWidthColom:usersColome];
    [[[[ourData myData] valueForKey:popTitle] objectAtIndex:rowSelection] setObject:[NSNumber numberWithFloat:newFloat] forKey:@"Width"];
   // [self updateDisplayView];
}

- (IBAction)heightTableAction:(id)sender {
    float newFloat = [sender floatValue];
    NSMutableArray *usersColome = [[NSMutableArray alloc] initWithArray:[ourData hightColom]];
    [usersColome replaceObjectAtIndex:rowSelection withObject:[NSNumber numberWithFloat:newFloat]];
    [ourData setHightColom:usersColome];
    [[[[ourData myData] valueForKey:popTitle] objectAtIndex:rowSelection] setObject:[NSNumber numberWithFloat:newFloat] forKey:@"Height"];
   // [self updateDisplayView];
}

#pragma mark - update the table
-(void)updateSubTabile {
    NSArray *dicData = [[NSArray alloc] initWithArray:[[ourData myData] valueForKey:popTitle]];
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
    NSLog(@"import Item:%@",[ourData myData]);
}

#pragma mark handly table manubar
- (IBAction)segmentedAction:(id)sender {
    NSInteger clickedSegment = [sender selectedSegment];
    NSInteger clickedSegmentTag = [[sender cell] tagForSegment:clickedSegment];

    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
    NSMutableArray *dicDataAry = [[NSMutableArray alloc] initWithArray:[[ourData myData] valueForKey:popTitle]];
    NSMutableArray *tempName = [[NSMutableArray alloc] initWithArray:[ourData nameColom]];
    NSMutableArray *tempWidh = [[NSMutableArray alloc] initWithArray:[ourData widthColom]];
    NSMutableArray *tempHeight = [[NSMutableArray alloc] initWithArray:[ourData hightColom]];
    if (popMenu ==YES) {
        if (clickedSegmentTag == 0) {
            //NSLog(@"add");
           // [temp setValuesForKeysWithDictionary:[ourData newData:popTitle]];
           //add to the array
            [tempName addObject:@"Icon"];
            [tempWidh addObject:[NSNumber numberWithFloat:40]];
            [tempHeight addObject:[NSNumber numberWithFloat:40]];
            
            [ourData setNameColom:tempName];
            [ourData setWidthColom:tempWidh];
            [ourData setHightColom:tempHeight];
            
            [dicDataAry addObject:[ourData createNewData]];
            [tempDic setObject:dicDataAry forKey:popTitle];
            [ourData setMyData:tempDic];
          //  NSLog(@"add roes:%@",[ourData myData]);
            [self updateDisplayView];
            [tableView reloadData];
        }//end clicked Segment Tag
        
        if (clickedSegmentTag == 1 ) {
//NSLog(@"sub table");
            if (dicDataAry > 0) {
                [tempName removeLastObject];
                [tempWidh removeLastObject];
                [tempHeight removeLastObject];
                
                [ourData setNameColom:tempName];
                [ourData setWidthColom:tempWidh];
                [ourData setHightColom:tempHeight];
                
                [dicDataAry removeLastObject];
                [tempDic setObject:dicDataAry forKey:popTitle];
                [ourData setMyData:tempDic];
               // NSLog(@"subtract tempDic:%@",tempDic);
                
                [self updateDisplayView];
                [tableView reloadData];
            }//error handyling
        }
        
  //  [[ourData myData] setObject:[ourData createNewData] forKey:popTitle];
        
    }//end if popMenu
    if (clickedSegmentTag == 2) {
        imageData = [[NSImage alloc]init];
        LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
        imageData = [lsi loadFileImage];
        [self.myView setMyImage:imageData];
        [self updateDisplayView];
      //  NSLog(@"imageData:%@ width:%f Hight:%f",imageData,curentWidth,curentHeight);
    }
//NSLog(@"myDate%@",[ourData myData]);
}//end srgmentedAction

- (IBAction)sacleAction:(id)sender {
    float imageScale = [sender floatValue];
    [self.myView imageSize:imageScale];
  //  NSLog(@"sacle:%f",imageScale);
}

#pragma mark Change PopUp title
- (IBAction)profileSelectionAction:(id)sender {
//NSLog(@"profileSelectionAction:%@",myData);
 //   [ourData setMyData:myData];
    NSString *newTitle = [sender titleOfSelectedItem];
    popTitle = newTitle;
    //update
    [self changeTable:newTitle];
    [tableView reloadData];
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
-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pvcSegue"]) {
        //NSLog(@"todo");
        profilesViewControler *pvc = segue.destinationController;
        pvc.delegate = self;
    
        [pvc popOverData:[ourData getDictionaryKeyNames]];
    }
    
    if ([segue.identifier isEqualToString:@"imageSegue"]) {
    //    NSLog(@"imageSegue");
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
    NSLog(@"title ary:%@",ourTitleAry);
    if ([ourTitleAry isNotEqualTo:@""]) {
        popMenu = YES;
        NSString *ourTitleString = [ourTitleAry lastObject];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
        [temp setValuesForKeysWithDictionary:[ourData newData:ourTitleString]];
        [ourData setMyData:temp];
        
        [self createPopup:ourTitleAry];
        [self changeTable:ourTitle];
        popTitle = ourTitleString;
        
        [self updateDisplayView];
        NSLog(@"titleLabel ourData:%@",[ourData myData]);

        [tableView reloadData];
    }
}
//end handly delgate
-(void)createPopup:(NSArray*)popupTitle{
    NSDictionary *oldMyData = [ourData myData];
    NSMutableDictionary *rootDic = [[NSMutableDictionary alloc] initWithDictionary:[ourData createMainData:popupTitle oldData:oldMyData]];

 /*NSArray *allPopUp = [[NSArray alloc]initWithArray:[ourData getDictionaryKeyNames]];
    for (int i = 0; i < [[ourData getDictionaryKeyNames] count]; i++) {
        if ([[allPopUp objectAtIndex:i] isNotEqualTo:[allPopUp objectAtIndex:i]] ) {
            NSLog(@"update root array");
        }
    }*/
    
    //creat new root
    [ourData setMyData:rootDic];
    [profileSelectionOutlet addItemsWithTitles:[ourData getDictionaryKeyNames]];
    //set popup title
     [profileSelectionOutlet selectItemWithTitle:[[ourData getDictionaryKeyNames] objectAtIndex:0]];
    
  // NSLog(@"ourData:%@",[ourData myData]);
    /*[profileSelectionOutlet addItemsWithTitles:[ourData getDictionaryKeyNames]];
    NSString *lastTitieName =  [[ourData getDictionaryKeyNames] lastObject];
    [profileSelectionOutlet selectItemWithTitle:lastTitieName];
    NSLog(@"popup:%@",[ourData getDictionaryKeyNames]);*/
}
@end