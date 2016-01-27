//
//  ViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self newTemplate];
}

- (void)newTemplate{
    if (!twc) {
        twc = [[templateWindowsContorller alloc] initWithWindowNibName:@"templateWindowsContorller"];
    }
    [twc showWindow:self];
}
@end
