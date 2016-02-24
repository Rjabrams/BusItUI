//
//  BusScheduleViewController.m
//  BusIt
//
//  Created by Raquel Abrams on 2/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "BusScheduleViewController.h"
#import "SWRevealViewController.h"

@implementation BusScheduleViewController

@synthesize img1, img2, img3, img4, imageArea, imageArea2, button1, button2;



-(IBAction)Button1{
    imageArea.image = img1;
    imageArea2.image = img3;
    if(button2.highlighted == YES){
        [button2 setHighlighted:NO];
    } else {
        [button2 setHighlighted:YES];
    }
}


-(IBAction)Button2{
    imageArea.image = img2;
    imageArea2.image = img4;
    if(button1.highlighted == YES){
        [button1 setHighlighted:NO];
    } else {
        [button1 setHighlighted:YES];
    }
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


-(void)viewDidLoad{
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuButton setTarget: self.revealViewController];
        [self.menuButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    img1 = [UIImage imageNamed:@"practice1.png"];
    img2 = [UIImage imageNamed:@"UC_weekday2.png"];
    img3 = [UIImage imageNamed:@"UC_weekday2.png"];
    img4 = [UIImage imageNamed:@"loop4.png"];
    [super viewDidLoad];
       

    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(376, 550)];
    
}


//- (void)dealloc{
    
 //   [img1 release];
//    [img2 release];
 //   [imageArea release];
    
//    [super dealloc];
    
//}

@end
