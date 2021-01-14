//
//  ViewController.m
//  Rabbit
//
//  Created by andrew hazlett on 1/26/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize profileSelectionOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initz];
}

#pragma mark - initz vaules
-(void)initz {
    [self.window setBackgroundColor: NSColor.whiteColor];

    imageEmpty = YES;
    pngSetting = YES;
    jpgSetting = YES;
    tiffSetting = YES;
    
    profileClass *pc = [[profileClass alloc]init];
    NSArray *popup = [[NSArray alloc] initWithArray:[pc listSizeData]];
  //  NSLog(@"popup:%@",popup);
    [self createPopup:popup];
    
    ourData = [[DataArray alloc]init];
    imageData = [[NSImage alloc]init];
    
    [self.myView setMyImage:imageData];
    [self.myView imageSize:[[popup objectAtIndex:6] floatValue]];
 //   [self updateDisplayView];
}

#pragma mark - new project
- (IBAction)newProject:(id)sender{
    //test has image
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Delete this project?"];
    [alert setInformativeText:@"Deleted projects cannot be restored"];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setAlertStyle:NSAlertStyleWarning];
      [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSInteger result) {
          NSLog(@"Success:");
          if (result == NSAlertSecondButtonReturn) {
              NSLog(@"Delete was cancelled!");
              return;
          }
          NSLog(@"This project was deleted!");
          if (self->imageEmpty == NO) {
                     [self initz];
              [self.myView setMyImage:self->imageData];
                     [self.myView setNeedsDisplay:YES];
                 }
      }];
    //[alert runModal];
    NSLog(@"new:%@",imageData);
}

#pragma mark - open image

- (IBAction)openImageAction:(id)sender{
   // NSLog(@"open image");
    imageData = [[NSImage alloc]init];
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    imageData = [lsi loadFileImage];
  //  NSLog(@"image data:%@",imageData);

    [self.myView setMyImage:imageData];
    [self.myView setNeedsDisplay:YES];
    imageEmpty = NO;
}

- (IBAction)saveImageAction:(id)sender{
  
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi setPng:pngSetting];
    [lsi setJpg:jpgSetting];
    [lsi setTiff:tiffSetting];
    //  NSLog(@"rowDataWidth:%@f %@f",[ourData widthColom],[ourData hightColom]);
    profileClass *pc = [[profileClass alloc]init];
    NSArray *arraySize = [[NSArray alloc] initWithArray:[pc listSizeData]];
    
    if ([arraySize count] <= 0 || imageData == NULL ) {
        alertInfo *ai = [[alertInfo alloc]init];
        [ai showAlert:@"Error" Massage:@"No Image"];
    } else {
        NSLog(@"save images;%hhd",pngSetting);
        if (pngSetting == YES || jpgSetting == YES || tiffSetting == YES) {
            [lsi exportFileImages:imageData :arraySize];
        }//end
    }
        [self dismissController:self];
}

- (IBAction)saveScreenAction:(id)sender{
    //screen shot size 1280 x 800
    NSLog(@"save screen shot%@",imageData);
    LoadSaveInterface *lsi = [[LoadSaveInterface alloc]init];
    [lsi setPng:pngSetting];
    [lsi setJpg:jpgSetting];
    [lsi setTiff:tiffSetting];
    
    NSArray *arraySize = [[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:1280],[NSNumber numberWithFloat:800], nil];
     
    if ([arraySize count] <= 0 || imageData == NULL ) {
          alertInfo *ai = [[alertInfo alloc]init];
          [ai showAlert:@"Error" Massage:@"no image"];
      } else {
       //   NSLog(@"save images;%hhd",pngSetting);
          if (pngSetting == YES || jpgSetting == YES || tiffSetting == YES) {
              [lsi saveSngleImage:imageData :arraySize];
          }//end
      }
}

#pragma mark - update Display
-(void)updateDisplayView {
NSLog(@"update Display View");
    if (imageData) {
        float w = curentWidth;
        float h = curentHeight;
        NSSize newSize = NSMakeSize(w, h);
        float newScale = (w/2)+(h/2);
        [self.myView imageSize:newScale];
        [self.myView setFrameSize:newSize];
        [self.myView updateDisplay];
    }//end image data
}//end updateDusplayView

//handly delegat
#pragma mark popup functions
-(void)createPopup:(NSArray*)popupTitle{
  //  [profileSelectionOutlet removeAllItems];
    [profileSelectionOutlet addItemsWithTitles:popupTitle];
}

#pragma mark Change PopUp title
- (IBAction)profileSelectionAction:(id)sender {
    profileClass *pc = [[profileClass alloc]init];
    NSArray *ary = [[NSArray alloc] initWithArray:[pc getAlliSize]];
    int aryIndex = [[sender objectValue] intValue]-1;//import -1
    
    float imageScale = [[ary objectAtIndex:aryIndex] floatValue];
    [self.myView imageSize:imageScale];
    //errror
 //   NSLog(@"profileSelectionAction:%@ root data:%@",popTitle,[ourData myData]);x
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

@end
