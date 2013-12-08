//
//  YIViewController.m
//  BabaMinami
//
//  Created by Yusuke Iwama on 12/9/13.
//  Copyright (c) 2013 Yusuke Iwama. All rights reserved.
//

#import "YIViewController.h"

@interface YIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
- (IBAction)callButtonAction:(id)sender;

@end

@implementation YIViewController {
	NSMutableString *resultString;
}

@synthesize resultLabel;
@synthesize callButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	srand((unsigned)time(NULL));
	resultString = [NSMutableString string];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callButtonAction:(id)sender {
	resultString = [NSMutableString string];
	int r;
	NSRange babaminamiRange, lastBananaRange;
	
	while (1) {
		r = (int)(3.0 * rand() / (RAND_MAX + 1.0));
		switch (r) {
			case 0:
				[resultString appendString:@"ば"];
				break;
			case 1:
				[resultString appendString:@"み"];
				break;
			case 2:
				[resultString appendString:@"な"];
				break;
			default:
				break;
		}
		babaminamiRange = [resultString rangeOfString:@"ばばみなみ"];
//		lastBananaRange = [resultString rangeOfString:@"ばなな"
//											  options:NSCaseInsensitiveSearch
//												range:NSMakeRange(0,0)];
		if (babaminamiRange.location != NSNotFound) {
			NSMutableAttributedString *attributedResultString = [[NSMutableAttributedString alloc] initWithString:resultString];
			
			[attributedResultString addAttribute:NSForegroundColorAttributeName
										   value:[UIColor redColor]
										   range:babaminamiRange];
			resultLabel.attributedText = attributedResultString;
			break;
		}
	}
}

@end
