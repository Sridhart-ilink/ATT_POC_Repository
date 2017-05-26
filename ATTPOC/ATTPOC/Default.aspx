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
        <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/style.css" />
  
    </head>
    
    <body>
        <form runat="server" id ="sarfForm">
            <div id="mainWrapper" class =" container">
                <div class="view">
                    <div class="header-block">
                        <h4 class="inline">ArcGIS - SARF</h4>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div>
                        <asp:DataGrid runat="server" ID="dtGrid" AutoGenerateColumns="false" class="table table-hover" PageSize="5" AllowPaging="true" OnPageIndexChanged="dtGrid_OnPageIndexChanging">
                        <Columns>
                            <asp:BoundColumn DataField="SarfID"  HeaderStyle-Width="30px" HeaderStyle-BackColor="Gray" ItemStyle-Width="100px" HeaderStyle-ForeColor="White" HeaderText="SARF ID"></asp:BoundColumn>
                            
                            <asp:TemplateColumn HeaderStyle-BackColor="Gray" ItemStyle-Width="100px" HeaderStyle-ForeColor="White" HeaderText="SARF Name">
                                <ItemTemplate>
                                    <a class="sarfclick" style="color: black; cursor: pointer;" data-vertices='<%# Eval("Vertices") %>' data-sarfid ='<%# Eval("SarfID") %>' data-processinstanceid = '<%# Eval("ProcessInstanceID") %>' ><%# Eval("SarfName") %></a>
                                     <asp:HiddenField ID="HiddenVertices" runat="server" Value='<%#Eval("Vertices") %>'/>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="AreaInSqKm"  HeaderStyle-BackColor="Gray" ItemStyle-Width="100px" HeaderStyle-ForeColor="White" HeaderText="Area (sqkm)"></asp:BoundColumn>
                        </Columns>
                        <PagerStyle Mode="NumericPages" />
                        <ItemStyle BackColor="LightGray" ForeColor="Black" Font-Names="Arial" />
                        <AlternatingItemStyle BackColor="White" ForeColor="Black" Font-Names="Arial" />
                    </asp:DataGrid>
                        <asp:HiddenField runat="server" ID="hdnCellColor" />
                    </div>

                    <a class="btn btn-default btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                            value="polygon">Draw</a>

                    <div id="drawOptions">
                        <div class="form-group">
                            <label for="txtSarfName">Sarf Name:</label>
                            <input class="form-control" type ="text" id="txtSarfName" placeholder="Sarf Name"/>
                        </div>
                        <button class="btn btn-primary" id="btnSave">Save</button>
                        <textarea style="visibility: hidden;" id="vertices" runat="server" rows="3" class="form-control form-group"></textarea>
                        <asp:HiddenField runat="server" ID="hdnArea" />
                    </div>
                </div>
                <div id="search"></div>
                <div id="map" style ="width : 65%; height : 620px" class ="pull-right">
                    <a id="btnExpandMap" class="btn btn-primary" title="Click to maximize/minimize map">
                    <span class="glyphicon glyphicon-chevron-up"></span></a>
                </div>
            </div>
        </form>
    </body>
</html>
