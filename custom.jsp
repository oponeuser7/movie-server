<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ include file="./dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8"); //Set character encoding to utf-8
    response.setHeader("Access-Control-Allow-Origin","*"); //set CORS option 
    //To use ResultSet.isLast() method, use TYPE_SCROLL_INSENSITIVE, CONCUR_READ_ONLY options
    Statement stmt = conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE, java.sql.ResultSet.CONCUR_READ_ONLY);
%>

<%!

    //Define sysdate (My linux server timezone is not korea)
    final String sysdate = "sysdate+interval '9' hour"; 

    //This is a method which makes ResultSet into JSON string
    String toJson(String[] params, ResultSet rs) {
        try {
            StringBuilder sb = new StringBuilder(); //StringBuilder to save result json strings
            int key = 0; //json key
            sb.append("{"); //json start
            while(rs.next()) {
                sb.append("\""+(key++)+"\": {"); //json needs a key
                for(int i=0; i<params.length; i++) {
                    if(params[i].equals("release_date")) { //need to use getDate at date type
                        sb.append("\""+params[i]+"\": \""+rs.getDate(params[i])+"\"");
                    } else { //"parameter" : "value"
                        sb.append("\""+params[i]+"\": \""+rs.getString(params[i])+"\"");
                    } //delete trailling comma
                    if(i!=params.length-1) sb.append(",");
                } //delete trailling comma
                sb.append("}"+(rs.isLast() ? "" : ","));
            }
            sb.append("}"); //json end
            return sb.toString(); //retrun json string
        }
        catch(SQLException ex) {
            return ("SQLException: " + ex.getMessage());
        }
    }

    //This is a method to deal with http get method
    //I have a rule about using http methods. 
    //I use get method for oracle 'select' and post method for oracle 'update', 'insert', 'delete'
    String get(String query, String[] params, Statement stmt) {
        try {
            ResultSet rs = stmt.executeQuery(query); //Execute query and save result to ResultSet
            return toJson(params, rs); //return JSON formed string
        }
        catch(SQLException ex) {
            return ("SQLException: " + ex.getMessage());
        }
    }
    
    //This iis a method to deal with http post method
    String post(String query, Statement stmt) {
        try {
            stmt.executeUpdate(query); //Execute query
            return "SQLException: null"; //return
        }
        catch(SQLException ex) {
            return "SQLException: "+ex.getMessage();
        }
    }
%>