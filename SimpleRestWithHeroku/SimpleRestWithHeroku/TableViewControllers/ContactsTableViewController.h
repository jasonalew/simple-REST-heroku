//
//  ContactsTableViewController.h
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsHTTPClient.h"

@interface ContactsTableViewController : UITableViewController <ContactsHTTPClientDelegate>

@end
