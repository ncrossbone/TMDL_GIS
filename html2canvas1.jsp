<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page session="false"%>
<%@page import="java.net.*,java.io.*,java.util.*,kr.go.nier.Util" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	HttpURLConnection connection = null;
	ServletContext servletContext = request.getSession().getServletContext();
	String relativeWebPath = "resources/images/cache";
	String absoluteDiskPath = servletContext.getRealPath(relativeWebPath);
	
	Util util = new Util(absoluteDiskPath);
	
	try {
		if(request.getParameter("url") != null && request.getParameter("url") != "") {
			
			String resourceUrlStr = request.getParameter("url");					
			URL resourceUrl = new URL(resourceUrlStr);
			//URL resourceUrl = new URL(request.getParameter("resourceUrl"));				
			connection = (HttpURLConnection)resourceUrl.openConnection();
			connection.setDoInput(true);
			connection.setRequestMethod(request.getMethod());
			response.setContentType(connection.getContentType());
			
			String imageUrl = util.getImageStreamAndUrl1(connection);
			response.setHeader("Cache-Control","no-store");   
			response.setHeader("Pragma","no-cache");   
			response.setDateHeader("Expires",0); 
			
			System.out.println(request.getParameter("callback") + "(resources/images/cache/" + imageUrl + ")");
			
			response.setContentType("text/html");
			PrintWriter out1 = response.getWriter();
			out1.append(request.getParameter("callback") + "('resources/images/cache/" + imageUrl + "')");
			out1.close();
		}
	} catch(Exception e) {
		response.setStatus(500);
		//e.printStackTrace();
	} finally {
		//if(istream != null) { istream.close(); }			
		//if(ostream != null) { ostream.close(); }
		//if(ristream != null) { ristream.close(); }
		//if(rostream != null) { rostream.close(); }			
	}
%>
</body>
</html>