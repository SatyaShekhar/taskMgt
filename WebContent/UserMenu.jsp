<%@page import="com.sb.pojo.Author"%>
<%@page import="com.sb.constants.PropertyNames" session="true"%>
<table  width="100%" bgcolor="black">
        <tr style="color: white">
            <td align="right">
                <b> [ <%=((Author)session.getAttribute(PropertyNames.USER)).getFullName()%> ] </b>
            </td>
    
            <td width="300" align="right">
            <a href="MyAccount.jsp" style="color:yellow">Home </a> | 
            <a href="MyAccount.jsp" style="color:yellow">Account</a>  | 
            <a href="UserAdminPage.jsp" style="color:yellow">Manage Project</a> |
            <a href="index.jsp" style="color:yellow"> Log out </a>
        </td></tr>
</table>