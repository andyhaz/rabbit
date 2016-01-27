//
//  sharedData.h
//  sharedObject
//
//  Created by andrew hazlett on 1/24/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sharedData : NSObject

@property (retain) NSString *keyData;
@property () BOOL debuge;

- (void) SODClearData;
//save data
- (void) SODsaveDataString: (NSString*)myString;
- (void) SODsaveDataArray: (NSArray*)myArray;
- (void) SODsaveDataDictionary: (NSDictionary*)myDictionary;
//load data
- (NSString*) SODloadDataString ;
- (NSArray*) SODloadDataArray ;
- (NSDictionary*) SODloadDataDictionary;@end