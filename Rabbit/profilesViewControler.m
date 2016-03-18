//
//  profilesViewControler.m
//  Rabbit
//
//  Created by andrew hazlett on 3/3/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "profilesViewControler.h"

@interface profilesViewControler ()
@end

@implementation profilesViewControler

@synthesize delegate;
@synthesize profileOutlet;
//@synthesize titleText = _titleText;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

}

- (IBAction)newButtonAction:(id)sender {
    [self enterText];
}

- (BOOL)textFieldShouldReturn:(NSTextField *)textField {
    [textField resignFirstResponder];
  //  NSLog(@"return");
    return NO;
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewController:self];
}

- (IBAction)textField:(id)sender {
    [self enterText];
}

-(void)enterText {
    NSString *theTitileText = [profileOutlet stringValue];
    [delegate titleLabel:theTitileText];
    [self dismissViewController:self];
}
@end