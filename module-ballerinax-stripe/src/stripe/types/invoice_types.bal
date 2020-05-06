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

public type InvoiceParams record {|
	boolean autoAdvance;
	int applicationFeeAmount;
	string collectionMethod;
	InvoiceCustomFieldParams customFields;
	string customer;
	int daysUntilDue;
	string defaultPaymentMethod;
	string defaultSource;
	string[] defaultTaxRates;
	string description;
	int dueDate;
	string footer;
	boolean paid;
	string statementDescriptor;
	string subscription;
	InvoiceTransferDataParams transferData;
    string coupon;
	InvoiceUpcomingInvoiceItemPeriodParams invoiceItems;
	int subscriptionBillingCycleAnchor;
	boolean subscriptionBillingCycleAnchorNow;
	boolean subscriptionBillingCycleAnchorUnchanged;
	int subscriptionCancelAt;
	boolean subscriptionCancelAtPeriodEnd;
	boolean subscriptionCancelNow;
	string[] subscriptionDefaultTaxRates;
	SubscriptionItemsParams subscriptionItems;
	string subscriptionPlan;
	boolean subscriptionProrate;
	string subscriptionProrationBehavior;
	int subscriptionProrationDate;
	int subscriptionQuantity;
	int subscriptionTrialEnd;
	boolean subscriptionTrialFromPlan;
	float taxPercent;
	float subscriptionTaxPercent;
|};

public type InvoiceTransferDataParams record {|
	string destination;
|};

public type InvoiceUpcomingInvoiceItemParams record {|
	int amount;
	string currency;
	string description;
	boolean discountable;
	string invoiceItem;
	InvoiceUpcomingInvoiceItemPeriodParams period;
	int quantity;
	string schedule;
	string[] taxRates;
	int unitAmount;
	float unitAmountDecima;
|};

public type InvoiceCustomFieldParams record {|
	string name;
	string value;
|};

public type InvoiceUpcomingInvoiceItemPeriodParams record {
	int endPeriod;
	int startPeriod;
};