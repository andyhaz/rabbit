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
    NSSavePanel * zSavePanel = [NSSavePanel savePanel];
    NSArray * zAryOfExtensions = [NSArray arrayWithObject:@"rab"];
    [zSavePanel setAllowedFileTypes:zAryOfExtensions];
    
    NSInteger zResult = [zSavePanel runModal];
    
    if (zResult == NSFileHandlingPanelCancelButton) {
        NSLog(@"writeUsingSavePanel cancelled");
        return;
    }
    NSURL *zUrl = [zSavePanel URL];
    
    NSString *writeData = [NSString stringWithFormat:@"%@",stringData];
    //write
    BOOL zBoolResult = [writeData writeToURL:zUrl
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
   // NSString * zStr = [NSString stringWithContentsOfURL:zUrl
     //                                          encoding:NSASCIIStringEncoding
       //                                           error:NULL];
    // NSLog(@"zStr=\n%@",zStr);
    
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:zUrl];

    return image;
}
@end
