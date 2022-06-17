<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("uid");
    String query = "select points from member where member_id="+uid;
    String[] params = new String[] {"points"};
    String result = get(query, params, stmt);
    out.println(result);
%>