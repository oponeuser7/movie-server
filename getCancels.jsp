<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("uid");
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String query = "select book_id, m.title, t.name as theater, a.name as auditorium, cancel_time, b.seats, cash, points, (cash+points) as total\n"
                    +"from book b\n"
                    +"inner join schedule s on b.schedule_id=s.schedule_id\n"
                    +"inner join movie m on s.movie_id=m.movie_id\n"
                    +"inner join theater t  on s.theater_id=t.theater_id\n"
                    +"inner join auditorium a on s.auditorium_id=a.auditorium_id\n"
                    +"where canceled='true'\n"
                    +"and starting_time>=to_date('"+from+"', 'yyyy-mm-dd')\n"
                    +"and starting_time<=to_date('"+to+"', 'yyyy-mm-dd')\n"
                    +"and member_id="+uid+"\n"
                    +"order by cancel_time asc";
    String[] params = new String[] {"book_id", "title", "theater", "auditorium", "cancel_time", "seats", "cash", "points","total"};
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>