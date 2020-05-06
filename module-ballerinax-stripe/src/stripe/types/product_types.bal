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

public type Product record {
	boolean active?;
	string[] attributes?;
	string caption?;
	string[] deactivate_on?;
	string description?;
	string id?;
	string[] images?;
	string name;
	PackageDimensions package_dimensions?;
	boolean shippable?;
	string 'type?;
	string url?;
};

// public type PackageDimensionsParams record {|
// 	float height?;
// 	float length?;
// 	float weight?;
// 	float width?;
// |};

// public type Product record {
// 	boolean active;
// 	string[] attributes;
// 	string caption;
// 	int created;
// 	string[] deactivate_on;
// 	string description;
// 	string id;
// 	string[] images;
// 	boolean livemode;
// 	map<string> metadata;
// 	string name;
// 	PackageDimensions package_dimensions;
// 	boolean shippable;
// 	string statement_descriptor;
// 	string productType;
// 	string unit_label;
// 	string url;
// 	int updated;
// };

public type PackageDimensions record {
	float height;
	float length;
	float weight;
	float width;
};
