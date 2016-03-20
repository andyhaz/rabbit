//
//  addTableViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 3/19/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "addTableViewController.h"

@interface addTableViewController ()

@end
@implementation addTableViewController

@synthesize delegate;
@synthesize nameOutet,widthOutlet,heightOutlet;
@synthesize titeName,width,height;
- (void)viewDidLoad {
    [super viewDidLoad];
//Do view setup here.
    [nameOutet setStringValue:titeName];//[nameOutet setStringValue:rowString];
    [widthOutlet setFloatValue:width];
    [heightOutlet setFloatValue:height];
}

- (IBAction)addAction:(id)sender {
    [delegate addTableName:[nameOutet stringValue] width:[widthOutlet floatValue] height:[heightOutlet floatValue]];
    [self dismissController:self];
}
@end
