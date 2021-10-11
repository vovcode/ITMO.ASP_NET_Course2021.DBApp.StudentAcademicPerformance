<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ITMO.ASP_NET_Course2021.DBApp.StudentAcademicPerformance.Default" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="navmenu" runat="server">Работа с табелем успеваемости</asp:Content>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="contentBody" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 192px;
        }
        .auto-style2 {
            width: 192px;
            height: 26px;
            text-align: left;
        }
        .auto-style3 {
            height: 26px;
        }
        .auto-style4 {
            width: 192px;
            text-align: left;
        }
        .auto-style5 {
            height: 26px;
            width: 357px;
        }
        .auto-style6 {
            width: 357px;
        }
    </style>
        <div>
            <asp:HiddenField ID="hStudentId" runat="server" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <br />
&nbsp;<table>
                 <tr>
                     <td class="auto-style2">
                         <asp:Label ID="Label1" runat="server" Text="Фамилия Имя Отчество"></asp:Label>
                     </td>
                     <td class="auto-style3">
                         <asp:TextBox ID="txtFullName" runat="server" Width="250px"></asp:TextBox>
                     </td>
                     <td class="auto-style5">
                         <asp:RangeValidator ID="RangeFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Поле запоняется ФИО через пробелы" MaximumValue="Я" MinimumValue="А" Display="Dynamic">Поле ФИО начинается с прописной буквы</asp:RangeValidator>
                     </td>
                 </tr>
                <tr>
                     <td class="auto-style4">
                         <asp:Label ID="Label2" runat="server" Text="Оценки за период обучения"></asp:Label>
                     </td>
                     <td>
                         <asp:TextBox ID="txtGrades" runat="server" TextMode="MultiLine" Width="250px"></asp:TextBox>
                     </td>
                     <td class="auto-style6">
                         <asp:RegularExpressionValidator ID="RegexResultSting" runat="server" ControlToValidate="txtGrades" Display="Dynamic" ErrorMessage="В поле оценок допустим ввод от 2 до 5" ValidationExpression="^[2-5]+$">Допустимы оценки от 2 до 5</asp:RegularExpressionValidator>
                     </td>
                 </tr>
                <tr>
                    <td class="auto-style1">

                    </td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Сохранить" Width="87px" OnClick="btnSave_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Удалить" Width="87px" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Очистить" OnClick="btnClear_Click" Width="87px" />
                    </td>
                    <td class="auto-style6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">

                    </td>
                    <td>
                        <asp:Label ID="lblSuccessMsg" runat="server" ForeColor="Green"></asp:Label>
                    </td>
                    <td class="auto-style6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                         
                    </td>
                    <td>
                        <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style6">
                        &nbsp;</td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="StudInfoGV" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="Фамилия Имя Отчество" />
                <asp:BoundField DataField="ResultString" HeaderText="Оценки за период обучения" />
                <asp:BoundField DataField="GPA" HeaderText="Средний балл" />
                <asp:BoundField DataField="TotalScore" HeaderText="Общее количество баллов" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("StudentId") %>' OnClick="lnk_OnClick">Просмотр</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="White" HorizontalAlign="Center" BackColor="#284775" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        </div>
    </asp:Content>
