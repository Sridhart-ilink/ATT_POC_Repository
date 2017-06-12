﻿//constants for workflow status types
var statusEnum = {
    RF_Pending_Completion: "RF Pending Completion",
    CE_PM_Vendor_Assignment: "C&E PM Vendor Assignment",
    TV_Pending_Approval: "TV Pending Approval",
    RF_Mod_CE_PM_Vendor_Assignment: "RF Mod - C&E PM Vendor Assignment",
    RF_Mod_TV_Pending_Approval: "RF Mod - TV Pending Approval",
    TV_Complete: "TV Complete",
    Cancel: "Cancel",
    RF_Approval: "RF Approval",
    SelectNodes: "Select Nodes",
    Completed: "Completed"
};
//constants for sarf details
var constants = {
    MarketCluster: 'SEATTLE/OREGON/NO. ID',
    Region: 'WEST',
    County: 'SPOKANE',
    Market: 'WASHINGTON',
    FAType: 'CELL',
    RFDesignEnggId: 'RF0001',
    FACode: '1167',
    IPlanJob: 'WR_-RWOR-14-0',
    PaceNumber: 'MRGEO00',
    SearchRingId: '13'
};

//loader messages Enum
var messageEnum = {
    CREATE_AREA_OF_INTEREST: 'Creating Area of interest',
    GETTING_NODES: 'Getting Nodes',
    GETTING_HUBS: 'Getting Hubs',
    ASSOCIATE_NODES_HUBS: 'Associating Nodes with Hubs'
};

//timer Enum
var timerEnum = {
    TIME_DELAY_SECONDS: 2000,
    TEN_SECONDS: 10000
};