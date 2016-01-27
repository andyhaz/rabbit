//
//  sharedData.m
//  sharedObject
//
//  Created by andrew hazlett on 1/24/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "sharedData.h"

@implementation sharedData

@synthesize keyData = _keyData;
@synthesize debuge = _debuge;

- (void) SODClearData {
    // Clear the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@" " forKey:_keyData];
    
    [defaults synchronize];

    if (_debuge) NSLog(@"Data Clear");
}

- (void) SODsaveDataString: (NSString*)myString {
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:myString forKey:_keyData];
    
    [defaults synchronize];
    
    if (_debuge)  NSLog(@"Data saved string");

}

- (void) SODsaveDataArray: (NSArray*)myArray {
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:myArray forKey:_keyData];
    
    [defaults synchronize];
    
   if (_debuge) NSLog(@"Data saved array");
    
}

- (void) SODsaveDataDictionary: (NSDictionary*)myDictionary {
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:myDictionary forKey:_keyData];
    
    [defaults synchronize];
    
   if (_debuge) NSLog(@"Data saved Dictionary");
    
}

- (NSString*) SODloadDataString {
    // Get the stored data before the view loads
    NSUserDefaults *loadDefaults = [NSUserDefaults standardUserDefaults];
    
    if (_debuge) NSLog(@"load Data");
    
    return [loadDefaults objectForKey:_keyData];
}

- (NSArray*) SODloadDataArray {
    // Get the stored data before the view loads
    NSUserDefaults *loadDefaults = [NSUserDefaults standardUserDefaults];
    
   if (_debuge)  NSLog(@"load Data");
    
    return [loadDefaults objectForKey:_keyData];
}

- (NSDictionary*) SODloadDataDictionary {
    // Get the stored data before the view loads
    NSUserDefaults *loadDefaults = [NSUserDefaults standardUserDefaults];
    
    if (_debuge) NSLog(@"load Data");
    
    return [loadDefaults objectForKey:_keyData];
}
@end