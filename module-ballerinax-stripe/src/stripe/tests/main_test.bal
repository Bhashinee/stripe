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

import ballerina/test;

Stripe stripeClient = new ("sk_test_ba14gpQ4JMNy5sEAvmazyLAk00t0h5M9hl");
Customers customers = stripeClient.customers();
Products products = stripeClient.products();
Plans plans = stripeClient.plans();
Subscriptions subscriptions = stripeClient.subscriptions();
Charges charges = stripeClient.charges();
Invoices invoices = stripeClient.invoices();
string customerId = "";
string productId = "";
string planId = "";

Customer customerParams = {
    description: "First customer",
    email: "b7astripe@gmail.com",
    shipping: {
        address: {
            city: "Colombo",
            country: "Sri Lanka",
            line1: "345/5",
            postal_code: "10230",
            state: "Western",
            line2: "Palm Grove"
        },
        name: "b7a"
    },
    address: {
        city: "city1",
        line1: "234/5",
        line2: "Palm Grove",
        country: "Sri Lanka",
        postal_code: "1004",
        state: "Western"
    },
    name: "ballerina",
    next_invoice_sequence: 10,
    tax_exempt: "none"
};

Customer customerUpdateParams = {
    description: "Updated description"
};

Card card = {
    'object: "card",
    number: "4242424242424242",
    exp_month: "12",
    exp_year: "2021",
    cvc: "123",
    name: "Bhashinee",
    address_line1: "345/1",
    address_line2: "Palm Grove",
    address_city: "Colombo",
    address_state: "Western",
    address_zip: "10234",
    address_country: "Sri Lanka"
};

// @test:Config {}
function testCustomerFunctions() {
    Customer|Error? createdCustomer = customers->create(customerParams);
    if (createdCustomer is Error) {
        test:assertFail(msg = <string>createdCustomer.detail()?.message);
    } else {
        anydata result = createdCustomer["id"];
        if (result is string) {
            customerId = <@untainted> result;
        }
    }

    Customer|Error? retrievedCustomer = customers->retrieve(customerId);
    if (retrievedCustomer is Error) {
        test:assertFail(msg = <string>retrievedCustomer.detail()?.message);
    } else {
        if (retrievedCustomer is Customer) {
            string? email = retrievedCustomer["email"];
            if (email is string) {
                test:assertEquals(email, "b7astripe@gmail.com");
            }
        }
    }

    Customer|Error? updatedCustomer = customers->update(customerId, customerUpdateParams);
    if (updatedCustomer is Error) {
        test:assertFail(msg = <string>updatedCustomer.detail()?.message);
    } else {
        string? description = updatedCustomer["description"];
        if (description is string) {
           test:assertEquals(description, "Updated description");
        }
    }

    Customer[]|Error? listCustomers = customers->list();
    if (listCustomers is Error) {
        test:assertFail(msg = <string>listCustomers.detail()?.message);
    }

    Error? deletecustomer = customers->delete(customerId);
    if (deletecustomer is Error) {
        test:assertFail(msg = <string>deletecustomer.detail()?.message);
    }

    // Card|Error createCard = customers->createCard("cus_HHWIJPAUfcXYNH", card);
    // if (createCard is Error) {
    //     test:assertFail(msg = <string>createCard.detail()?.message);
    // } else {
    //     anydata brand = createCard["brand"];
    //     if (brand is string) {
    //         test:assertEquals(brand, "Visa");
    //     }
    // }
}

Product product = {
	active: true,
	attributes: ["size", "colour"],
	caption: "thisisthecaption",
	description: "Describing the product",
	images: ["https://media.gettyimages.com/photos/red-cup-picture-id171368204?s=612x612", "https://i.ytimg.com/vi/3lX0tg7CEJw/maxresdefault.jpg"],
	name: "Blue Cup",
	package_dimensions: {
        height : 3.2,
        weight: 9.8,
        length: 8.7,
        width: 2.3
    },
	shippable: true,
	'type: "good",
	url: "https://medium.com/@bhashineen/ballerina-soap-connector-3974b6efaf2b"
};

Product updateProduct = {
	description: "Updated description"
};

// @test:Config {}
function testProductFunctions() {
    Product|Error? createdProduct = products->create(product);
    if (createdProduct is Error) {
        test:assertFail(msg = <string>createdProduct.detail()?.message);
    } else {
        anydata result = createdProduct["id"];
        if (result is string) {
            productId = <@untainted> result;
        }
    }

    Product|Error? retrievedProduct = products->retrieve(productId);
    if (retrievedProduct is Error) {
        test:assertFail(msg = <string>retrievedProduct.detail()?.message);
    } else {
        if (retrievedProduct is Product) {
            string? caption = retrievedProduct["caption"];
            if (caption is string) {
                test:assertEquals(caption, "thisisthecaption");
            }
        }
    }

    Product|Error? updatedProduct = products->update(productId, updateProduct);
    if (updatedProduct is Error) {
        test:assertFail(msg = <string>updatedProduct.detail()?.message);
    } else {
        string? description = updatedProduct["description"];
        if (description is string) {
           test:assertEquals(description, "Updated description");
        }
    }

    Product[]|Error? listProducts = products->list();
    if (listProducts is Error) {
        test:assertFail(msg = <string>listProducts.detail()?.message);
    }

    Error? deleteProduct = products->delete(productId);
    if (deleteProduct is Error) {
        test:assertFail(msg = <string>deleteProduct.detail()?.message);
    }
}

