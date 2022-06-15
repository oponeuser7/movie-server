<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@include file="./custom.jsp"%>

<%
    String movie_id = request.getParameter("id");
    try {
        List<String> performers = new ArrayList<>();
        String query = "select name\n"
                        +"from performance p, movie m, performer a\n"
                        +"where p.movie_id=m.movie_id\n"
                        +"and p.performer_id=a.performer_id\n"
                        +"and m.movie_id="+movie_id;
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next()) performers.add(rs.getString("name"));

        query = "select title, director, release_date, runtime, rating, genre\n"
                +"from movie\n"
                +"where movie_id="+movie_id;
        rs = stmt.executeQuery(query);
        if(rs.next()) {
            out.println("title: "+rs.getString("title"));
            out.println("<br>");
            out.println("director: "+rs.getString("director"));
            out.println("<br>");
            out.println("release date: "+rs.getDate("release_date"));
            out.println("<br>");
            out.println("runtime: "+rs.getString("runtime"));
            out.println("<br>");
            out.println("rating: "+rs.getString("rating"));
            out.println("<br>");
            out.println("genre: "+rs.getString("genre"));
            out.println("<br>");
            out.println("starring: "+String.join(", ", performers));
		} else {
            out.println("error!");
        }
    } catch(SQLException ex) {
        out.println("{SQLException: " + ex.getMessage()+"}");
    } finally {
        if(stmt!=null) stmt.close();
        if(conn!=null) conn.close();
    }
%>