﻿var DECIMAL_PRECISION = 5;
var events = [];
//url path declarations
var appUrl = "http://localhost:54987/";
var camundaBaseApiUrl = "http://localhost:55537/api/";
var statusEnum = {
    One: "RF Pending Completion",
    Two: "C&E PM Vendor Assignment",
    Three: "TV Pending Approval",
    Four: "RF Mod - C&E PM Vendor Assignment",
    Five: "RF Mod - TV Pending Approval",
    Six: "TV Complete",
    Seven: "Cancel"
};