Plan plan = {
    currency: "usd",
    interval: "month",
    product: {
        name: "Red purse",
        active: true,
        statement_descriptor: "statementDescriptor",
        unit_label: "unitlabel"
    },
    active: true,
    nickname: "RedPursePlan",
    aggregate_usage: "last_ever",
    billing_scheme: "tiered",
    id: "PlanId2",
    tiers: [{
        flat_amount_decimal: 3.0,
        unit_amount: 5,
        up_to: "inf"
    }],
    tiers_mode: "volume",
    interval_count: 10,
    trial_period_days: 40,
    usage_type: "metered"
};

Plan updatePlan = {
    nickname: "RedPursePlan1"
};

// @test:Config {}
function testPlanFunctions() {
    Plan|Error? createdPlan = plans->create(plan);
    if (createdPlan is Error) {
        test:assertFail(msg = <string>createdPlan.detail()?.message);
    } else {
        anydata result = createdPlan["id"];
        if (result is string) {
            planId = <@untainted> result;
        }
        anydata productResult = createdPlan["product"];
        if (productResult is string) {
            productId = <@untainted> productResult;
        }
    }

    Plan|Error? retrievedPlan = plans->retrieve(planId);
    if (retrievedPlan is Error) {
        test:assertFail(msg = <string>retrievedPlan.detail()?.message);
    } else {
        if (retrievedPlan is Plan) {
            string? billingScheme = retrievedPlan["billing_scheme"];
            if (billingScheme is string) {
                test:assertEquals(billingScheme, "tiered");
            }
        }
    }

    Plan|Error? updatedPlan = plans->update(planId, updatePlan);
    if (updatedPlan is Error) {
        test:assertFail(msg = <string>updatedPlan.detail()?.message);
    } else {
        string? nickName = updatedPlan["nickname"];
        if (nickName is string) {
           test:assertEquals(nickName, "RedPursePlan1");
        }
    }

    Plan[]|Error? listPlans = plans->list();
    if (listPlans is Error) {
        test:assertFail(msg = <string>listPlans.detail()?.message);
    }

    Error? deletePlan = plans->delete(planId);
    if (deletePlan is Error) {
        test:assertFail(msg = <string>deletePlan.detail()?.message);
    }

    Error? deleteProduct = products->delete(productId);
    if (deleteProduct is Error) {
        test:assertFail(msg = <string>deleteProduct.detail()?.message);
    }
}

Subscription subs = {
    customer: "cus_HHWIJPAUfcXYNH",
    cancel_at_period_end: false,
    billing_thresholds: {
        amount_gte: 100,
        reset_billing_cycle_anchor: false
    },
    subscription_items: [{
        plan: "TutePlan"
    }],
    collection_method: "send_invoice",
    days_until_due: 30,
    off_session: false,
    pending_invoice_item_interval: {
        interval: "year",
        interval_count: 1
    },
    proration_behavior: "always_invoice",
    tax_percent: 4.0,
    trial_from_plan: false,
    trial_period_days: 30
};

Subscription updateSubs = {
    cancel_at_period_end: false,
    billing_thresholds: {
        amount_gte: 100,
        reset_billing_cycle_anchor: false
    },
    collection_method: "send_invoice",
    days_until_due: 30,
    off_session: false,
    pending_invoice_item_interval: {
        interval: "year",
        interval_count: 1
    },
    proration_behavior: "always_invoice",
    tax_percent: 4.0,
    trial_from_plan: false
};

// @test:Config {}
function testSubscriptionFunctions() {
    // Subscription|Error? createdSubscription = subscriptions->create(subs);
    // if (createdSubscription is Error) {
    //     test:assertFail(msg = <string>createdSubscription.detail()?.message);
    // } else {
    //     anydata result = createdSubscription["id"];
    //     if (result is string) {
    //         productId = <@untainted> result;
    //     }
    // }

    Subscription|Error? retrievedSubscription = subscriptions->retrieve("sub_HHWxOzSGhAnDfZ");
    if (retrievedSubscription is Error) {
        test:assertFail(msg = <string>retrievedSubscription.detail()?.message);
    } else {
        if (retrievedSubscription is Subscription) {
            string? method = retrievedSubscription["collection_method"];
            if (method is string) {
                test:assertEquals(method, "send_invoice");
            }
        }
    }

    Subscription[]|Error? listSubscriptions = subscriptions->list();
    if (listSubscriptions is Error) {
        test:assertFail(msg = <string>listSubscriptions.detail()?.message);
    }

    Subscription|Error? updatedSubscription = subscriptions->update("sub_HHWxOzSGhAnDfZ", updateSubs);
    if (updatedSubscription is Error) {
        test:assertFail(msg = <string>updatedSubscription.detail()?.message);
    } else {
        string? method = updatedSubscription["collection_method"];
        if (method is string) {
           test:assertEquals(method, "send_invoice");
        }
    } 
}

