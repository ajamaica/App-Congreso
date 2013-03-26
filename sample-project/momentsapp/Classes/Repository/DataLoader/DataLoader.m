//
//  DataLoader.m
//  momentsapp
//
//  Created by M.A.D on 3/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "DataLoader.h"

@implementation DataLoader

+ (NSArray*)loadPhotos{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [tempArray addObject:@"1st_image"];
    [tempArray addObject:@"2nd_image"];
    [tempArray addObject:@"3rd_image"];
    [tempArray addObject:@"4th_image"];
    
    [tempArray addObject:@"1st_image"];
    [tempArray addObject:@"2nd_image"];
    [tempArray addObject:@"3rd_image"];
    [tempArray addObject:@"4th_image"];
    
    [tempArray addObject:@"1st_image"];
    [tempArray addObject:@"2nd_image"];
    [tempArray addObject:@"3rd_image"];
    [tempArray addObject:@"4th_image"];
    
    [tempArray addObject:@"1st_image"];
    [tempArray addObject:@"2nd_image"];
    [tempArray addObject:@"3rd_image"];
    [tempArray addObject:@"4th_image"];
    
    [tempArray addObject:@"1st_image"];
    [tempArray addObject:@"2nd_image"];
    [tempArray addObject:@"3rd_image"];
    [tempArray addObject:@"4th_image"];
    
    [tempArray addObject:@"1st_image"];
    [tempArray addObject:@"2nd_image"];
    [tempArray addObject:@"3rd_image"];
    [tempArray addObject:@"4th_image"];
    
    return [NSArray arrayWithArray:tempArray];
}

+ (NSArray*)loadMoments{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [tempArray addObject:@{@"title": @"New Year Anniversary 2012",
                          @"icon": @"timeline-icon1", 
                          @"date": @"THURSDAY 28 May", 
                          @"body": @"view1"}];
    [tempArray addObject:@{@"title": @"Meeting the Alpes",
                          @"icon": @"timeline-icon2", 
                          @"date": @"FRIDAY 9 March", 
                          @"body": @"view2"}];
    return [NSArray arrayWithArray:tempArray];
}

+ (NSArray*)loadComments{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [tempArray addObject:@{@"title": @"Manny Wead",
                          @"icon": @"6comment-photo", 
                          @"time": @"13 min ago", 
                          @"desc": @"And miss all that fun? no way! I think I will have to get a Bob"}];
    [tempArray addObject:@{@"title": @"Sarah Cox",
                          @"icon": @"7comment-photo", 
                          @"time": @"13 min ago", 
                          @"desc": @"Great party!. It was fun hanging out with you all! We should do"}];
    [tempArray addObject:@{@"title": @"Manny Wead",
                          @"icon": @"6comment-photo", 
                          @"time": @"13 min ago", 
                          @"desc": @"And miss all that fun? no way! I think I will have to get a Bob"}];
    [tempArray addObject:@{@"title": @"Sarah Cox",
                          @"icon": @"7comment-photo", 
                          @"time": @"13 min ago", 
                          @"desc": @"Great party!. It was fun hanging out with you all! We should do"}];
    [tempArray addObject:@{@"title": @"Manny Wead",
                          @"icon": @"6comment-photo", 
                          @"time": @"13 min ago", 
                          @"desc": @"And miss all that fun? no way! I think I will have to get a Bob"}];
    [tempArray addObject:@{@"title": @"Sarah Cox",
                          @"icon": @"7comment-photo", 
                          @"time": @"13 min ago", 
                          @"desc": @"Great party!. It was fun hanging out with you all! We should do"}];
    return [NSArray arrayWithArray:tempArray];
}

+ (NSArray*)loadThumbs{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    //[tempArray addObject:@"8scroll-selected"];
    [tempArray addObject:@{@"thumb": @"11scroll", 
                          @"img": @"big_Photo2.png"}];
    [tempArray addObject:@{@"thumb": @"12scroll", 
                          @"img": @"big_Photo1.png"}];
    
    [tempArray addObject:@{@"thumb": @"13scroll", 
                          @"img": @"big_Photo4.jpg"}];
    [tempArray addObject:@{@"thumb": @"14scroll", 
                          @"img": @"big_Photo3.jpg"}];
    
    [tempArray addObject:@{@"thumb": @"11scroll", 
                          @"img": @"big_Photo2.png"}];
    [tempArray addObject:@{@"thumb": @"12scroll", 
                          @"img": @"big_Photo1.png"}];
    
    [tempArray addObject:@{@"thumb": @"13scroll", 
                          @"img": @"big_Photo4.jpg"}];
    [tempArray addObject:@{@"thumb": @"14scroll", 
                          @"img": @"big_Photo3.jpg"}];
    
    [tempArray addObject:@{@"thumb": @"11scroll", 
                          @"img": @"big_Photo2.png"}];
    [tempArray addObject:@{@"thumb": @"12scroll", 
                          @"img": @"big_Photo1.png"}];
    
    [tempArray addObject:@{@"thumb": @"13scroll", 
                          @"img": @"big_Photo4.jpg"}];
    [tempArray addObject:@{@"thumb": @"14scroll", 
                          @"img": @"big_Photo3.jpg"}];
    
    return [NSArray arrayWithArray:tempArray];
}
@end
