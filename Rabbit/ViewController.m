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
//@synthesize rowDataName,rowDataHeight,rowDataWidth,profileNameArray,profileDataArray,profileRootDictionary;
@synthesize myData,colomData,rowData;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    rowSelection = 0;
    edit = NO;
    pngSetting = YES;
    jpgSetting = YES;
    tiffSetting = YES;
    
    ourData = [[DataArray alloc]init];
    myData = [[NSMutableDictionary alloc]init];
    colomData = [[NSMutableDictionary alloc]init];
    rowData = [[NSMutableArray alloc]init];
    
    [self updateDisplayView];
}

- (IBAction)importItem:(id)sender{
    NSLog(@"import settings");
}

- (IBAction)exportItem:(id)sender{
     NSLog(@"export settings");
}

//
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // Since this is a single-column table view, this would not be necessary.
    // But it's a good practice to do it in order by remember it when a table is multicolumn.
    if( [tableColumn.identifier isEqualToString:@"nameID"] )
    {
        //  cellView.imageView.image = @"";
        cellView.textField.stringValue = [ourData getNameAtIndex:row];// [self.rowDataName objectAtIndex:row];
        [cellView.textField setEditable:edit]; // Make Cell Editable!
        
        return cellView;
    }
    //widthID
    if( [tableColumn.identifier isEqualToString:@"widthID"] )
    {
        cellView.textField.stringValue =[ourData getWidthAtIndex:row];//[self.rowDataWidth objectAtIndex:row];
        [cellView.textField setEditable:edit]; // Make Cell Editable!
        
        return cellView;
    }
    //heightID
    if( [tableColumn.identifier isEqualToString:@"heightID"] )
    {
        cellView.textField.stringValue =[ourData getHeightAtIndex:row]; //[self.rowDataHeight objectAtIndex:row];
        [cellView.textField setEditable:edit]; // Make Cell Editable!
        
        return cellView;
    }
     // NSLog(@"tableView:%@",tableColumn.identifier);
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[ourData nameColom] count];// [self.rowDataName count];
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
    [ourData updateName:row newData:[textName stringValue]];
    [ourData updateWidth:row newData:[textWidth stringValue]];
    [ourData updateHieght:row newData:[textHeight stringValue]];
    
    [self updateDisplay:row];
    
    rowSelection = row;
  //  NSLog(@"tableViewSelectionDidChange:%hd",row);
}

-(void)updateDisplay:(int)row{
    w = [[ourData getWidthAtIndex:row] floatValue];
    h = [[ourData getHeightAtIndex:row] floatValue];
    
    NSSize newSize = NSMakeSize(w, h);
    float newScale = (w/2)+(h/2);
    
    [self.myView imageSize:newScale];
    [self.myView setFrameSize:newSize];
}

- (IBAction)nameAction:(id)sender {
    [ourData updateName:rowSelection newData:[sender stringValue]];
   // [rowDataName replaceObjectAtIndex:rowSelection withObject:[sender stringValue]];
}

- (IBAction)widthTableAction:(id)sender {
    [ourData updateWidth:rowSelection newData:[sender stringValue]];
  //  [rowDataWidth replaceObjectAtIndex:rowSelection withObject:[sender stringValue]];
}

- (IBAction)heightTableAction:(id)sender {
    [ourData updateHieght:rowSelection newData:[sender stringValue]];
  //  [rowDataHeight replaceObjectAtIndex:rowSelection withObject:[sender stringValue]];
}

