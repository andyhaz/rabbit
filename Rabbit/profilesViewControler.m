//
//  profilesViewControler.m
//  Rabbit
//
//  Created by andrew hazlett on 3/3/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "profilesViewControler.h"


@interface profilesViewControler (){
    NSInteger rowSelectionTable;
}
@end

@implementation profilesViewControler

@synthesize tableView;
@synthesize delegate;
@synthesize profileTitle;
//@synthesize titleText = _titleText;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    rowSelectionTable = 0;
}

-(void)popOverData:(NSArray*)popAry{
  //  NSLog(@"popover Dara:%@",popAry);
    profileTitle = [[NSMutableArray alloc] initWithArray:popAry];
    if (!popAry)[profileTitle addObject:@"Empty Title"];
    [tableView reloadData];
}

- (IBAction)buttonBarAction:(id)sender {
    NSInteger clickedSegment = [sender selectedSegment];
    NSInteger clickedSegmentTag = [[sender cell] tagForSegment:clickedSegment];
    NSLog(@"%ld",(long)clickedSegmentTag);
    
    if (clickedSegmentTag == 0) {
     //   NSLog(@"add");
        [profileTitle addObject:@"Empty Title"];
        [tableView reloadData];
    }
    
    if (clickedSegmentTag == 1) {
       // NSLog(@"sub");
        if ([profileTitle count] > 0 ) {
            [profileTitle removeLastObject];
            [tableView reloadData];
        }
    }
    
    if (clickedSegmentTag == 3) {
        NSLog(@"done:%@",profileTitle);
        [delegate titleLabel:profileTitle];
        [self dismissViewController:self];
    }

    if (clickedSegmentTag == 4) {
       // NSLog(@"cancle");
        [self dismissViewController:self];
    }
}//end srgmentedAction

#pragma mark - tableView setup
- (NSView *)tableView:(NSTableView *)mytableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    //name
    if([tableColumn.identifier isEqualToString:@"newTitle"])
    {
        cellView.textField.stringValue = [profileTitle objectAtIndex:row];
        [cellView.textField setEditable:YES]; // Make Cell Editable!
     //   rowSelection = row;
        return cellView;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    //  NSLog(@"row numbers:%lu",(unsigned long)[profileTitle count]);
    return [profileTitle count];
}

#pragma mark select table item
-(void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger row = [[notification object] selectedRow];
    NSTextField *textName = [[[notification.object viewAtColumn:0 row:row makeIfNecessary:NO]subviews] lastObject];
    [textName selectText:textName.stringValue];
    rowSelectionTable = row;
    NSLog(@"row:%ld",(long)row);
}

#pragma mark - Name Table Action
- (IBAction)nameAction:(id)sender {
    NSString *updateTitleName = [sender stringValue];
    [profileTitle replaceObjectAtIndex:rowSelectionTable withObject:updateTitleName];
   // NSLog(@"profile title:%@",profileTitle);
}

@end