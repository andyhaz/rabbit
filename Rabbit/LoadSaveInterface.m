//
//  LoadSaveInterface.m
//  Load and save Data
//
//  Created by andrew hazlett on 3/29/15.
//  Copyright (c) 2015 andrew hazlett. All rights reserved.
//

#import "LoadSaveInterface.h"

@implementation LoadSaveInterface

-(void)saveFileSata :(NSString*)stringData{
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


-(NSString*)loadFileData{
    NSOpenPanel * zOpenPanel = [NSOpenPanel openPanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObject:@"rab"];
    [zOpenPanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zIntResult = [zOpenPanel runModal];
    if (zIntResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"readUsingOpenPanel cancelled");
    }
    NSURL *zUrl = [zOpenPanel URL];
    
    // read the file
    NSString * zStr = [NSString stringWithContentsOfURL:zUrl
                                               encoding:NSASCIIStringEncoding
                                                  error:NULL];
    // NSLog(@"zStr=\n%@",zStr);
    return zStr;
}

-(NSImage*)loadFileImage{
    NSOpenPanel * zOpenPanel = [NSOpenPanel openPanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObjects:@"png",@"jpg",@"psd",nil];
    [zOpenPanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zIntResult = [zOpenPanel runModal];
    if (zIntResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"readUsingOpenPanel cancelled");
    }
    NSURL *zUrl = [zOpenPanel URL];
    
    // read the file
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:zUrl];

    return image;
}

//export image
-(void)exportFileImages :(NSImage *)image :(NSArray*)aryData{
    // get the file
    NSSavePanel *SavePanel = [NSSavePanel savePanel];
    NSInteger Result = [SavePanel runModal];
    
    NSInteger imageCont = (aryData.count)/3;
    NSInteger imageNum = 0;
  //  NSLog(@"%@:%ld",aryData,(long)imageCont);
    
    if (Result == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
//
    NSString *path = [[SavePanel URL] path];
//
    for (int i = 0; i < imageCont; i++) {
        imageNum ++;
        NSInteger sizeY = [aryData[imageNum] floatValue];
        imageNum ++;
        NSInteger sizeX = [aryData[imageNum] floatValue];
        imageNum ++;
//set filename
        NSString *newFileName = [NSString stringWithFormat:@"%@(%ldx%ld).png",path,(long)sizeX,(long)sizeY];
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
        
        NSData *pngData = [rep representationUsingType:NSPNGFileType properties:options];
        
        NSError *error = nil;
        
        BOOL BoolResult = [pngData writeToFile:newFileName options:NSDataWritingAtomic error:&error];
        
        NSLog(@"artData:%@ - path:%@",aryData,newFileName);
        
        if (!BoolResult) {
            NSLog(@"writeUsingSavePanel failed");
            NSLog(@"Write returned error: %@", [error localizedDescription]);
        }//end if
    }//end for loop
}

-(void)saveImage:(NSImage *)image :(NSInteger)size {
    NSLog(@"save image");
    // get the file
    NSSavePanel * SavePanel = [NSSavePanel savePanel];
    NSArray * AryOfExtensions = [NSArray arrayWithObject:@"png"];
    [SavePanel setAllowedFileTypes:AryOfExtensions];
    
    NSInteger Result = [SavePanel runModal];
    
    if (Result == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
    NSString *path = [[SavePanel URL] path];
//create image
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                             initWithBitmapDataPlanes:NULL
                             pixelsWide:size
                             pixelsHigh:size
                             bitsPerSample:8
                             samplesPerPixel:4
                             hasAlpha:YES
                             isPlanar:NO
                             colorSpaceName:NSCalibratedRGBColorSpace
                             bytesPerRow:0
                             bitsPerPixel:0];
    [rep setSize:NSMakeSize(size, size)];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
    [image drawInRect:NSMakeRect(0, 0, size, size)  fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    [NSGraphicsContext restoreGraphicsState];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];

    NSData *pngData = [rep representationUsingType:NSPNGFileType properties:options];
    
    NSError *error = nil;
    
    BOOL BoolResult = [pngData writeToFile:path options:NSDataWritingAtomic error:&error];

    if (! BoolResult) {
        NSLog(@"writeUsingSavePanel failed");
        NSLog(@"Write returned error: %@", [error localizedDescription]);
    }//end
}
@end