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

@property() BOOL png;
@property() BOOL jpg;
@property() BOOL tiff;


-(void)saveFileData :(NSDictionary*)stringData;
-(NSDictionary*)loadFileData;

-(NSImage*)loadFileImage;
-(void)exportFileImages :(NSImage *)image :(NSArray*)aryData;
//-(void)saveImage:(NSImage *)image :(NSInteger)size;

-(void)saveSngleImage :(NSImage *)image :(NSArray*)aryData;

-(NSMutableDictionary*)importProfile;
-(void)exportProfile:(NSDictionary*)repData;

@end
