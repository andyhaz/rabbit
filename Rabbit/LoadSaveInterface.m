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
-(void)saveFileImages :(NSArray*)aryData{
    // get the file
    NSSavePanel * zSavePanel = [NSSavePanel savePanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObject:@"rab"];
    [zSavePanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zResult = [zSavePanel runModal];
    
    if (zResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
   // NSURL *zUrl = [zSavePanel URL];
}

-(void)saveImage:(NSImage *)image :(NSInteger)size {
    NSLog(@"save image:%@",image);
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
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext     graphicsContextWithBitmapImageRep:rep]];
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