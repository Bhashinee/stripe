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
import ballerina/io;

function createSubscriptionQuery(Subscription subscription) returns string {
    string queryString = "";
    string itemsQuery = "";
    string taxQuery = "";

    foreach [string, anydata] [key, value] in subscription.entries() {
        if (key == "subscription_items") {
            var subscriptionItemsRecord = subscription?.subscription_items;            
            if (subscriptionItemsRecord is Items[]) {
                int count = 0;
                foreach var subscriptionItem in subscriptionItemsRecord {
                    var plan = subscriptionItem[SUBSCRIPTION_PLAN];
                    var usageGte = subscriptionItem[BILLING_THRESHOLD][USAGE_GTE];
                    var quantity = subscriptionItem[QUANTITY];
                    var taxRate = subscriptionItem[TAX_RATE];
                    if (plan is string) {
                        itemsQuery = itemsQuery + ITEMS + "[" + count.toString() + "][" + PLAN + "]=" 
                                     + getEncodedUri(plan) + AND;
                    }
                    if (usageGte is int) {
                        itemsQuery = itemsQuery + ITEMS + "[" + count.toString() + "][" + USAGE_GTE_QUERY + "]=" 
                                     + usageGte.toString() + AND;
                    }
                    if (quantity is int) {
                        itemsQuery = itemsQuery + ITEMS + "[" + count.toString() + "][" + QUANTITY + "]=" 
                                     + quantity.toString() + AND;
                    }
                    if (taxRate is string[]) {
                        foreach var tax in taxRate {
                            taxQuery = taxQuery + "\"" + tax + "\",";
                        }
                        itemsQuery = itemsQuery + ITEMS + "[" + count.toString() + "][" + TAX_RATE + "]=" 
                                     + taxQuery + AND;
                    }
                    count = count + 1;
                }
            }
        } else if (key == BILLING_THRESHOLD) {
            var billingThresholdsRecord = subscription?.billing_thresholds;
            if (billingThresholdsRecord is SubscriptionBillingThresholds) {
                var amountGte = billingThresholdsRecord[AMOUNT_GTE];
                var billingCycleAnchor = billingThresholdsRecord[RESET_BILLING_CYCLE];
                if (amountGte is int) {
                    queryString = queryString + AMOUNT_GTE_QUERY + amountGte.toString() + AND;
                }
                    queryString = queryString + BILLING_THRESHOLD + "[" + RESET_BILLING_CYCLE + "]=" 
                                        + billingCycleAnchor.toString() + AND;
            }
        } else if (key == PENDING_INVOICE_INTERVAL) {
            var invoiceItemRecord = subscription?.pending_invoice_item_interval;
            if (invoiceItemRecord is PendingInvoiceItemInterval) {
                var interval = invoiceItemRecord[INTERVAL];
                var intervalCount = invoiceItemRecord[INTERVAL_COUNT];
                if (interval is string) {
                    queryString = queryString +  PENDING_INVOICE_INTERVAL + "[" + INTERVAL + "]=" 
                    + getEncodedUri(interval) + AND;
                }
                if (intervalCount is int) {
                    queryString = queryString + PENDING_INVOICE_INTERVAL + "[" + INTERVAL_COUNT + "]=" 
                    + intervalCount.toString() + AND;
                }
            }
        } else {
            queryString = queryString + key + "=" + getEncodedUri(value.toString()) + AND;
        }
    }
    io:println(queryString + itemsQuery);
    return queryString + itemsQuery;
}

function mapToSubscriptionRecord(http:Response response) returns @tainted Subscription|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println("---------------------------------");
        io:println(payload.toJsonString());
        io:println("---------------------------------"); 
        check checkForErrorResponse(payload);       
        io:println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"); 
        Subscription|error subscription = Subscription.constructFrom(payload);
        if (subscription is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = subscription);
        } else {
            return subscription;
        }
    }        
}

function mapToSubscriptions(http:Response response) returns @tainted Subscription[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var subscriptions = payload.data;
        if (subscriptions is error) {
            return setJsonResError(subscriptions);
        }
        json subscriptionsJson = <json> subscriptions;
        check checkForErrorResponse(subscriptionsJson);
        Subscription[]|error subscriptionsList = Subscription[].constructFrom(subscriptionsJson);
        if (subscriptionsList is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = subscriptionsList);
        } else {
            return subscriptionsList;
        }
    }        
}
