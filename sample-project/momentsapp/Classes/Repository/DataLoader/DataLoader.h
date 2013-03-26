//
//  DataLoader.h
//  momentsapp
//
//  Created by M.A.D on 3/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoader : NSObject

+ (NSArray*)loadPhotos;

+ (NSArray*)loadMoments;

+ (NSArray*)loadComments;

+ (NSArray*)loadThumbs;

@end
