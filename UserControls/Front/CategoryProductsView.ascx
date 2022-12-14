<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CategoryProductsView.ascx.vb"
    Inherits="CategoryProductsView" %>
<%@ Register TagPrefix="user" TagName="ItemPager" Src="~/UserControls/Front/ItemPager.ascx" %>
<asp:UpdatePanel ID="updMain" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <user:ItemPager ID="UC_ItemPager_Header" runat="server" Visible="False" />
        <div class="row">
            <asp:PlaceHolder ID="phdCategoryFilters" runat="server">
                <script>
                    function clearForm(oForm) {
                        var elements = oForm.elements;
                        oForm.reset();
                        for (i = 0; i < elements.length; i++) {
                            field_type = elements[i].type.toLowerCase();
                            switch (field_type) {
                                case "text":
                                case "password":
                                case "textarea":
                                    elements[i].value = "";
                                    break;
                                case "radio":
                                case "checkbox":
                                    if (elements[i].checked) {
                                        elements[i].checked = false;
                                    }
                                    break;
                                case "select-one":
                                case "select-multi":
                                    elements[i].selectedIndex = 0;
                                    break;
                                default:
                                    break;
                            }
                        }
                        window.location = window.location.pathname;
                    }
                </script>
                <div class="small-12 medium-3 columns filterbar">
                    <div id="filterbar_pad">
                        <asp:Panel runat="server" ID="pnlFilters" DefaultButton="lnkBtnSearch">
                            <asp:UpdatePanel ID="updCategoryFilters" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="row collapse">
                                        <div class="small-8 columns">
                                            <a id="filtertop"></a><h2>
                                                <asp:Literal ID="litRefineHeading" runat="server" Text="<%$ Resources: Filters, ContentText_RefineSelection %>"></asp:Literal></h2>
                                        </div>
                                        <div class="small-4 columns">
                                            <asp:Button runat="server"
                                                OnClientClick="clearForm(this.form);"
                                                CssClass="clearfilters" Text="<%$ Resources: Comparison, ContentText_ClearAll %>" />
                                        </div>
                                    </div>

                                    <asp:Label runat="server" ID="lblKeywords" Text="<%$ Resources: Search, ContentText_Keywords %>" AssociatedControlID="txtSearch"></asp:Label>
                                    <div class="row collapse">
                                        <div class="small-10 columns">
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="filtertext"></asp:TextBox></div>
                                        <div class="small-2 columns">
                                            <asp:Button ID="lnkBtnSearch" runat="server"
                                                CssClass="button filterbutton postfix" Text="&#187;" ToolTip="<%$ Resources: Filters, ContentText_Apply %>"></asp:Button>
                                        </div>
                                    </div>



                                    <asp:Label runat="server" ID="lblSortBy" Text="<%$ Resources: Filters, ContentText_SortBy %>" AssociatedControlID="ddlOrderBy"></asp:Label>
                                    <asp:DropDownList ID="ddlOrderBy" runat="server" AutoPostBack="true">
                                    </asp:DropDownList>

                                    <asp:PlaceHolder ID="phdPriceRange" runat="server">
                                        <asp:Label runat="server" ID="lblPriceRange" Text="<%$ Resources: Filters, ContentText_PriceRange %>" AssociatedControlID="ddlPriceRange"></asp:Label>

                                        <asp:DropDownList ID="ddlPriceRange" runat="server" AutoPostBack="true">
                                        </asp:DropDownList>
                                        <asp:PlaceHolder ID="phdCustomPrice" runat="server">
                                            <div id="customprice" class="row collapse">
                                                <div class="small-1 columns">
                                                    <span class="prefix">
                                                        <asp:Literal ID="litFromSymbol" runat="server"></asp:Literal></span>
                                                </div>
                                                <div class="small-3 columns">
                                                    <asp:TextBox ID="txtFromPrice" runat="server" Text="0" CssClass="shorttext"></asp:TextBox>
                                                </div>
                                                <div class="small-1 columns">
                                                    <span class="prefix">&#x2192;</span>
                                                </div>
                                                <div class="small-1 columns"><span class="prefix">
                                                    <asp:Literal ID="litToSymbol" runat="server"></asp:Literal></span></div>
                                                <div class="small-3 columns">
                                                    <asp:TextBox ID="txtToPrice" runat="server" CssClass="shorttext"></asp:TextBox>
                                                </div>
                                                <div class="small-1 columns">&nbsp;</div>
                                                <div class="small-2 columns">
                                                    <asp:Button ID="lnkBtnSearch2" runat="server"
                                                        CssClass="button filterbutton postfix" Text="&#187;" ToolTip="<%$ Resources: Filters, ContentText_Apply %>"></asp:Button>
                                                </div>
                                            </div>
                                        </asp:PlaceHolder>
                                    </asp:PlaceHolder>

                                    <asp:Panel ID="pnlValues" runat="server">

                                        <asp:PlaceHolder ID="phdAttributes" runat="server">
                                            <div class="filterattributes">

                                                <asp:Repeater ID="rptAttributes" runat="server">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAttributeName" runat="server" Text='<%# Eval("AttributeName")%>' CssClass="attribute_title"></asp:Label>
                                                        <asp:CheckBoxList ID="chkList" runat="server" CssClass="checkbox" AutoPostBack="true"></asp:CheckBoxList>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </asp:PlaceHolder>

                                    </asp:Panel>


                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </div>
                </div>
            </asp:PlaceHolder>
            <% If phdCategoryFilters.Visible = True Then%>
            <div class="small-12 medium-9 columns">
                <%Else%>
                <div class="small-12 columns">
                    <% End If%>
                    <asp:MultiView ID="mvwCategoryProducts" runat="server" ActiveViewIndex="0">
                        <!-- products normal -->
                        <asp:View ID="viwNormal" runat="server">
                            <div class="products products_normal">
                                <asp:Repeater ID="rptNormal" runat="server">
                                    <ItemTemplate>
                                        <user:ProductTemplateNormal ID="UC_ProductNormal" runat="server" />
                                    </ItemTemplate>
                                    <SeparatorTemplate>
                                    </SeparatorTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:View>
                        <!-- products extended -->
                        <asp:View ID="viwExtended" runat="server">
                            <div class="products products_extended">
                                <asp:Repeater ID="rptExtended" runat="server">
                                    <ItemTemplate>
                                        <asp:UpdatePanel ID="updProductsExtended" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <user:ProductTemplateExtended ID="UC_ProductExtended" runat="server" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ItemTemplate>
                                    <SeparatorTemplate>
                                    </SeparatorTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:View>
                        <!-- products shortened -->
                        <asp:View ID="viwShortened" runat="server">
                            <div class="products products_shortened">
                                <asp:Repeater ID="rptShortened" runat="server">
                                    <ItemTemplate>
                                        <user:ProductTemplateShortened ID="UC_ProductShortened" runat="server" />
                                    </ItemTemplate>
                                    <SeparatorTemplate>
                                    </SeparatorTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:View>
                        <!-- products tabular -->
                        <asp:View ID="viwTabular" runat="server">
                            <div class="products products_tabular">
                                <asp:Repeater ID="rptTabular" runat="server">
                                    <ItemTemplate>
                                        <user:ProductTemplateTabular ID="UC_ProductTabular" runat="server" />
                                    </ItemTemplate>
                                    <SeparatorTemplate>
                                    </SeparatorTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:View>
                        <asp:View ID="viwNoItems" runat="server">
                            <div class="filternoproducts">
                                <asp:Literal ID="litNotItemsFound" runat="server" Text="<%$ Resources: Kartris, ContentText_NoItems %>"></asp:Literal>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                    <div class="spacer"></div>
                </div>
            </div>
            <user:ItemPager ID="UC_ItemPager_Footer" runat="server" Visible="False" />
    </ContentTemplate>
</asp:UpdatePanel>
