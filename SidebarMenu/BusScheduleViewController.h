//
//  BusScheduleViewController.h
//  BusIt
//
//  Created by Raquel Abrams on 2/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusScheduleViewController : UIViewController{
    
    IBOutlet UIScrollView *scroller;
    
    UIButton *button1; //
    UIButton *button2; //
   
    IBOutlet UIImage *img1;
    IBOutlet UIImage *img2;
    IBOutlet UIImage *img3;
    IBOutlet UIImage *img4;
    IBOutlet UIImageView *imageArea;
    IBOutlet UIImageView *imageArea2;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (nonatomic, retain) UIImage *img1;
@property (nonatomic, retain) UIImage *img2;
@property (nonatomic, retain) UIImage *img3;
@property (nonatomic, retain) UIImage *img4;
@property (nonatomic, retain) UIImageView *imageArea;
@property (nonatomic, retain) UIImageView *imageArea2;

@property (nonatomic,retain) IBOutlet UIButton *button1;
@property (nonatomic,retain) IBOutlet UIButton *button2;



-(IBAction)Button1:(id)sender;  // id sender
-(IBAction)Button2:(id)sender;

-(void)highlightButton: (UIButton *) button;



@end
