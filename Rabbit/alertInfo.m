//
//  alertInfo.m
//  Rabbit
//
//  Created by andrew hazlett on 3/18/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "alertInfo.h"

@implementation alertInfo

-(void)showAlert:(NSString*)myError Massage:(NSString*)myMassage{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:myError];
    [alert setInformativeText:myMassage];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
}

@end