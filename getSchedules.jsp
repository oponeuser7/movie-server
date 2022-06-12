<%@ page import="java.sql.*" %>
<%@include file="./dbconn.jsp"%>
<%
    request.setCharacterEncoding("utf-8");
	response.setHeader("Access-Control-Allow-Origin","*");
	Statement stmt = null;
    ResultSet rs = null;

    String id = request.getParameter("id");

    try {
        String query = "select schedule_id, name, starting_time\n"
                        +"from schedule s, auditorium a\n"
                        +"where s.auditorium_id=a.auditorium_id\n"
                        +"and s.theater_id="+id;
        stmt = conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE, java.sql.ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(query);
        int key = 0; //json key
        out.println("{"); //json start
        while(rs.next()) {
            out.println("\""+(key++)+"\": {");
            out.println("\"schedule_id\": \""+rs.getString("schedule_id")+"\",");
            out.println("\"name\": \""+rs.getString("name")+"\",");
            out.println("\"starting_time\": \""+rs.getString("starting_time")+"\"");
			out.println("}"+(rs.isLast() ? "" : ","));
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