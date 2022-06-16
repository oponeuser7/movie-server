<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("sid");
    String query = "select seats from schedule where schedule_id="+sid;
    String[] params = new String[] {"seats"};
    String result = get(query, params, stmt);
    out.println(result);
%>