- (IBAction)segmentedAction:(id)sender {
    NSInteger clickedSegment = [sender selectedSegment];
    NSInteger clickedSegmentTag = [[sender cell] tagForSegment:clickedSegment];
  //  NSLog(@"clickedSegmentTag:%ld",(long)clickedSegmentTag);
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:[ourData getRowData:popTitle]];
    NSMutableDictionary *oldDict = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//  NSLog(@"dict:%@",dict);
    /*
     NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
     [temp setValuesForKeysWithDictionary:[ourData newData:ourTitle]];
     [ourData setMyData:temp];
     */
    if (clickedSegmentTag == 0) {
        [temp addObject:[ourData newTableData]];
        [dict setObject:temp forKey:popTitle];
        [oldDict setValuesForKeysWithDictionary:dict];
        [ourData setMyData:oldDict];
        [self changeTable:popTitle];
        [self updateDisplayView];
        [tableView reloadData];
       // NSLog(@"clickedSegmentTag ourdata:%@",[ourData myData]);
    }
    
    if (clickedSegmentTag == 1 ) {
//NSLog(@"sub table");
        [temp removeLastObject];
        [dict setObject:temp forKey:popTitle];
        [ourData setMyData:dict];
        [self changeTable:popTitle];
        [self updateDisplayView];
        [tableView reloadData];
    }
    
    if (clickedSegmentTag == 2 ) {
//  NSLog(@"edit");
        if (edit == NO) {
            edit = YES;
        } else {
            edit = NO;
        }
        [tableView reloadData];
    }
  //  NSLog(@"myDate%@",[ourData myData]);
}

- (IBAction)sacleAction:(id)sender {
    float imageScale = [sender floatValue];
    [self.myView imageSize:imageScale];
  //  NSLog(@"sacle:%f",imageScale);
}

- (IBAction)profileTextAction:(id)sender {
    NSLog(@"profileTextAction");
}

- (IBAction)profileSelectionAction:(id)sender {
    NSString *newTitle = [sender titleOfSelectedItem];
    popTitle = newTitle;
    [self changeTable:newTitle];
    [tableView reloadData];
    NSLog(@"profileSelectionAction:%@ \n %@",newTitle,[ourData myData]);
}

- (IBAction)importImageAction:(id)sender {
    imageData = [[NSImage alloc]init];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    imageData = [lsi loadFileImage];
    
    float newSize = (w/2)+(h/2);
    
    [self.myView setMyImage:imageData];
    [self.myView imageSize:newSize];
    [self.myView updateDisplay];
  //  NSLog(@"import Image:%@ - size:%f",imageData,newSize);
}

-(void)createPopup:(NSString*)popupTitle{
    [profileSelectionOutlet addItemsWithTitles:[ourData getDictionaryKeyNames]];
    NSString *lastTitieName =  [[ourData getDictionaryKeyNames] lastObject];
    [profileSelectionOutlet selectItemWithTitle:lastTitieName];
 //   NSLog(@"last titlw:%@",lastTitieName);
}

-(void)changeTable:(NSString*)tableTitle{
    NSArray *myRowData = [[NSArray alloc] initWithArray:[ourData getRowData:tableTitle]];
    //  NSLog(@"row data:%@",myRowData);
    [ourData setNameColom:[myRowData valueForKey:@"Name"]];
    [ourData setWidthColom:[myRowData valueForKey:@"Width"]];
    [ourData setHightColom:[myRowData valueForKey:@"Height"]];
}

-(void)updateDisplayView {
    NSSize newSize = NSMakeSize(80, 80);
    int r = [[[ourData getDictionaryKeyNames] lastObject] intValue];
    [self updateDisplay:r];
    [self.myView setFrameSize:newSize];
}

//handly delegat
- (void)titleLabel:(NSString*)ourTitle {
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[ourData myData]];
    [temp setValuesForKeysWithDictionary:[ourData newData:ourTitle]];
    [ourData setMyData:temp];
    
    [self createPopup:ourTitle];
    [self changeTable:ourTitle];
    popTitle = ourTitle;
    edit = YES;

    [self updateDisplayView];
   // [self profileSettings];
  //  NSLog(@"ourData:%@",[ourData myData]);
    [tableView reloadData];
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pvcSegue"]) {
        //NSLog(@"todo");
        profilesViewControler *pvc = segue.destinationController;
        pvc.delegate = self;
    }
}

//end hanly delgate
- (IBAction)createAction:(id)sender {
    NSLog(@"create action");
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    DataArray *cda = [[DataArray alloc]init];
    
    [lsi setPng:pngSetting];
    [lsi setJpg:jpgSetting];
    [lsi setTiff:tiffSetting];
    if (pngSetting == YES || jpgSetting == YES || tiffSetting == YES) {
        //need to update this file
//        [lsi exportFileImages:imageData :[cda cleanArray:rowDataName width:rowDataWidth height:rowDataHeight]];
    }//end
}//end creteation

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