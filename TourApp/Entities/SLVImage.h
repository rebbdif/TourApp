//
//  SLVImage.h
//  TourApp
//
//  Created by Леонид Серебряный on 16/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@import UIKit;

@interface SLVImage : NSManagedObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong, readonly) UIImage *imageToShow;

@end
