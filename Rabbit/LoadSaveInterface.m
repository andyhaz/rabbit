//
//  LoadSaveInterface.m
//  Load and save Data
//
//  Created by andrew hazlett on 3/29/15.
//  Copyright (c) 2015 andrew hazlett. All rights reserved.
//

#import "LoadSaveInterface.h"

@implementation LoadSaveInterface

@synthesize png,jpg,tiff;

-(void)saveFileData :(NSDictionary*)stringData{
    // get the file url
    NSSavePanel * SavePanel = [NSSavePanel savePanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObject:@"rab"];
    [SavePanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zResult = [SavePanel runModal];
    
    if (zResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
    NSString *path = [[SavePanel URL] path];
    
    NSString *writeData = [NSString stringWithFormat:@"%@",stringData];
    //write
    BOOL zBoolResult = [writeData writeToFile:path
                                  atomically:YES
                                    encoding:NSASCIIStringEncoding
                                       error:NULL];
    if (! zBoolResult) {
        NSLog(@"writeUsingSavePanel failed");
    }
    NSLog(@"zStr=\n%@",writeData);
}


-(NSDictionary*)loadFileData{
    NSOpenPanel * zOpenPanel = [NSOpenPanel openPanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObject:@"rab"];
    [zOpenPanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zIntResult = [zOpenPanel runModal];
    if (zIntResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"readUsingOpenPanel cancelled");
    }
    NSURL *zUrl = [zOpenPanel URL];
    
    // read the file
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfURL:zUrl];

    return dic;
}
#pragma mark import/export handling
-(NSMutableDictionary*)importProfile{
    NSOpenPanel * zOpenPanel = [NSOpenPanel openPanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObject:@"rep"];
    [zOpenPanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zIntResult = [zOpenPanel runModal];
    if (zIntResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"readUsingOpenPanel cancelled");
    }
    NSURL *zUrl = [zOpenPanel URL];
    // read the file
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfURL:zUrl];
  //  NSLog(@"dic: %@",dic);
    return dic;
}

-(void)exportProfile:(NSDictionary*)repData{
    // get the file url
    NSSavePanel * SavePanel = [NSSavePanel savePanel];
    NSArray * AryOfExtensions = [NSArray arrayWithObject:@"rep"];
    [SavePanel setAllowedFileTypes:AryOfExtensions];
    
    NSInteger Result = [SavePanel runModal];
    
    if (Result == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
    NSString *path = [[SavePanel URL] path];
    
    NSString *writeData = [NSString stringWithFormat:@"%@",repData];
    
    //write
    BOOL zBoolResult = [writeData writeToFile:path
                                   atomically:YES
                                     encoding:NSASCIIStringEncoding
                                        error:NULL];
    if (! zBoolResult) {
        NSLog(@"writeUsingSavePanel failed");
    }
  //  NSLog(@"zStr=\n%@",writeData);
}

#pragma mark image handling
-(NSImage*)loadFileImage{
    NSOpenPanel * OpenPanel = [NSOpenPanel openPanel];
    NSArray * AryOfExtensions = [NSArray arrayWithObjects:@"png",@"jpg",@"psd",@"tiff",@"tif",@"bmp",@"esp",nil];
    [OpenPanel setAllowedFileTypes:AryOfExtensions];
    
    NSInteger IntResult = [OpenPanel runModal];
    if (IntResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"readUsingOpenPanel cancelled");
    }//end url
    NSURL *path = [OpenPanel URL];
    
    // read the file
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:path];
    
    return image;
}

//export image
-(void)exportFileImages :(NSImage *)image :(NSArray*)aryData{
    BOOL        success;
    NSError *   error;
//get the file
    NSSavePanel *SavePanel = [NSSavePanel savePanel];
    [SavePanel setAllowsOtherFileTypes:NO];
    
    NSInteger Result = [SavePanel runModal];
    
    NSURL *pathURL = [SavePanel URL];
 //   NSLog(@"path:%@",pathURL);
    success = [[NSFileManager defaultManager] createDirectoryAtURL:pathURL withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSInteger imageCont = (aryData.count)/3;
    NSInteger imageNum = 0;
    if (Result == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
//
//NSLog(@"aryData:%@",aryData);
    for (int i = 0; i < imageCont; i++) {
        NSString *tableName = aryData[imageNum];
        imageNum ++;
        NSInteger sizeY = [aryData[imageNum] floatValue];
        imageNum ++;
        NSInteger sizeX = [aryData[imageNum] floatValue];
        imageNum ++;
//create image
//NSLog(@"save pale:%@",SavePanel.nameFieldStringValue);
        NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes:NULL
                                 pixelsWide:sizeY
                                 pixelsHigh:sizeX
                                 bitsPerSample:8
                                 samplesPerPixel:4
                                 hasAlpha:YES
                                 isPlanar:NO
                                 colorSpaceName:NSCalibratedRGBColorSpace
                                 bytesPerRow:0
                                 bitsPerPixel:0];
        [rep setSize:NSMakeSize(sizeX, sizeY)];
        
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
        
        [image drawInRect:NSMakeRect(0, 0, sizeX, sizeY) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
        
        [NSGraphicsContext restoreGraphicsState];
        
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
        
        NSData *pngData,*jpgData,*tiffData;
        NSString *newFileNamePng,*newFileNameJpg,*newFileNameTiff;
        NSError *error = nil;
        //
        BOOL BoolResult = '\0';
        //set filename
        if (png == true) {
            newFileNamePng = [NSString stringWithFormat:@"%@(%ldx%ld)",tableName,(long)sizeX,(long)sizeY];
            NSURL * fileURL = [[pathURL URLByAppendingPathComponent:newFileNamePng] URLByAppendingPathExtension:@"png"];
            pngData = [rep representationUsingType:NSPNGFileType properties:options];
            
            BoolResult = [pngData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        }
        
        if (jpg == true) {
            newFileNameJpg = [NSString stringWithFormat:@"%@(%ldx%ld)",tableName,(long)sizeX,(long)sizeY];
            NSURL * fileURL = [[pathURL URLByAppendingPathComponent:newFileNameJpg] URLByAppendingPathExtension:@"jpg"];
            jpgData = [rep representationUsingType:NSJPEGFileType properties:options];
            
            BoolResult = [jpgData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        }
        
        if (tiff == true) {
             newFileNameTiff = [NSString stringWithFormat:@"%@(%ldx%ld)",tableName,(long)sizeX,(long)sizeY];
             NSURL * fileURL = [[pathURL URLByAppendingPathComponent:newFileNameTiff] URLByAppendingPathExtension:@"tiff"];

             tiffData = [rep representationUsingType:NSTIFFFileType properties:options];
             BoolResult = [tiffData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        }
        
        if (!BoolResult) {
            NSLog(@"writeUsingSavePanel failed");
            NSLog(@"Write returned error: %@", [error localizedDescription]);
        }//end if
    }//end for loop
}
@end