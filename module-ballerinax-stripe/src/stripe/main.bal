import ballerina/io;
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

}


