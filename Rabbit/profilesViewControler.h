//
//  profilesViewControler.h
//  Rabbit
//
//  Created by andrew hazlett on 3/3/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol popOverControllerDelegate <NSObject>
    - (void) titleLabel:(NSArray*)ourTitle;
@end

@interface profilesViewControler : NSViewController<NSPopoverDelegate>

    @property(weak) id <popOverControllerDelegate> delegate;
    @property (nonatomic, retain) NSString *ourTitle;

@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic) NSMutableArray *profileTitle;

- (IBAction)buttonBarAction:(id)sender;

- (IBAction)nameAction:(id)sender;

-(void)popOverData:(NSArray*)popAry;

@end
