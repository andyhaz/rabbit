//
//  profileClass.h
//  Rabbit
//
//  Created by andrew hazlett on 3/21/20.
//  Copyright © 2020 andrew hazlett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface profileClass : NSObject

-(NSArray*)getAlliSize;
-(NSArray*)deviceInfo;
-(NSArray*)listSizeData;

typedef struct screenSize {
    float width;
    float height;
} screenSize;

@end
