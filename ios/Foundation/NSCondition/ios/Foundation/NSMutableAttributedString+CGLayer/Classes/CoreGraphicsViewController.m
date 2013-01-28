//
//  CoreGraphicsViewController.m
//  CoreGraphics
//
//  Created by 大森 智史 on 10/11/23.
//  Copyright 2010 Satoshi Oomori. All rights reserved.
//

#import "CoreGraphicsViewController.h"


@implementation CoreGraphicsViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
	//self.slidersTableView.backgroundColor = [UIColor clearColor];

	self.view.autoresizesSubviews = YES;
	self.view.userInteractionEnabled = YES;

}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {



}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
