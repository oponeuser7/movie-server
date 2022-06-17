<%@ include file="./custom.jsp" %>

<%
    String bid = request.getParameter("bid");
    String query = "update book set canceled='true', cancel_time="+sysdate+" where book_id="+bid;
    String result = post(query, stmt);
    out.println(result);
%>