<%@include file="./custom.jsp"%>

<%
    String query = "select m.movie_id, title, release_date, director, runtime, rating, genre, nvl(count, 0) as count\n"
    +"from movie m\n"
    +"left outer join\n"
    +"(select m.movie_id, sum(b.seats) as count\n"
    +"from book b, schedule s, movie m\n"
    +"where b.schedule_id=s.schedule_id\n"
    +"and s.movie_id = m.movie_id\n"
    +"and b.canceled='false'\n"
    +"group by m.movie_id) c\n"
    +"on m.movie_id=c.movie_id\n"
    +"where m.release_date<=("+sysdate+")+interval '10' day\n"
    +"order by count desc, release_date asc\n";
    String[] params = new String[] {"movie_id", "title", "release_date", "director", "runtime", "rating", "genre", "count"};
    String result = get(query, params, stmt);
    out.println(result);
    if(stmt!=null) stmt.close();
    if(conn!=null) conn.close();
%>