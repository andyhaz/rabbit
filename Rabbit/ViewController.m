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
@synthesize rowDataName,rowDataHeight,rowDataWidth,profileNameArray,profileDataArray;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    rowSelection = 0;
    edit = NO;
    pngSetting = YES;
    jpgSetting = YES;
    tiffSetting = YES;
    profileDataArray = [[NSMutableArray alloc]init];
    profileNameArray = [[NSMutableArray alloc]init];
    rowDataName = [[NSMutableArray alloc]init];
    rowDataWidth = [[NSMutableArray alloc]init];
    rowDataHeight = [[NSMutableArray alloc]init];
    
    NSSize newSize = NSMakeSize(80, 80);
     
    [rowDataName addObject:@"Icon"];
    [rowDataWidth addObject:@"80"];
    [rowDataHeight addObject:@"80"];
    [tableView reloadData];
    int r = [[rowDataName lastObject] intValue];
    [self updateDisplay:r];
    [self.myView setFrameSize:newSize];
    
}


- (IBAction)importItem:(id)sender{
    NSLog(@"import image");
}

- (IBAction)exportItem:(id)sender{
     NSLog(@"export image");
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
     // NSLog(@"tableView:%@",tableColumn.identifier);
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
    
    rowSelection = row;
  //  NSLog(@"tableViewSelectionDidChange:%hd",row);
}

-(void)updateDisplay:(int)row{
     w = [[rowDataWidth objectAtIndex:row] floatValue];
     h = [[rowDataHeight objectAtIndex:row] floatValue];
    
    NSSize newSize = NSMakeSize(w, h);
    float newScale = (w/2)+(h/2);
    
    [self.myView imageSize:newScale];
    [self.myView setFrameSize:newSize];
}


- (IBAction)nameAction:(id)sender {
 [rowDataName replaceObjectAtIndex:rowSelection withObject:[sender stringValue]];
}

- (IBAction)widthTableAction:(id)sender {
    [rowDataWidth replaceObjectAtIndex:rowSelection withObject:[sender stringValue]];
}

- (IBAction)heightTableAction:(id)sender {
    [rowDataHeight replaceObjectAtIndex:rowSelection withObject:[sender stringValue]];
}

- (IBAction)segmentedAction:(id)sender {
    NSInteger clickedSegment = [sender selectedSegment];
    NSInteger clickedSegmentTag = [[sender cell] tagForSegment:clickedSegment];
  //  NSLog(@"clickedSegmentTag:%ld",(long)clickedSegmentTag);
    switch (clickedSegmentTag) {
        case 0:
          //  NSLog(@"add table");
            [rowDataName addObject:@"Icon"];
            [rowDataWidth addObject:@"40"];
            [rowDataHeight addObject:@"40"];
            [tableView reloadData];
            int r = [[rowDataName lastObject] intValue];
            [self updateDisplay:r];
            break;
        case 1:
          //  NSLog(@"sub table");
            [rowDataName removeLastObject];
            [rowDataWidth removeLastObject];
            [rowDataHeight removeLastObject];
            [tableView reloadData];
            break;
        case 2:
           //  NSLog(@"edit");
            if (edit == NO) {
                edit = YES;
            } else {
                edit = NO;
            }
            [tableView reloadData];
            break;
        default:
            break;
    }
}


- (IBAction)sacleAction:(id)sender {
    float imageScale = [sender floatValue];
    [self.myView imageSize:imageScale];
  //  NSLog(@"sacle:%f",imageScale);
}

- (IBAction)profileTextAction:(id)sender {
    [self profileSettings];
}


- (IBAction)profileSelectionAction:(id)sender {
    NSString *str = [profileSelectionOutlet stringValue];
    NSLog(@"%@",str);
}

- (IBAction)importImageAction:(id)sender {
    imageData = [[NSImage alloc]init];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    imageData = [lsi loadFileImage];
    
    float newSize = (w/2)+(h/2);
    
    [self.myView setMyImage:imageData];
    [self.myView imageSize:newSize];
    [self.myView updateDisplay];
    NSLog(@"import Image:%@ - size:%f",imageData,newSize);
}

-(void)profileSettings{
 /*   NSString *getText = [profileTextFeild stringValue];
    [profileNameArray addObject:getText];  */
    [profileSelectionOutlet addItemsWithTitles:profileNameArray];
    [profileDataArray addObject:profileNameArray];
    [profileDataArray addObject:rowDataName];
    [profileDataArray addObject:rowDataWidth];
    [profileDataArray addObject:rowDataHeight];
//set up title bar
    NSString *lastTitieName =  [profileNameArray lastObject];
    [profileSelectionOutlet selectItemWithTitle:lastTitieName];

    NSLog(@"%@",profileNameArray);
}
//handly delegat
- (void)titleLabel:(NSString*)ourTitle {
    [profileNameArray addObject:ourTitle];
    [self profileSettings];
    // NSLog(@"title Label:%@",profileNameArray);
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
    cleanDataArray *cda = [[cleanDataArray alloc]init];
    
    [lsi setPng:pngSetting];
    [lsi setJpg:jpgSetting];
    [lsi setTiff:tiffSetting];
    if (pngSetting == YES || jpgSetting == YES || tiffSetting == YES) {
        [lsi exportFileImages:imageData :[cda cleanArray:rowDataName width:rowDataWidth height:rowDataHeight]];
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