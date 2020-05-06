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

public type Customer record {
    Address? address?;
    int balance?;
    string? coupon?;
    string description?;
    string email?;
    string? invoice_prefix?;
    CustomerInvoiceCustomFieldParams? invoice_settings?;
    CustomerShippingDetailsParams? shipping?;
    string name?;
    int? next_invoice_sequence?;
    string[]? preferred_locales?;
    string tax_exempt?;
    CustomerTaxIdDataParams? tax_id_data?;
};

public type CustomerInvoiceCustomFieldParams record {
	string? name?;
	string? value?;
    string? default_payment_method?;
    string? footer?;
};

public type CustomerShippingDetailsParams record {
	Address? address?; 
	string? name;
	string? phone?;       
};

public type CustomerTaxIdDataParams record {
	string? taxIdtype?;
	string? value?;
};

public type CustomerInvoiceSettings record {
	CustomerInvoiceCustomField? custom_fields?;
    string? default_payment_method?;
    string? footer?;
};

public type CustomerInvoiceCustomField record {
	string? name?;
	string? value?;
};

# Holds the parameters used to create a `Client`.
#
# + proxyConfig - Proxy configuration if connecting through a proxy
public type Configuration record {|
   http:ProxyConfig? proxyConfig = ();
|};