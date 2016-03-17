//
//  profilesViewControler.h
//  Rabbit
//
//  Created by andrew hazlett on 3/3/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol popOverControllerDelegate <NSObject>
    - (void) titleLabel:(NSString*)ourTitle;
@end

@interface profilesViewControler : NSViewController<NSPopoverDelegate>

    @property(weak) id <popOverControllerDelegate> delegate;
    @property (nonatomic, retain) NSString *ourTitle;

@property (weak) IBOutlet NSTextField *profileOutlet;
- (IBAction)newButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)textField:(id)sender;

@end
