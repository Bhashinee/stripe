// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/auth;

public type Stripe object {
    private http:Client stripe;
    private Charges charges;
    private Customers customers;
    private Invoices invoices;
    private Products products;
    private Plans plans;
    private Subscriptions subscriptions;

    public function __init(string token) {
        auth:OutboundBasicAuthProvider outboundBasicAuthProvider = new ({
            username: token,
            password: ":"
        });
        http:BasicAuthHandler outboundBasicAuthHandler = new (outboundBasicAuthProvider);
        http:ClientConfiguration clientConfig = {
            auth: {
                authHandler: outboundBasicAuthHandler
            }
        }; 
        self.stripe = new(BASE_URL, config = clientConfig);
        self.charges = new(self.stripe);
        self.customers = new(self.stripe);
        self.invoices = new(self.stripe);
        self.products = new(self.stripe);
        self.subscriptions = new(self.stripe);
        self.plans = new(self.stripe);
    } 

    # The `Stripe.customers()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public function customers() returns Customers {
        return self.customers;
    }

    # The `Stripe.products()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public function products() returns Products {
        return self.products;
    }

    # The `Stripe.charges()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public function charges() returns Charges {
        return self.charges;
    }

    # The `Stripe.subscriptions()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public function subscriptions() returns Subscriptions {
        return self.subscriptions;
    }

    # The `Stripe.plans()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public function plans() returns Plans {
        return self.plans;
    }

    # The `Stripe.plans()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public function invoices() returns Invoices {
        return self.invoices;
    }
}; 