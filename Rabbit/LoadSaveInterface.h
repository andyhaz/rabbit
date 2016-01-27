//
//  LoadSaveInterface.h
//  Load and save Data
//
//  Created by andrew hazlett on 3/29/15.
//  Copyright (c) 2015 andrew hazlett. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface LoadSaveInterface : NSObject

-(void)saveFileSata :(NSString*)stringData;
-(NSString*)loadFileData;

@end