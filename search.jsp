<%@ page import="java.sql.*" %>
<%@include file="./dbconn.jsp"%>
<%
    request.setCharacterEncoding("utf-8");
	response.setHeader("Access-Control-Allow-Origin","*");
	Statement stmt = null;
    ResultSet rs = null;

    String title = request.getParameter("title");
    try {
        String query = "select title, director, release_date, runtime, rating, genre from movie";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        int key = 0; //json key
        out.println("{"); //json start
        while(rs.next()) {
            out.println((key++)+": {");
            out.println("title: "+rs.getString("title")+",");
            out.println("director: "+rs.getString("director")+",");
            out.println("release_date: "+rs.getString("release_date")+",");
            out.println("runtime: "+rs.getString("runtime")+",");
            out.println("rating: "+rs.getString("rating")+",");
            out.println("genre: "+rs.getString("genre")+",");
            out.println("},");
        }
        out.println("}"); //json end
    } catch(SQLException ex) {
        out.println("{");
        out.println("SQLException: " + ex.getMessage());
        out.println("}");
    } finally {
        if(stmt!=null) stmt.close();
        if(conn!=null) conn.close();
    }
%>


