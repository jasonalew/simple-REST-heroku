//
//  EditContactViewController.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/8/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"
#import "ContactsHTTPClient.h"
#import "Constants.h"

@interface EditContactViewController ()<UITextFieldDelegate, ContactsHTTPClientDelegate>
@property (nonatomic) BOOL editContact;
@property (strong, nonatomic) ContactsHTTPClient *contactsClient;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    // If there is a contact then we are editing, if not we are adding.
    if (self.contact) {
        self.title = @"Edit Contact";
        self.editContact = YES;
        [self loadData];
    } else {
        self.editContact = NO;
        self.title = @"Add Contact";
    }
    
    self.contactsClient = [ContactsHTTPClient sharedContactsHTTPClient];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    self.firstNameTextField.text = self.contact.firstName;
    self.lastNameTextField.text = self.contact.lastName;
    self.emailTextField.text = self.contact.email;
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    // Check that all the fields have values before trying to save.
    if (self.firstNameTextField.text.length > 0 &&
        self.lastNameTextField.text.length > 0 &&
        self.emailTextField.text.length > 0) {
        
        self.contactsClient.delegate = self;
        NSDictionary *dict = @{
                               @"firstName": self.firstNameTextField.text,
                               @"lastName": self.lastNameTextField.text,
                               @"email": self.emailTextField.text,
                               @"_id": self.contact._id
                               };
        if (self.editContact) {
            [self.contactsClient editContact:dict];
        } else {
            [self.contactsClient addContact:dict];
        }
    } else {
        // TODO: Provide user feedback for missing field info
    }
}

- (void)contactsHTTPClientDidUpdateContact:(ContactsHTTPClient *)client {
    NSLog(@"Updated contact");
    // Let the root VC know that the table needs to be reloaded.
    // TODO: Keep track of the indexPath and only reload that cell.
    [[NSNotificationCenter defaultCenter]postNotificationName:updatedContactNotification
                                                       object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
