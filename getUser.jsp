<%@ include file="./custom.jsp" %>

<%
    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");
    String query = "select member_id from member where member_id="+id+" and password='"+passwd+"'";
    String[] params = new String[] {"member_id"};
    String result = get(query, params, stmt);
    out.println(result);
%>