<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("uid");
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String query = "select book_id, m.title, t.name as theater, a.name as auditorium, s.starting_time, b.seats, cash, points, (cash+points) as total, s.schedule_id\n"
                    +"from book b\n"
                    +"inner join schedule s on b.schedule_id=s.schedule_id\n"
                    +"inner join movie m on s.movie_id=m.movie_id\n"
                    +"inner join theater t  on s.theater_id=t.theater_id\n"
                    +"inner join auditorium a on s.auditorium_id=a.auditorium_id\n"
                    +"where canceled='false'\n"
                    +"and starting_time>=to_date('"+from+"', 'yyyy-mm-dd')\n"
                    +"and starting_time<=to_date('"+to+"', 'yyyy-mm-dd')\n"
                    +"and starting_time>sysdate\n"
                    +"and member_id="+uid+"\n"
                    +"order by starting_time asc";
    String[] params = new String[] {"book_id", "title", "theater", "auditorium", "starting_time", "seats", "cash", "points", "total", "schedule_id"};
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>