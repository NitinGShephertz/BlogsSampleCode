//
//  ViewController.h
//  SafariServicesframeworkSample
//
//  Created by Nitin Gupta on 30/01/14.
//  Copyright (c) 2014 Shephertz Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@interface ViewController : UIViewController <UITextFieldDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UILabel *invalidLabel;

- (IBAction)addUrlToReadingList:(id)sender;
- (IBAction)launchSaffariAction:(id)sender;

@end
