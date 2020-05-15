// import ballerina/io;

public function main() {
    Stripe stripeClient = new ("sk_test_IqrWNGzWZzCCgj7nqnvLsIMZ00jEjjb17S");

    Customer cus = {
        address: {
            city: "city1",
            line1: "234/5"
        },
        balance: 10,
        // coupon: "coupon",
        description: "test description",
        email: "abc@gmail.com",
        // invoice_prefix: "xxx",
        // invoice_settings: {
        //     name: "invoiceName",
        //     value: "invoiceValue"
        // },
        shipping: {
            address: {
                city: "city1",
                line1: "4523/5"
            },
            name: "mnncvcvc",
            phone: "0924343434"
        },
        name: "namezzzzzzzzzzz"
        // next_invoice_sequence: 3
        // payment_method?;
        // phone?;
        // preferred_locales?;
        // tax_exempt?;
        // tax_id_data?;
        // token?;
        // plan?;
        // quantity?;
        // taxPercent?;
        // trialEnd?;
    };
    // Customers customers = stripeClient.customers();
    // Customer|error? customer = customers->createCustomer(cus);
    // Customer|error? customer = customers->update("cus_HDoJ28vNJG6FHl", cus);
    // Customer|error? customer = customers->retrieveCustomer("cus_H8Uo6QgfNnWorJ");
    // Customer[]|error? customer = customers->listCustomers();
    // Error? customer = customers->deleteCustomer("cus_HDo3AqTRh1tPBy");
    // if (customer is Error) {
    //     io:println("Error occured", customer);
    // }
    // if (customer is Customer) {
    //     io:println(customer["id"]);
    // } else {
    //     io:println(customer);
    // }

    Product product = {
	active: true,
	attributes: ["size", "colour"],
	caption: "thisisthecaption",
	// deactivate_on:
	description: "Describing the product",
	// id:
	images: ["https://image.shutterstock.com/image-photo/ceramic-cup-isolated-on-white-260nw-1048628651.jpg"],
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

    Products products = stripeClient.products();
    // Error|Product prod = products->create(product);
    // if (prod is Product) {
    //     io:println(prod["id"]);
    // } else {
    //     io:println(prod);
    // }

    // Error|Product prod = products->update("prod_HE9e5z2H1o2KZb", product);
    // if (prod is Product) {
    //     io:println(prod);
    // } else {
    //     io:println(prod);
    // }

    // Error? prod = products->delete("prod_HECqxROfpa3FvB");
    // if (prod is Error) {
    //     io:println(prod);
    // }

    // Error|Product[] prod = products->list();
    // if (prod is Product[]) {
    //     io:println(prod);
    // } else {
    //     io:println(prod);
    // }

    Charges charges = stripeClient.charges();
    Charge charge = {
        amount: 2000,
        currency: "usd",
        customer: "cus_HGTJPFkQ1VRvDQ",
        description: "charge for xyz customer updated",
        receipt_email: "bhashi123@gmail.com"
        // capture: false
        // shipping: {
        //     address: {
        //         city: "city1",
        //         line1: "4523/5/883",
        //         line2: "Hiripitiya",
        //         country: "Sri lanka",
        //         postal_code: "12345",
        //         state: "Colombo"
        //     },
        //     name: "mnncvcvc",
        //     phone: "0924343434",
        //     carrier: "Fedex",
        //     tracking_number: "5434"
        // },
        // sourceId: "card_1GgiRzKTjsHGwZuGcThbgfpU",
        // statement_descriptor: "statement descriptor",
        // statement_descriptor_suffix: "EE",
        // on_behalf_of: "B customer",
        // transfer_data: {
        //     amount: 1000,
        //     destination: "Colombo"
        // },
        // transfer_group: "group1"
    };

    // Error|Charge charge1 = charges->create(charge); 
    // if (charge1 is Charge) {
    //     io:println(charge1);
    // } else {
    //     io:println(charge1);
    // }

    // Error|Charge charge1 = charges->retrieveCharge("ch_1Ggj4yKTjsHGwZuGnQinubh7"); 
    // if (charge1 is Charge) {
    //     io:println(charge1);
    // } else {
    //     io:println(charge1);
    // }

    // Error|Charge charge1 = charges->update("ch_1Ggj4yKTjsHGwZuGnQinubh7", charge); 
    // if (charge1 is Charge) {
    //     io:println(charge1);
    // } else {
    //     io:println(charge1);
    // }

    // Error|Charge[] charge1 = charges->list(); 
    // if (charge1 is Charge[]) {
    //     io:println(charge1);
    // } else {
    //     io:println(charge1);
    // }

    // Capture capture = {
    //     // amount: 1000,
    //     receipt_email: "bhashi@gmail.com",
    //     statement_descriptor: "This is statement",
    //     statement_descriptor_suffix: "SUF",
    //     // application_fee_amount: 200,
    //     // transfer_data: {
    //     //     amount: 1000,
    //     //     destination: "colombo"
    //     // },
    //     transfer_group: "Group123"
    // };

    // Error|Charge charge1 = charges->capture("ch_1GhUryKTjsHGwZuG0lbmTjf4", capture); 
    // if (charge1 is Charge) {
    //     io:println(charge1);
    // } else {
    //     io:println(charge1);
    // }

    Subscription subs = {
        customer: "cus_HDoJ28vNJG6FHl",
        cancel_at_period_end: false,
        default_payment_method: "mannual",
        // application_fee_percent: 2.0,
        // backdate_start_date: 3245,
        // billing_cycle_anchor: "unchanged",
        billing_thresholds: {
            // amount_gte: 100,
            reset_billing_cycle_anchor: false
        },
        subscription_items: [{
            subscription_plan: "plan_H8UvMC10youNdH",
            quantity: 1
        }],
        // cancel_at: 4567,
        collection_method: "send_invoice",
        days_until_due: 30,
        // default_source: "source",
        off_session: false,
        // payment_behavior: "pending_if_incomplete",
        pending_invoice_item_interval: {
            interval: "year",
            interval_count: 1
        },
        // prorate: false,
        // proration_behavior: "behavior",
        tax_percent: 4.0,
        // trial_end: 10,
        trial_from_plan: false,
        trial_period_days: 30
    };

    Subscriptions subscriptions = stripeClient.subscriptions();
    // Subscription|Error create = subscriptions->create(subs);
    // if (create is Error) {
    //     io:println(create);
    // } else {
    //     io:println(create);
    // }

    // Subscription|Error create = subscriptions->retrieve("sub_HG7xYsEYAbVjeG");
    // if (create is Error) {
    //     io:println(create);
    // } else {
    //     io:println(create);
    // }

    // Subscription|Error create = subscriptions->update("sub_HG7xYsEYAbVjeG", subs);
    // if (create is Error) {
    //     io:println(create);
    // } else {
    //     io:println(create);
    // }

//    Error|Subscription delete = subscriptions->cancel("sub_HGJMv872Av27eu");
//     if (delete is Error) {
//         io:println(delete);
//     } else {
//         io:println(delete);
//     }

//    Error|Subscription[] list = subscriptions->list();
//     if (list is Error) {
//         io:println(list);
//     } else {
//         io:println(list);
//     }

Plan plan = {
    // amount : 200,
    // currency: "usd",
    // interval: "month",
    // product: {
    //     name: "Red purse",
    //     active: true,
    //     statement_descriptor: "statementDescriptor",
    //     unit_label: "unitlabel"
    // },
    // product: "prod_HGN90ADckVPdlG",
    active: true,
    nickname: "BlueCupPlan1",
    // aggregate_usage: "last_ever",
    // amount_decimal: 4.0,
    // billing_scheme: "tiered",
    // id: "PlanId1",
    // tiers: [{
    //     // flat_amount: 3,
    //     flat_amount_decimal: 3.0,
    //     unit_amount: 5,
    //     // unit_amount_decimal: 5.0,
    //     up_to: "inf"
    // }],
    // tiers_mode: "volume",
    // interval_count: 10,
    // transform_usage: {
    //     divide_by: 2,
    //     round: "rounded"
    // },
    trial_period_days: 40
    // usage_type: "metered"
};

// PlanTierParams tier1 = {
//     flat_amount: 3,
//     flat_amount_decimal: 3.0,
//     unit_amount: 5,
//     unit_amount_decimal: 5.0,
//     up_to: "inf"
// };

    Plans plans = stripeClient.plans();
    // Plan|Error create = plans->create(plan);
    // if (create is Error) {
    //     io:println(create);
    // } else {
    //     io:println(create);
    // }

    // Plan|Error create = plans->retrieve("plan_H8UvMC10youNdH");
    // if (create is Error) {
    //     io:println(create);
    // } else {
    //     io:println(create);
    // }

    // Plan|Error create = plans->update("PlanId1", plan);
    // if (create is Error) {
    //     io:println(create);
    // } else {
    //     io:println(create);
    // }

    // Error? delete = plans->delete("PlanId1");
    // if (delete is Error) {
    //     io:println(delete);
    // }

    // Plan[]|Error planList = plans->list();
    // if (planList is Error) {
    //     io:println(planList);
    // } else {
    //     io:println(planList);
    // }

    Invoice invo = {
        // customer: "cus_HGTJPFkQ1VRvDQ",
        // auto_advance: false,
        // collection_method: "send_invoice",
        description: "Description Updated"
        // subscription: "sub_HG7uffX3MLXNh0",
        // application_fee_amount: 100,
        // custom_fields: {
        //     name: "custom name",
        //     value: "custom value"
        // },
        // days_until_due: 30,
        // default_payment_method: "defaultpayment",
        // default_source: "defaultSource",
        // default_tax_rates: ["12", "15"],
        // statement_descriptor: "statement descriptor"
    };

    Invoices invoices = stripeClient.invoices();
    // Invoice|Error invoice = invoices->create(invo);
    // if (invoice is Error) {
    //     io:println(invoice);
    // } else {
    //     io:println(invoice);
    // }

    // Invoice|Error invoice = invoices->retrieve("in_1GhwYbKTjsHGwZuGNxAOvgfA");
    // if (invoice is Error) {
    //     io:println(invoice);
    // } else {
    //     io:println(invoice);
    // }

    // Invoice|Error invoice = invoices->update("in_1GhwYbKTjsHGwZuGNxAOvgfA", invo);
    // if (invoice is Error) {
    //     io:println(invoice);
    // } else {
    //     io:println(invoice);
    // }

    // Error? invoice = invoices->deleteDraft("in_1GhmjiKTjsHGwZuGBD7YLfU9");
    // if (invoice is Error) {
    //     io:println(invoice);
    // }

    // Invoice|Error invoice = invoices->finalize("in_1GhwYbKTjsHGwZuGNxAOvgfA");
    // if (invoice is Error) {
    //     io:println(invoice);
    // } else {
    //     io:println(invoice);
    // }

    // Invoice|Error invoice = invoices->sendForMannualPayment("in_1GhwYbKTjsHGwZuGNxAOvgfA");
    // if (invoice is Error) {
    //     io:println(invoice);
    // } else {
    //     io:println(invoice);
    // }

    // Invoice[]|Error invoice = invoices->list();
    // if (invoice is Error) {
    //     io:println(invoice);
    // } else {
    //     io:println(invoice);
    // }
    
}


