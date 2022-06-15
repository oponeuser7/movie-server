<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ include file="./dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8");
    response.setHeader("Access-Control-Allow-Origin","*");
    Statement stmt = conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE, java.sql.ResultSet.CONCUR_READ_ONLY);
%>

<%!

    final String sysdate = "sysdate+interval '9' hour";

    String toJson(String[] params, ResultSet rs) {
        try {
            StringBuilder sb = new StringBuilder();
            int key = 0; //json key
            sb.append("{"); //json start
            while(rs.next()) {
                sb.append("\""+(key++)+"\": {");
                for(int i=0; i<params.length; i++) {
                    if(params[i].equals("release_date")) {
                        sb.append("\""+params[i]+"\": \""+rs.getDate(params[i])+"\"");
                    } else {
                        sb.append("\""+params[i]+"\": \""+rs.getString(params[i])+"\"");
                    }
                    if(i!=params.length-1) sb.append(",");
                }
                sb.append("}"+(rs.isLast() ? "" : ","));
            }
            sb.append("}"); //json end
            return sb.toString();
        }
        catch(SQLException ex) {
            return ("{SQLException: " + ex.getMessage()+"}");
        }
    }

    String get(String query, String[] params, Statement stmt) {
        try {
            ResultSet rs = stmt.executeQuery(query);
            return toJson(params, rs);
        }
        catch(SQLException ex) {
            return ("{SQLException: " + ex.getMessage()+"}");
        }
    }
%>