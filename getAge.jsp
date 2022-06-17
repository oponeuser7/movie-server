<%@ include file="./custom.jsp" %>

<%
    String uid = request.getParameter("uid");
    String query = "select to_char(sysdate, 'YYYY')-to_char(birth_date, 'YYYY')+1 as age\n"
                    +"from member where member_id="+uid;
    String[] params = new String[] {"age"};
    String result = get(query, params, stmt);
    out.println(result);
%>