<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="JavascriptBasedApp._Default" %>

<%--<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">--%>
<!--JS imports-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
         <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Polygon</title>
        <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
        <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>
        <script type="text/javascript" src="Scripts/globals.js"></script>
        <script type="text/javascript" src="Scripts/script.js"></script>
  
        <!--CSS imports-->
        <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/style.css" />
  
    </head>
    
    <body>
        <form runat="server" id ="sarfForm">
            <div id="mainWrapper" class="container-fluid">
                  <div class="row">
              
                  <div class="col-md-3 slidingDiv">
                    <div>
                         <a class="btn btn-default btn-form btn-draw disabled btnDraw" id="btnDraw" value="polygon">DRAW A NEW SARF</a>
                        <asp:DataGrid runat="server" ID="dtGrid" AutoGenerateColumns="false" class="table table-hover" PageSize="10" AllowPaging="true" OnPageIndexChanged="dtGrid_OnPageIndexChanging">
                        <Columns>
                           
                            <asp:BoundColumn DataField="SarfID"  HeaderStyle-Width="30px" HeaderStyle-BackColor="Gray" ItemStyle-Width="100px" HeaderStyle-ForeColor="White" HeaderText="SARF ID"></asp:BoundColumn>
                            
                            <asp:TemplateColumn HeaderStyle-BackColor="Gray" ItemStyle-Width="100px" HeaderStyle-ForeColor="White" HeaderText="SARF NAME">
                                <ItemTemplate>
                                    <a class="sarfclick" style="color: black;font-size:13px;font-family:'Roboto', Regular; cursor: pointer;" data-vertices='<%# Eval("Vertices") %>' data-sarfid ='<%# Eval("SarfID") %>' data-processinstanceid = '<%# Eval("ProcessInstanceID") %>' ><%# Eval("SarfName") %></a>
                                     <asp:HiddenField ID="HiddenVertices" runat="server" Value='<%#Eval("Vertices") %>'/>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="AreaInSqKm"  HeaderStyle-BackColor="Gray" ItemStyle-Width="100px" HeaderStyle-ForeColor="White" HeaderText="AREA (sqkm)"></asp:BoundColumn>
                        </Columns>
                        <PagerStyle Mode="NumericPages" />
                        <ItemStyle BackColor="LightGray" ForeColor="black" Font-Names="Roboto, Regular" Font-Size="13px"  />
                        <AlternatingItemStyle BackColor="White" ForeColor="black" Font-Names="Roboto, Regular" Font-Size="13px"/>
                        <HeaderStyle  Font-Names="Roboto, Regular" Font-Size="14px" />
                    </asp:DataGrid>
                        <asp:HiddenField runat="server" ID="hdnCellColor" />
                    </div>

                    <%--<a class="btn btn-default btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                            value="polygon">Draw</a>--%>

                    <div id="drawOptions">
                        <%--<div class="form-group">
                            <label for="txtSarfName">Sarf Name:</label>
                            <input class="form-control" type ="text" id="txtSarfName" placeholder="Sarf Name"/>
                        </div>
                        <button class="btn btn-primary" id="btnSave">Save</button>--%>
                        <textarea style="visibility: hidden;" id="vertices" runat="server" rows="3" class="form-control form-group"></textarea>
                        <asp:HiddenField runat="server" ID="hdnArea" />
                    </div>
                </div>
                <div class="col-md-9 tabDiv">
                    <div class="toggleArrow">
                           <img src="Styles/images/double-arrow-right-red.png" title="Hide&Show SideBar" width="15" />
                       </div>
                    <div id="search"></div>
                    <div id="map" class="pull-left">
                        <a id="btnExpandMap" class="btn btn-primary" title="Click to maximize/minimize map">
                        <span class="glyphicon glyphicon-chevron-up"></span></a>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
