//
//  downloadInterface.m
//  Rabbit
//
//  Created by andrew hazlett on 4/13/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//
//http://gamerocketstudio.com/rabbit/index.php

#import "downloadInterface.h"

@implementation downloadInterface
/*
-(void)download {
    NSString *urlPath = @"http://gamerocketstudio.com/rabbit/index.php";
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentDir stringByAppendingPathComponent:@"iossettings.rep"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    NSLog(@"requset:%@",request);
    
    
    NSURL *url = [NSURL URLWithString:urlPath];
    NSString *myText = [NSString stringWithContentsOfURL:url];
    if (myText) {
        NSLog(@"myText:%@",myText);
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Download Error:%@",error.description);
        }
        if (data) {
         //   [data writeToFile:filePath atomically:YES];
           // NSLog(@"File is saved to %@",filePath);
        }
    }];
}*/

@end
