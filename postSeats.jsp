<%@ include file="./custom.jsp" %>

<%
    String sid = request.getParameter("sid");
    String seats = request.getParameter("seats");
    String query = "update schedule set seats="+seats+" where schedule_id="+sid;
    String result = post(query, stmt);
    out.println(result);
%>