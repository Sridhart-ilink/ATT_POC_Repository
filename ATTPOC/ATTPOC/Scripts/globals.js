var DECIMAL_PRECISION = 5;
var events = [];
var isPortActive = false;
var localAppUrl = "localhost:54981";
var serverAppUrl = "attpoc-websvr.cloudapp.net/ATTWorkflowPOC";
var localApiUrl = "localhost:55537";
var serverApiUrl = "attpoc-websvr.cloudapp.net/ATTWebAppAPI";
var localHubImageUrl = '../Styles/images/';
var serverHubImageUrl = '../CRANng/Styles/images/';
var camundaBaseApiUrl = isPortActive ? "http://" + serverApiUrl + "/api/" :
    "http://" + localApiUrl + "/api/";
var appUrl = isPortActive ? "http://" + serverAppUrl + "/" : "http://" + localAppUrl + "/";
