<%@include file="./custom.jsp"%>

<%
    String query = "select theater_id, name from theater";
    String[] params = new String[] {"theater_id", "name"};
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>