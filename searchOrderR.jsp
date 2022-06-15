<%@include file="./custom.jsp"%>

<%
    String query = "select movie_id, title, director, release_date, runtime, rating, genre from movie order by release_date";
    String[] params = new String[] {"movie_id", "title", "director", "release_date", "runtime", "rating", "genre"}; 
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>


