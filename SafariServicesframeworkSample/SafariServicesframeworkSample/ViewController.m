//
//  ViewController.m
//  SafariServicesframeworkSample
//
//  Created by Nitin Gupta on 30/01/14.
//  Copyright (c) 2014 Shephertz Technologies. All rights reserved.
//

#import "ViewController.h"

// Runtime check for the current version Nummer.
#define SYSTEM_VERSION_MORE_EQUAL_THAN(_gVersion)                 ( floor(NSFoundationVersionNumber) >=  _gVersion )

@interface ViewController ()
- (void) tap:(UIGestureRecognizer *)recognizer ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
     tap.numberOfTapsRequired = 1;
     [[self view] addGestureRecognizer:tap];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture Method
- (void) tap:(UIGestureRecognizer *)recognizer {
    
    /*! Resigning All Responder Here For End Editing*/
    [_urlTextField resignFirstResponder];
}

#pragma mark - IBAction Methods
- (IBAction)addUrlToReadingList:(id)sender {

    NSString *_aText = [_urlTextField text];
    if ([_aText length]) {
        if(SYSTEM_VERSION_MORE_EQUAL_THAN(7.0)) {
            NSRange range = [[_aText lowercaseString] rangeOfString:@"http"];
            BOOL _isInRange =  range.location != NSNotFound;
            _aText = _isInRange ? _aText : [NSString stringWithFormat:@"http:%@",_aText];

            SSReadingList * _aReadList = [SSReadingList defaultReadingList];
            NSError * _anError = nil;
            BOOL status =[_aReadList addReadingListItemWithURL:[NSURL URLWithString:_aText] title:@"" previewText:@"Any  Preivew" error:&_anError];
            
            if(status) {
                [_urlTextField resignFirstResponder];
                [_invalidLabel setText:@"Added URL Succesfully"];
                [_invalidLabel setTextColor:[UIColor blackColor]];
            }
            else {
                [_invalidLabel setText:@"Invalid URL, Please enter valid URL."];
                [_invalidLabel setTextColor:[UIColor redColor]];
              NSLog(@"Failed to add URL with error = %@",[_anError description]);
            }
        } else {
            [_invalidLabel setText:@"Looks like iOS version is less than 7.0, Can't be support for Safari Reading List"];
            [_invalidLabel setTextColor:[UIColor redColor]];
        }
    } else {
        [_invalidLabel setText:@"Invalid URL, Please enter valid URL."];
        [_invalidLabel setTextColor:[UIColor redColor]];
    }
}

- (IBAction)launchSaffariAction:(id)sender {
    
    [_urlTextField resignFirstResponder];

    NSString *url = @"http://www.shephertz.co.in";
    
    BOOL _result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    if (!_result) {
        NSLog(@"Failed to open URL: %@ and Description:%@",url,[url description]);
    }
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [_invalidLabel setText:@""];
}


@end
