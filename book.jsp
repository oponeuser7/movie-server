<%@ include file="./custom.jsp" %>

<%
    String sid = request.getParameter("sid");
    String uid = request.getParameter("uid");
    String seats = request.getParameter("seats");
    String cash = request.getParameter("cash");
    String points = request.getParameter("points");
    String bonus = request.getParameter("bonus");
    String query = "insert into book(schedule_id, member_id, seats, cash, points, bonus)\n"
                    +"values("+sid+",'"+uid+"',"+seats+","+cash+","+points+","+bonus+")";
    String result = post(query, stmt);
    out.println(result);
%>