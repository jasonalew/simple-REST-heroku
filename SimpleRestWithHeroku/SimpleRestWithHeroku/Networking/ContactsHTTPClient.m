//
//  ContactsHTTPClient.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/8/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "ContactsHTTPClient.h"

static NSString *const ContactsBaseURL = @"contactsBaseURL";

@interface ContactsHTTPClient()

@end

@implementation ContactsHTTPClient

+ (ContactsHTTPClient *)sharedContactsHTTPClient {
    static ContactsHTTPClient *_sharedContactsHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle]pathForResource:@"URLAddresses" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString *baseURLString = dict[ContactsBaseURL];
        
        _sharedContactsHTTPClient = [[self alloc]initWithBaseURL:[NSURL URLWithString:baseURLString]];

    });
    return _sharedContactsHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)getAllContacts {
    [self GET:@"/contacts" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Progress: %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GetAllContacts StatusCode: %d", [self statusCodeForTask:task]);
        if ([self.delegate respondsToSelector:@selector(contactsHTTPClient:didGetAllContacts:)]) {
            NSLog(@"Triggering delegate");
            [self.delegate contactsHTTPClient:self didGetAllContacts:responseObject];
        } else {
            NSLog(@"Doens't respond to selector");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Failed to get all contacts: %@,\nStatusCode: %d", error.localizedDescription, [self statusCodeForTask:task]);
    }];
}

- (void)addContact:(NSDictionary *)contactDict {
    [self POST:@"/contacts" parameters:contactDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Updated contact: %@\n%d", contactDict, [self statusCodeForTask:task]);
        if ([self.delegate respondsToSelector:@selector(contactsHTTPClientDidUpdateContact:)]) {
            [self.delegate contactsHTTPClientDidUpdateContact:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to update contact: %@\nStatusCode: %d", error.localizedDescription, [self statusCodeForTask:task]);
    }];
}

- (void)editContact:(NSDictionary *)contactDict {
    NSString *path = [NSString stringWithFormat:@"/contacts/%@", contactDict[@"_id"]];
    NSLog(@"PATH: %@", path);
    [self PUT:path parameters:contactDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"EditContact Code: %d", [self statusCodeForTask:task]);
        if ([self.delegate respondsToSelector:@selector(contactsHTTPClientDidUpdateContact:)]) {
            
            [self.delegate contactsHTTPClientDidUpdateContact:self];
        } else {
            
            NSLog(@"NOT");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to edit contact: %@, StatusCode: %d", error.localizedDescription, [self statusCodeForTask:task]);
    }];
}

- (int)statusCodeForTask:(NSURLSessionDataTask *)dataTask {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)dataTask.response;
    return (int)response.statusCode;
}

@end
