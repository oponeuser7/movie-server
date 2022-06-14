<%@ page import="java.sql.*" %>
<%@include file="./custom.jsp"%>

<%
    String movie_id = request.getParameter("id");
    try {
        String query = "select title, director, release_date, runtime, rating, genre from movie where movie_id="+movie_id;
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