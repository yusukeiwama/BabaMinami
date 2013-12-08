//
//  YIViewController.m
//  BabaMinami
//
//  Created by Yusuke Iwama on 12/9/13.
//  Copyright (c) 2013 Yusuke Iwama. All rights reserved.
//

#import "YIViewController.h"

typedef enum BaMiNability {
	BaMiNabilityFLAT = 0,
	BaMiNabilityNATURAL = 1
	} BaMiNability;

@interface YIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)callButtonAction:(id)sender;

@end

@implementation YIViewController {
	NSMutableAttributedString *resultString;
	BaMiNability rule;
	int numberOfBananas;
	int babaminamiLocation;
}

@synthesize resultLabel;
@synthesize callButton;
@synthesize scoreLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	srand((unsigned)time(NULL));
	resultString = [[NSMutableAttributedString alloc] initWithString:@""];
	rule = BaMiNabilityFLAT;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callButtonAction:(id)sender {
	resultString = [[NSMutableAttributedString alloc] initWithString:@""];
	numberOfBananas = 0;
	babaminamiLocation = NSNotFound;
	int r;
	
	switch (rule) {
		case BaMiNabilityFLAT:
			while (1) {
				r = (int)(3.0 * rand() / (RAND_MAX + 1.0));
				switch (r) {
					case 0:
						[resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"ば"]];
						break;
					case 1:
						[resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"み"]];
						break;
					case 2:
						[resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"な"]];
						break;
					default:
						break;
				}
				[self bananaCheckWithString:resultString.string];
				if ([self babaminamiCheckWithString:resultString.string]) {
					resultLabel.attributedText = resultString;
					scoreLabel.text = [NSString stringWithFormat:@"ばばみなみは%d文字目から始まっています。ばななが%d本見つかりました。", babaminamiLocation, numberOfBananas];
					break;
				}
			}
			break;
		case BaMiNabilityNATURAL:
			while (1) {
				r = (int)(5.0 * rand() / (RAND_MAX + 1.0));
				switch (r) {
					case 0:
					case 1:
						[resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"ば"]];
						break;
					case 2:
					case 3:
						[resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"み"]];
						break;
					case 4:
						[resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"な"]];
						break;
					default:
						break;
				}
				[self bananaCheckWithString:resultString.string];
				if ([self babaminamiCheckWithString:resultString.string]) {
					resultLabel.attributedText = resultString;
					scoreLabel.text = [NSString stringWithFormat:@"ばばみなみは%d文字目から始まっています。ばななが%d本見つかりました。", babaminamiLocation, numberOfBananas];
					break;
				}
			}
			break;
		default:
			break;
	}
	if ([resultString.string isEqualToString:@"みなばばみなみ"]) {
		scoreLabel.text = [NSString stringWithFormat:@"みんなばばみなみです。"];
	} else if ([resultString.string isEqualToString:@"ばばみなみ"]) {
		scoreLabel.text = [NSString stringWithFormat:@"完全にばばみなみです。"];
		callButton.userInteractionEnabled = NO;
	}
}

- (BOOL)bananaCheckWithString:(NSString *)string
{
	if (string.length >= 3
		&& [[string substringFromIndex:string.length - 3] isEqualToString:@"ばなな"]) {
		[resultString addAttribute:NSForegroundColorAttributeName
							 value:[UIColor yellowColor]
							 range:NSMakeRange(string.length - 3, 3)];
		numberOfBananas++;
		return YES;
	}
	return NO;
}

- (BOOL)babaminamiCheckWithString:(NSString *)string
{
	if (string.length >= 5
		&& [[string substringFromIndex:string.length - 5] isEqualToString:@"ばばみなみ"]) {
		[resultString addAttribute:NSForegroundColorAttributeName
							 value:[UIColor redColor]
							 range:NSMakeRange(string.length - 5, 5)];
		babaminamiLocation = string.length - 5 + 1; // 1-origin
		return YES;
	}
	return NO;
}

@end
