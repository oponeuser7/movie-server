<%@ page import="java.sql.*" %>
<%@include file="./dbconn.jsp"%>
<%
    request.setCharacterEncoding("utf-8");
	response.setHeader("Access-Control-Allow-Origin","*");
	Statement stmt = null;
    ResultSet rs = null;

    try {
        String query = "select m.movie_id, title, release_date, director, runtime, rating, genre, nvl(count, 0) as count\n"
                        +"from movie m\n"
                        +"left outer join\n"
                        +"(select m.movie_id, count(*) as count\n"
                        +"from book b, schedule s, movie m\n"
                        +"where b.schedule_id=s.schedule_id\n"
                        +"and s.movie_id = m.movie_id\n"
                        +"group by m.movie_id) c\n"
                        +"on m.movie_id=c.movie_id\n"
                        +"order by count desc, release_date asc\n";
        stmt = conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE, java.sql.ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(query);
        int key = 0; //json key
        out.println("{"); //json start
        while(rs.next()) {
            out.println("\""+(key++)+"\": {");
            out.println("\"movie_id\": \""+rs.getString("movie_id")+"\",");
            out.println("\"title\": \""+rs.getString("title")+"\",");
            out.println("\"director\": \""+rs.getString("director")+"\",");
            out.println("\"release_date\": \""+rs.getDate("release_date")+"\",");
            out.println("\"runtime\": \""+rs.getString("runtime")+"\",");
            out.println("\"rating\": \""+rs.getString("rating")+"\",");
            out.println("\"genre\": \""+rs.getString("genre")+"\",");
            out.println("\"count\": \""+rs.getString("count")+"\"");
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