Charge charge = {
    amount: 2000,
    currency: "usd",
    customer: "cus_HHWIJPAUfcXYNH",
    description: "Charge for customer",
    receipt_email: "bhashi@gmail.com",
    shipping: {
        address: {
            city: "colombo",
            country: "Sri Lanka",
            line1: "456/2",
            line2: "Palm Grove",
            postal_code: "1004",
            state: "western"
        },
        carrier: "fedex",
        name: "customer",
        phone: "09234323",
        tracking_number: "3456"
    },
    sourceId: "card_1GjymEJ7y0eOXqiMOr7j1Psz",
    statement_descriptor: "descriptor",
    statement_descriptor_suffix: "cd",
    transfer_group: "group1"
};

// @test:Config {}
function testChargeFunctions() {
    // Charge|Error? createdCharge = charges->create(charge);
    // if (createdCharge is Error) {
    //     test:assertFail(msg = <string>createdCharge.detail()?.message);
    // } else {
    //     anydata result = createdCharge["id"];
    //     if (result is string) {
    //         io:println(result);
    //     }
    // }

    Charge|Error? retrievedCharge= charges->retrieve("ch_1Gjz58J7y0eOXqiMuskxrhFa");
    if (retrievedCharge is Error) {
        test:assertFail(msg = <string>retrievedCharge.detail()?.message);
    } else {
        if (retrievedCharge is Charge) {
            string? customer = retrievedCharge["customer"];
            if (customer is string) {
                test:assertEquals(customer, "cus_HHWIJPAUfcXYNH");
            }
        }
    }

    Charge[]|Error? listCharges = charges->list();
    if (listCharges is Error) {
        test:assertFail(msg = <string>listCharges.detail()?.message);
    }
}
    Invoice invo = {
        customer: "cus_HHWIJPAUfcXYNH"
    };

    Invoice updateInvo = {
        description: "update description"
    };

    InvoiceItem invoiceItem = {
        customer : "cus_HHWIJPAUfcXYNH", 
        currency: "usd",
        description: "description",
        discountable: true,
        price_data: {
            currency: "usd",
            product: "prod_HHWNWWsSZ91sDy",
            unit_amount: 2
        },
        period: {
            end: 1587443917,
            'start: 1587443917
        },
        quantity: 10
    };

@test:Config {}
function testInvoiceFunctions() {
    // InvoiceItem|Error? createdInvoice = invoices->createInvoiceItem(invoiceItem);
    // if (createdInvoice is Error) {
    //     test:assertFail(msg = <string>createdInvoice.detail()?.message);
    // } else {
    //     anydata result = createdInvoice["id"];
    //     if (result is string) {
    //         io:println(result);
    //     }
    // }

    // Invoice|Error? createdInvoice = invoices->create(invo);
    // if (createdInvoice is Error) {
    //     test:assertFail(msg = <string>createdInvoice.detail()?.message);
    // } else {
    //     anydata result = createdInvoice["id"];
    //     if (result is string) {
    //         io:println(result);
    //     }
    // }

    Invoice|Error? retrievedInvoice= invoices->retrieve("in_1GkAJKJ7y0eOXqiMsWkHIA4m");
    if (retrievedInvoice is Error) {
        test:assertFail(msg = <string>retrievedInvoice.detail()?.message);
    } else {
        if (retrievedInvoice is Invoice) {
            string? customerId = retrievedInvoice["customer"];
            if (customerId is string) {
                test:assertEquals(customerId, "cus_HHWIJPAUfcXYNH");
            }
        }
    }

    Invoice|Error? updatedInvoice= invoices->update("in_1GkAJKJ7y0eOXqiMsWkHIA4m", updateInvo);
    if (updatedInvoice is Error) {
        test:assertFail(msg = <string>updatedInvoice.detail()?.message);
    } else {
        if (updatedInvoice is Invoice) {
            string? description = updatedInvoice["description"];
            if (description is string) {
                test:assertEquals(description, "update description");
            }
        }
    }

    // Charge[]|Error? listCharges = charges->list();
    // if (listCharges is Error) {
    //     test:assertFail(msg = <string>listCharges.detail()?.message);
    // }
}



