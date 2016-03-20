//
//  addTableViewController.h
//  Rabbit
//
//  Created by andrew hazlett on 3/19/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol addTableControllerDelegate <NSObject>
    -(void)addTableName:(NSString*)titleName width:(float)width height:(float)height;
    -(void)updateTable:(NSString*)titleName width:(float)width height:(float)height;
@end

@interface addTableViewController : NSViewController

@property(weak) id <addTableControllerDelegate>delegate;
@property(nonatomic,retain) NSString *titeName;
@property(nonatomic) float width;
@property(nonatomic) float height;
//end delaget

@property (weak) IBOutlet NSTextField *nameOutet;
@property (weak) IBOutlet NSTextField *widthOutlet;
@property (weak) IBOutlet NSTextField *heightOutlet;

- (IBAction)addAction:(id)sender;

@end
