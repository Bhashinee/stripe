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

public type SubscriptionParams record {
	float applicationFeePercent;
	int backdateStartDate;
	int billingCycleAnchor;
	boolean billingCycleAnchorNow;
	boolean billingCycleAnchorUnchanged;
	SubscriptionBillingThresholdsParams billingThresholds;
	int cancelAt;
	boolean cancelAtPeriodEnd;
	CardParams card;
	string coupon;
	string customer;
	int daysUntilDue;
	string defaultPaymentMethod;
	string defaultSource;
	string[] defaultTaxRates;
	SubscriptionItemsParams Items;
	boolean offSession;
	string onBehalfOf;
	SubscriptionPauseCollectionParams pauseCollection;
	string paymentBehavior;
	SubscriptionPendingInvoiceItemIntervalParams pendingInvoiceItemInterval;
	string plan;
	boolean prorate;
	string prorationBehavior;
	int prorationDate;
	int quantity;
	int trialEnd;
	SubscriptionTransferDataParams transferData;
	boolean trialEndNow;
	boolean trialFromPlan;
	int trialPeriodDays;
	float taxPercent;
};

public type SubscriptionBillingThresholdsParams record {
	int amountGTE;
	boolean resetBillingCycleAnchor;
};

public type SubscriptionItemsParams record {|
	SubscriptionBillingThresholdsParams billingThresholds;
	boolean clearUsage;
	boolean deleted;
	string id;
	string plan;
	int quantity;
	string[] taxRates;
|};

public type SubscriptionPauseCollectionParams record {|
	string behavior;  
	int resumesAt;
|};

public type SubscriptionPendingInvoiceItemIntervalParams record {|
	string interval;
	int intervalCount;
|};

public type SubscriptionTransferDataParams record {|
	string destination;
|};

