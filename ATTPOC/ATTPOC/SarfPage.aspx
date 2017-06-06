<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SarfPage.aspx.cs" Inherits="JavascriptBasedApp.SarfPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Autoforms</title>
    <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>
    <%--<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>--%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.loadingoverlay/latest/loadingoverlay.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.loadingoverlay/latest/loadingoverlay_progress.min.js"></script>
    <script type="text/javascript" src="Scripts/globals.js"></script>
    <script type="text/javascript" src="Scripts/common.js"></script>

    <!--CSS imports-->
    <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.css" />
    <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
    <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
    <link rel="stylesheet" href="bootstrap.vertical-tabs.css" />
    <link rel="stylesheet" type="text/css" href="Styles/style.css" />

    <style>
        #BasemapToggle {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 50;
        }

        .dijitTooltipContainer {
            border: 0px !important;
            background: none !important;
        }

        .dialogtooltip {
            width: 230px;
            height: 205px;
            border: 1px solid lightgray;
            background-color: white;
            border-radius: 20px;
        }

        .dialogtooltipinput {
            border: 1px solid lightgray;
            margin: 20px;
            padding-top: 5px;
            border-radius: 5px;
            width: 190px;
        }

        .dialogtootipbtn {
            width: 30px;
            min-width: 50px;
            height: 25px;
            color: white;
            margin-left: 100px;
            font-weight: normal;
            padding: 0px;
        }

        .dialogtootipbtncancel {
            min-width: 50px;
            height: 25px;
            color: #0878c0;
            font-weight: normal;
            padding: 0px;
            margin-left: 10px;
        }
    </style>

</head>

