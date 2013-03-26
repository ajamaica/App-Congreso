//
//  HomeiPadViewController.m
//  momentsapp
//
//  Created by M.A.D on 3/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "HomeiPadViewController.h"

#import "CommentCell.h"

#import "DataLoader.h"

@interface HomeiPadViewController ()

@end

@implementation HomeiPadViewController

@synthesize comments;
@synthesize thumbs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)handleThumbClick:(id)sender{
    UIButton *btn = (UIButton*)sender;
    
    for (UIButton *btn in scrollView.subviews) {
        [[btn viewWithTag:99] removeFromSuperview];
        
    }
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button_frame"]];
    imgView.frame = CGRectMake(3, 3, 123 , 123);
    imgView.tag = 99;
    [btn addSubview:imgView];
    
    NSDictionary *thumb = thumbs[btn.tag];
    bigPhoto.image = [UIImage imageNamed:thumb[@"img"]];
}

- (void)fillScrollView{
    
    for (int i=0; i< thumbs.count; i++) {
        NSDictionary *thumb = thumbs[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10 + (i*130), 20, 129, 129)];
        [btn setImage:[UIImage imageNamed:thumb[@"thumb"]] forState:UIControlStateNormal];
        [btn addTarget:self 
                action:@selector(handleThumbClick:)
      forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        if (i ==0) {
            UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button_frame"]];
            imgView.frame = CGRectMake(3, 3, 123 , 123);
            imgView.tag = 99;
            [btn addSubview:imgView];
        }
        
        [scrollView addSubview:btn];
    }
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(20 + (thumbs.count * 130), 130);
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    
    self.title = @"Friends";
    
    self.comments = [DataLoader loadComments];
    self.thumbs = [DataLoader loadThumbs];
    
    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scroll-background"]];
    
    [self fillScrollView];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications ];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(orientationChanged:) 
                                                name:@"UIDeviceOrientationDidChangeNotification"
                                              object:nil ];
}

- (void)orientationChanged:(NSNotification *)object{
    UIDeviceOrientation deviceOrientation=[[object object]orientation ];
    if (UIInterfaceOrientationIsPortrait(deviceOrientation)) {
        commentsView.hidden = YES;
        bigPhotoFrame.frame = CGRectMake(72 + 10, 72 + 58, 620, 486);
    }else {
        commentsView.hidden = NO;
        bigPhotoFrame.frame = CGRectMake(10, 58, 620, 486);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;// UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if (UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)) {
        
    } 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [comments count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CommentCell";
    CommentCell *cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ){
        NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        for (id obj in topObjects) {
            if ([obj isKindOfClass:[CommentCell class]]){
                cell = (CommentCell*)obj;
                break;
            }
        }
    }
    // Configure the cell...
    NSDictionary *comment = comments[indexPath.row];
    
    cell.titleLabel.text = comment[@"title"];
    cell.imageView.image = [UIImage imageNamed:comment[@"icon"]];
    cell.timeLabel.text = comment[@"time"];
    cell.descLabel.text = comment[@"desc"];
    
    
    return cell;
}

@end
