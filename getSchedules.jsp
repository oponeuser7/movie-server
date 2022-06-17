<%@include file="./custom.jsp"%>

<%
    String mid = request.getParameter("mid");
    String tid = request.getParameter("tid");
    String query = "select schedule_id, name, starting_time, type, seats\n"
                    +"from schedule s, auditorium a\n"
                    +"where s.auditorium_id=a.auditorium_id\n"
                    +"and s.theater_id="+tid+"\n"
                    +"and s.movie_id="+mid;
    String[] params = new String[] {"schedule_id", "name", "starting_time", "type", "seats"};
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>