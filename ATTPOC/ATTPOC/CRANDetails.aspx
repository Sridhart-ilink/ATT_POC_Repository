﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRANDetails.aspx.cs" Inherits="JavascriptBasedApp.SarfPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CRAN</title>
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
                            <span class="att-heading">CRAN <i class="ngClass">NG</i></span>
                        </a>
                    </div>
                      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <div class="col-sm-3 col-md-4">
                            <div id="search" class="att-search"></div>
                        </div>
                        <div class="col-sm-2 col-md-2"></div>
                        <div class="navbar-header col-sm-2 col-md-2 profile" style="width: 110px; margin-top: 20px;">
                            <i class="icon-home"></i>
                            <a href="Default.aspx"  class="profileInfo dashboard" style="padding-left:0px; text-align:right; margin-left: 0px;">
                                <span class="att-heading" style="padding-left: 0px; margin-left: 0px">Home</span>
                            </a>
                        </div>
                        <div class="navbar-header col-sm-2 col-md-2 profile" style="padding-left: 5px; width: 120px; margin-top: 20px;">
                            <a href="CRANDashboard.html" class="profileInfo dashboard" style="padding-left: 5px; text-align: left">
                                <span style="margin-left: 5px;" class="att-heading">Dashboard</span>
                            </a>
                        </div>
                        <div class="col-md-2 pull-right text-right profile" style="width: 185px;">
                            <span class="profileInfo themeBlue">Maxine Walters</span>
                            <i class="icon-user profileIcon themeBlue" aria-hidden="true"></i>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="row">

                <div class="col-md-3 pad-lr-5 slidingDiv detailsSlider" id="style-2">
                    <div class="cardHead">
                        <h3>CRAN Details</h3>
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
                                    <label for="txtsarfname">Name:</label>
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
                                    <label for="txtarea">Area In SqMi:</label>
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
                                        value="approve">APPROVE ALL</button>
                                    <%--<button type="button" id="demoteBtn" class="statusBtn whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                        value="demote">DEMOTE</button>
                                    <button type="button" id="pullbackBtn" class="statusBtn mrg15-R whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                        value="pullback">PULL BACK</button>--%>
                                    <button type="button" id="cancelBtn" class="statusBtn whiteBtn btn btn-lg btn-danger btn-form btn-draw disabled"
                                        value="reject">REJECT ALL</button>
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
                        <%--<a href="Default.aspx" class="linkcolor" style="margin-left: 30px;">Home</a> :: <a class="linkcolor">CRAN Details</a>--%>
                        <ul class="nav nav-tabs tabs-left navTabs-ul pull-right tabMenu">
                            <li class="active" data-index="0"><a href="#mapview" data-toggle="tab">Map</a></li>
                            <li class="" data-index="1"><a href="#workflow" data-toggle="tab">Workflow</a></li>
                            <li class="history" data-index="2"><a href="#history" data-toggle="tab">History</a></li>
                        </ul>
                    </div>
                    <div class="col-xs-12">
                        <!-- required for floating -->
                        <!-- Nav tabs -->

                    </div>
                    <div class="col-xs-9">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="mapview">
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
                            <div class="tab-pane" id="history">
                                <div style="width: 138%; height: 780px;" class="pull-left historyTab">
                                    <div class="createdBtn">
                                        <a class="btn btn-default btn-form draw-btn" id="btnCreated" >Created</a>
                                    </div>
                                    <div class="timelineArea">                                      
                                        <div id="progressline">
                                        </div>
                                        <div class="progressContent pull-left">
                                            <span id="progressContent"></span>
                                        </div>
                                       <%-- <div class="progressContent pull-left">
                                            <div class="content contentAOI">
                                                <div class="progressDot"></div>
                                                <div class="progressHead">
                                                    <h3>Select Area Of Interest</h3>
                                                    <label>Date: <span class="dateSpan">06/13/2017 10:30:22</span></label>
                                                    <!--<label>Approved: <span class="dateSpan">06/13/2017 10:30:52</span></label>-->
                                                </div>
                                            </div>
                                            
                                            <div class="content contentSelectNodes">
                                                <div class="progressDot"></div>
                                                <div class ="identifyNodes pull-left highlightApproved">
                                                    <div class="progressHead">
                                                        <h3>Select Node(s)</h3>
                                                        <label>Start Date: <span class="dateSpan">06/13/2017 10:31:22</span></label>
                                                        <label>End Date:  <span class="dateSpan">06/13/2017 10:32:25</span></label>
                                                    </div>
                                                </div>
                                                <div class ="getAtolls pull-left">
                                                    <div class="progressHead">
                                                        <h3>Get Atolls</h3>
                                                        <label>Start Date: <span class="dateSpan">06/13/2017 10:31:22</span></label>
                                                        <label>End Date:  <span class="dateSpan">06/13/2017 10:32:25</span></label>
                                                    </div>
                                                </div>
                                                
                                            </div>
					                        <div class="content contentSelectHubs">
                                                <div class="progressDot"></div>
                                                <div class="progressHead">
                                                    <h3>Select Hub(s)</h3>
                                                    <label>Start Date: <span class="dateSpan">06/13/2017 10:35:42</span></label>
                                                    <label>End Date:  <span class="dateSpan">06/13/2017 11:36:45</span></label>
                                                </div>
                                            </div>
					                        <div class="content contentRFApproval">
                                                <div class="rfApproval">
                                                    <div class="progressCircle"></div>
                                                    <div class="progressHead">
                                                        <h3>RF Approval</h3>
                                                        <label>Start Date: <span class="dateSpan">06/13/2017 11:37:00</span></label>
                                                        <!--<label>Approved: <span class="dateSpan"></span></label>-->
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="content contentComplete">
                                                <div class="progressDot themeAsh"></div>
                                                <div class="progressHead">
                                                    <h3>Complete</h3>
                                                    <label>Date: <span class="dateSpan">06/13/2017 11:37:00</span></label>
                                                    <!--<label>Approved: <span class="dateSpan">06/10/2017 11:48:20</span></label>-->
                                                </div>
                                            </div>

                                        </div>--%>
                                    </div>
                                    <div class="completedBtn">
                                        <a class="btn btn-default btn-form draw-btn" id="btnCompleted" >Completed</a>
                                    </div>
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
                                        <h3 class="fontClass">John Markus</h3>
                                        <p class="fontClass">Jun 16, 2017 10:40 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        @Jill, Rejecting the form to reselect the Nodes with suggested changes in the Node selection criteria. 
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
                                        <h3 class="fontClass">Jill Baker</h3>
                                        <p class="fontClass">Jun 16, 2017 10:45 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        @John, Reselected the Nodes with the suggested criteria.
                                Can you plese review it to proceed futher?
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
                                        <h3 class="fontClass">John Markus</h3>
                                        <p class="fontClass">Jun 16, 2017 10:49 am</p>
                                    </div>
                                </div>
                                <div class="chatBody">
                                    <p class="fontClass">
                                        Need time to review.
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
                                        <h3 class="fontClass">Jill Baker</h3>
                                        <p class="fontClass">Jun 16, 2017 10:52 am</p>
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
