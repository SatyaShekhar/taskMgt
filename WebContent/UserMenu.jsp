<%@page import="com.sb.constants.PropertyNames" session="true"%>
<table  width="100%" bgcolor="black">
        <tr style="color: white">
            <td align="right">
                <b> [ <%=session.getAttribute(PropertyNames.USER_NAME)%> ] </b>
            </td>
    
            <td width="300" align="right">
            <a href="UserMainPage.jsp" style="color:yellow">Home </a> | 
            <a href="" style="color:yellow">Account</a>  | 
            <a href="UserAdminPage.jsp" style="color:yellow">Manage Project</a> |
            <a href="index.jsp" style="color:yellow"> Log out </a>
        </td></tr>
</table>