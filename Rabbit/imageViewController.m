//
//  imageViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 3/18/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "imageViewController.h"

@implementation imageViewController

@synthesize imageData,dataAray,arraySize;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pngSetting = YES;
    jpgSetting = YES;
    tiffSetting = YES;
}
#pragma mark impage export setteings
- (IBAction)pngAction:(id)sender {
    if (pngSetting == YES) {
        pngSetting = NO;
    } else {
        pngSetting = YES;
    }
}

- (IBAction)jpgeAction:(id)sender {
    if (jpgSetting == YES) {
        jpgSetting = NO;
    } else {
        jpgSetting = YES;
    }
}

- (IBAction)tiffAction:(id)sender {
    if (tiffSetting == YES) {
        tiffSetting = NO;
    } else {
        tiffSetting = YES;
    }
}

- (IBAction)saveImageAction:(id)sender {
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi setPng:pngSetting];
    [lsi setJpg:jpgSetting];
    [lsi setTiff:tiffSetting];
    //  NSLog(@"rowDataWidth:%@f %@f",[ourData widthColom],[ourData hightColom]);
    if (arraySize <= 0 || imageData == NULL ) {
        alertInfo *ai = [[alertInfo alloc]init];
        [ai showAlert:@"Error" Massage:@"Incomplet data to exoprt"];
    } else {
        if (pngSetting == YES || jpgSetting == YES || tiffSetting == YES) {
            [lsi exportFileImages:imageData :dataAray];
        }//end
    }
    [self dismissController:self];
}

@end
