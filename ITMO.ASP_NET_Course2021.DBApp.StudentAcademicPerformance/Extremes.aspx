<%@ Page Language="C#" MasterPageFile="~/Site.Master"  AutoEventWireup="true" CodeBehind="Extremes.aspx.cs" Inherits="ITMO.ASP_NET_Course2021.DBApp.StudentAcademicPerformance.Extremes" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="navmenu" runat="server">Лучшие и худшие показатели</asp:Content>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="contentBody" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 67%;
        }
        .auto-style2 {
            width: 480px;
            text-align: left;
        }
    </style>
        <div>
            <br />
            <br />
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:GridView ID="BestStudentsGrid" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="StudentId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Height="184px" Width="481px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="StudentId" HeaderText="StudentId" InsertVisible="False" ReadOnly="True" SortExpression="StudentId" Visible="False" />
                                <asp:BoundField DataField="FullName" HeaderText="Лучшие студенты" SortExpression="FullName" />
                                <asp:BoundField DataField="ResultString" HeaderText="ResultString" SortExpression="ResultString" Visible="False" />
                                <asp:BoundField DataField="GPA" HeaderText="Средний балл" SortExpression="GPA" />
                                <asp:BoundField DataField="TotalScore" HeaderText="TotalScore" SortExpression="TotalScore" Visible="False" />
                            </Columns>
                            <EditRowStyle BackColor="#7C6F57" />
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#E3EAEB" />
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F8FAFA" />
                            <SortedAscendingHeaderStyle BackColor="#246B61" />
                            <SortedDescendingCellStyle BackColor="#D4DFE1" />
                            <SortedDescendingHeaderStyle BackColor="#15524A" />
                        </asp:GridView>
                    </td>
                    <td>
                        <asp:GridView ID="WorstStudentsGrid" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="StudentId" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" Height="184px" Width="481px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="StudentId" HeaderText="StudentId" InsertVisible="False" ReadOnly="True" SortExpression="StudentId" Visible="False" />
                                <asp:BoundField DataField="FullName" HeaderText="Худшие студенты" SortExpression="FullName" />
                                <asp:BoundField DataField="ResultString" HeaderText="ResultString" SortExpression="ResultString" Visible="False" />
                                <asp:BoundField DataField="GPA" HeaderText="Средний балл" SortExpression="GPA" />
                                <asp:BoundField DataField="TotalScore" HeaderText="TotalScore" SortExpression="TotalScore" Visible="False" />
                            </Columns>
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <SortedAscendingCellStyle BackColor="#FDF5AC" />
                            <SortedAscendingHeaderStyle BackColor="#4D0000" />
                            <SortedDescendingCellStyle BackColor="#FCF6C0" />
                            <SortedDescendingHeaderStyle BackColor="#820000" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (5) Students.* FROM Students ORDER BY GPA DESC, TotalScore DESC"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (5) Students.* FROM Students ORDER BY GPA ASC, TotalScore ASC"></asp:SqlDataSource>
            <br />
            <br />
            <br />
        </div>
</asp:Content>