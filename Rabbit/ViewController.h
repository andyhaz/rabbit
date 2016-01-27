//
//  ViewController.h
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "templateWindowsContorller.h"
#import "exportViewControler.h"
#import "myView.h"

@interface ViewController : NSViewController {
    templateWindowsContorller *twc;
    exportViewControler *evc;
}

- (IBAction)exportItem:(id)sender;

- (IBAction)newTemplateButton:(id)sender;

@end