<body>
    <form id="sarfForm" runat="server">
        <div class="container-fluid">
            <div class="row">
                <%--<div id="logoSection">
                    <img src="Styles/images/att-logo.png" class="att-logo" />
                    <span class="att-heading">BPM/Orchestration</span>
                </div>
                <div id="search" class="att-search"></div>--%>
                <nav class="navbar navbar-default clearfix" role="navigation">
                    <div class="navbar-header pull-left">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">
                            <img src="Styles/images/att-logo.png" class="att-logo" />
                            <span class="att-heading">Site Build</span>
                        </a>
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                        <div class="col-sm-3 col-md-4 col-md-offset-2">
                            <div id="search" class="att-search"></div>
                        </div>
                        <div class="col-md-3 pull-right text-right profile">
                            <span class="profileInfo themeBlue">Maxine Walters</span>
                            <i class="icon-user profileIcon themeBlue" aria-hidden="true"></i>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="row">

                <div class="col-md-3 pad-lr-5 slidingDiv detailsSlider" id="style-2">
                    <div class="cardHead">
                        <h3>SARF Details</h3>
                    </div>
                    <div class="cardHead ctrlOption">
                        <div id="editBtn">
                            <i class="fa fa-pencil menuIcon themeBlue" aria-hidden="true"></i>
                            <span>Edit</span>
                        </div>
                        <div id="toggleComment">
                            <i class="fa fa-wechat menuIcon themeBlue" aria-hidden="true"></i>
                            <span>Discuss</span>
                        </div>
                        <div>
                            <i class="fa fa-trash-o menuIcon themeBlue" aria-hidden="true"></i>
                            <span>Delete</span>
                        </div>
                    </div>
                    <div class="">
                        <div class="col-md-12 borderBottom" style="margin-top: 10px; margin-bottom: 5px; margin-left: 15px;">
                            <button type="button" id="detailsupdatebtn" class="btn btn-link pull-right linkcolor editLink">SAVE</button>
                            <button type="button" id="detailscancelBtn" class="btn btn-link pull-right linkcolor editLink">CANCEL</button>
                        </div>
                        <div class="sarfDetails">

                            <div class="row">
                                <div class="col-md-6 pull-left">
                                    <label for="txtsarfname">SARF Name:</label>
                                    <p class="lblDetails"><span id="lblsarfname"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtsarfname" />
                                </div>
                                <div class="col-md-6 pull-left">
                                    <label for="txtfacode">FA Code:</label>
                                    <p class="lblDetails"><span id="lblfacode"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtfacode" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 pull-left">
                                    <label for="txtsearchring">Search Ring ID:</label>
                                    <p class="lblDetails"><span id="lblsearchring"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtsearchring" />
                                </div>
                                <div class="col-md-6 pull-left">
                                    <label for="txtiplan">IPlan Job #:</label>
                                    <p class="lblDetails"><span id="lbliplan"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtiplan" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 pull-left">
                                    <label for="txtpace">Pace Number #:</label>
                                    <p class="lblDetails"><span id="lblpace"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtpace" />
                                </div>
                                <div class="col-md-6 pull-left">
                                    <label for="txtmarket">Market:</label>
                                    <p class="lblDetails"><span id="lblmarket"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtmarket" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 pull-left">
                                    <label for="txtcounty">County:</label>
                                    <p class="lblDetails"><span id="lblcounty"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtcounty" />
                                </div>
                                <div class="col-md-6 pull-left">
                                    <label for="txtfatype">FA Type:</label>
                                    <p class="lblDetails"><span id="lblfatype"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtfatype" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 pull-left">
                                    <label for="txtmarketcluster">Market Cluster:</label>
                                    <p class="lblDetails"><span id="lblmarketcluster"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtmarketcluster" />
                                </div>
                                <div class="col-md-6 pull-left">
                                    <label for="txtregion">Region:</label>
                                    <p class="lblDetails"><span id="lblregion"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtregion" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 pull-left">
                                    <label for="txtrfdesign">RF Design Engineer ATTUID:</label>
                                    <p class="lblDetails"><span id="lblrfdesign"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtrfdesign" />
                                </div>
                                <div class="col-md-6 pull-left">
                                    <label for="txtarea">Area In SqKm:</label>
                                    <p class="lblDetails"><span id="lblarea"></span></p>
                                    <input class="form-control txtDetails" runat="server" type="text" id="txtarea" />
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-md-8 pull-left">
                                    <div class="cardTail">
                                        <div class="form-group">
                                            <label for="txtSarfName">Current Status</label>
                                            <div class="col-xs-12" id="statusDiv">
                                                <span id="statusLabel"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-md-12 col-md-offset-2 wfbtnSet">
                                    <button type="button" id="promoteBtn" class="statusBtn mrg15-R blueBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                        value="promote">PROMOTE</button>
                                    <button type="button" id="demoteBtn" class="statusBtn whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                        value="demote">DEMOTE</button>
                                    <button type="button" id="pullbackBtn" class="statusBtn mrg15-R whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                        value="pullback">PULL BACK</button>
                                    <button type="button" id="cancelBtn" class="statusBtn whiteBtn btn btn-lg btn-danger btn-form btn-draw disabled"
                                        value="cancel">CANCEL</button>
                                </div>
                            </div>
                            <%--<div class="row">
                        <div class="col-md-12 text-center">
                            <button type="button" id="pullbackBtn" class="statusBtn mrg15-R whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                value="pullback">PULL BACK</button>
                            <button type="button" id="cancelBtn" class="statusBtn whiteBtn btn btn-lg btn-danger btn-form btn-draw disabled"
                                value="cancel">CANCEL</button>
                        </div>
                    </div>--%>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 tabDiv">
                    <div class="toggleArrow rotateArrow">
                        <%--<img src="Styles/images/double-arrow-right-red.png" title="Hide&Show SideBar" width="15" />--%>
                        <i class="fa fa-chevron-right" aria-hidden="true"></i>
                    </div>
                    <div class="col-md-12 borderBottom pageLink" style="margin-top: 7px; margin-bottom: 5px">
                        <a href="Default.aspx" class="linkcolor" style="margin-left: 30px;">Home</a> :: <a class="linkcolor">SARF Details</a>
                        <ul class="nav nav-tabs tabs-left navTabs-ul pull-right tabMenu">
                            <li class="active" data-index="0"><a href="#mapview" data-toggle="tab">Map</a></li>
                            <li class="" data-index="1"><a href="#workflow" data-toggle="tab">Workflow</a></li>
                        </ul>
                    </div>
                    <div class="col-xs-12">
                        <!-- required for floating -->
                        <!-- Nav tabs -->

                    </div>
                    <div class="col-xs-9">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane" id="mapview">
                                <div id="map" style="width: 138%; height: 520px" class="pull-left">
                                    <%--<a id="btnExpandMap" class="btn btn-primary" title="Click to maximize/minimize map">--%>
                                    <div id="BasemapToggle"></div>
                                </div>
                            </div>
                            <div class="tab-pane" id="workflow">
                                <div style="width: 138%; height: 520px;" class="pull-left">
                                    <iframe runat="server" id="workflowImg" style="width: 994px; height: 545px; padding-right: 5px;" src="#" frameborder="1" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 pad-lr-5 commentingDiv" id="style-2">
                        <button type="button" class="close commentCloseBtn" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div class="clearfix"></div>
                        <div>
                            <div class="input-group">
                                <span class="input-group-addon" id="basic-addon1">
                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                </span>
                                <input type="text" class="form-control" placeholder="Add your comment" aria-describedby="basic-addon1" />
                            </div>
                        </div>
                        <div>
                            <div class="clearfix"></div>
                            <button type="button" id="postBtn" class="blueBtn btn btn-sm btn-primary btn-form btn-draw disabled pull-right"
                                value="post">
                                POST</button>
                        </div>
                        <div>
                            <button type="button" id="seeMoreBtn" class="btn btn-link pull-left linkcolor editLink fontClass">See more comments</button>
                        </div>
                        <div class="clearfix"></div>
                        <div>
                            <div class="commentInfo">
                                <div class="chatHead clearfix">
                                    <div class="pull-left">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </div>
                                    <div class="pull-right chatLabel">
                                        <h3 class="fontClass">John Markus (C&E PM)</h3>
                                        <p class="fontClass">April 25, 2017 11:40 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        @Jill, Demoting the form as the iPlan details are incorrect. 
                                    </p>
                                    <div>
                                        <input type="text" class="form-control" placeholder="leave a reply" />
                                    </div>
                                </div>
                            </div>
                            <div class="commentInfo">
                                <div class="chatHead clearfix">
                                    <div class="pull-left">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </div>
                                    <div class="pull-right chatLabel">
                                        <h3 class="fontClass">Jill Baker (RF Engineer)</h3>
                                        <p class="fontClass">April 26, 2017 09:15 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        @John, Corrected the iPlan details and promoted the SARF again.
                                Can you plese review it and assign it to the vendor ?
                                    </p>
                                    <div>
                                        <input type="text" class="form-control" placeholder="leave a reply" />
                                    </div>
                                </div>
                            </div>
                            <div class="commentInfo">
                                <div class="chatHead clearfix">
                                    <div class="pull-left">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </div>
                                    <div class="pull-right chatLabel">
                                        <h3 class="fontClass">John Markus (C&E PM)</h3>
                                        <p class="fontClass">April 26, 2017 90:20 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        Need time to assign the SARF to the right vendor.
                                    </p>
                                    <div>
                                        <input type="text" class="form-control" placeholder="leave a reply" />
                                    </div>
                                </div>
                            </div>
                            <div class="commentInfo">
                                <div class="chatHead clearfix">
                                    <div class="pull-left">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </div>
                                    <div class="pull-right chatLabel">
                                        <h3 class="fontClass">Jill Baker (RF Engineer)</h3>
                                        <p class="fontClass">April 26, 2017 09:22 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        That's fine John. Thank you!
                                    </p>
                                    <div>
                                        <input type="text" class="form-control" placeholder="leave a reply" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </form>
    <script src="Scripts/sarfDetails.js"></script>
</body>
</html>
