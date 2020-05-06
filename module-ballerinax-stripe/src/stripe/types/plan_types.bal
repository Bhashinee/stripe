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

public type PlanParams record {| 
    int amount;
    string currency;
    string interval;
    int intervalCount?;
    PlanProductParams product;
    boolean active?;
    string nickName?;
    string aggregateUsage?;
    float amountDecimal?;
    string billingScheme?;
    string id?;
    PlanTierParams[] tiers?;
    string tiersMode?;
    PlanTransformUsageParams transformUsage?;
    int trialPeriodDays?;
    string usageType?;
|};

public type PlanProductParams record {|
	boolean active?;              
	string id?;
	string name;
	map<string> metaData?;
	string statementDescriptor?;
	string unitLabel?;
|};

public type PlanTierParams record {|
    int flatAmount;
    float flatAmountDecimal;
    int unitAmount;
    float unitAmountDecimal;
    int upTo;
    boolean uptoInf;
|};

public type PlanTransformUsageParams record {|
	int devidedBy;
	string round;
|};

