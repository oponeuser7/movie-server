<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("uid");
    String query = "select book_id, m.title, t.name as theater, a.name as auditorium, s.starting_time, seats, cash, points, (cash+points) as total\n"
                    +"from book b\n"
                    +"inner join schedule s on b.schedule_id=s.schedule_id\n"
                    +"inner join movie m on s.movie_id=m.movie_id\n"
                    +"inner join theater t  on s.theater_id=t.theater_id\n"
                    +"inner join auditorium a on s.auditorium_id=a.auditorium_id\n"
                    +"where member_id="+uid;
    String[] params = new String[] {"book_id", "title", "theater", "auditorium", "starting_time", "seats", "cash", "points","total"};
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>