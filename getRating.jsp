<%@ include file="./custom.jsp" %>

<%
    String mid = request.getParameter("mid");
    String query = "select rating from movie where movie_id="+mid;
    String[] params = new String[] {"rating"};
    String result = get(query, params, stmt);
    out.println(result);
%>