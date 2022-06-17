<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("uid");
    String points = request.getParameter("points");
    String query = "update member set points="+points+" where member_id="+uid;
    String result = post(query, stmt);
    out.println(result);
%>