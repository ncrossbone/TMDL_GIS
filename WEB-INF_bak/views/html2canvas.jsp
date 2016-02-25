<%@ page import="jasp.buildin.*" %>
<%@ page import="jasp.util.*" %>
<%@ page import="jasp.vbs.*" %>
<%@ page import="jasp.io.*" %>
<%@ page import="java.util.*" %>
<%@ page extends="jasp.servlet.JspBase" %>
<% 
 try {
    jspinit(request,response,application,out);
%>

<% 
    //html2canvas-asp-vbscript-proxy 0.0.3
    //Copyright (c) 2013 Guilherme Nascimento (brcontainer@yahoo.com.br)
    //
    //Released under the MIT license
    //usage variables
    String serr = "";
    ServerXMLHttp xmlHttp = null;
    String url = "";
    String absolutePath = "";
    String tmpName = "";
    String fileName = "";
    String mime = "";
    Stream oas = null;
    String PATH = "";
    FileSystemObject filesys = null;
    int counter = 0;
    vbarray myArray = new vbarray();
     /* initialize variables. */ 
    callback = "";
    objFSO = null;
    CCACHE = 0;
     /* initialize variable end */
 %>
<%
    //Setup
    PATH = "images";
    CCACHE = 60 * 5;
    absolutePath = vb.Replace(Server.MapPath("./"), "\\.", "");
    Response.AddHeader("Access-Control-Max-Age", vb.CStr(CCACHE));
    Response.AddHeader("Access-Control-Allow-Origin", "*");
    Response.AddHeader("Access-Control-Allow-Credentials", "TRUE");
    Response.AddHeader("Access-Control-Request-Method", "*");
    Response.AddHeader("Access-Control-Allow-Methods", "OPTIONS, GET");
    Response.AddHeader("Access-Control-Allow-Headers", "*");
    Response.setContentType("application/javascript");
    url = Request.QueryString("url").toString();
    callback = Request.QueryString("callback").toString();
    if (!(url.equals("")) && !(callback.equals(""))) {
        Err.ResumeNext();

        filesys = new FileSystemObject();
        if (!(filesys.FolderExists(absolutePath + "\\" + PATH))) {
            filesys.CreateFolder(absolutePath + "\\" + PATH);
        }
        if (!(filesys.FolderExists(absolutePath + "\\" + PATH))) {
            ERROR_HANDLE("Failed to create the folder " + absolutePath + "\\" + PATH);
        }
        xmlHttp = new ServerXMLHttp();
        operator.invoke(xmlHttp,"Open",new pVector().add("POST").add(url).add(false));
        operator.invoke(xmlHttp,"setRequestHeader",new pVector().add("User-Agent").add(Request.ServerVariables("HTTP_USER_AGENT")));
        operator.invoke(xmlHttp,"send",new pVector().add(""));
        if (Err.Err().getNumber() == 0) {
            if (i == 200) {
                tmpName = absolutePath + "\\" + PATH;
                oas = new Stream();
                //adTypeBinary
                //Set the stream position to the start
                objFSO = new FileSystemObject();
                DELETE_OLD_FILES(absolutePath + "\\" + PATH);
                mime = Trim;
                mime = vb.Replace(vb.Replace(vb.LCase(mime), vb.Chr(13.0), vb.Chr(10.0)), vb.Chr(10.0), "|");
                myArray = vb.Split(mime, "|");
                mime = "";
                for(counter = 0; counter <= vb.UBound(myArray); counter += 1){
                    if (vb.InStr(myArray.getItem(counter).toString(), "content-type:") == 1) {
                        mime = vb.Trim(vb.Replace(vb.Replace(myArray.getItem(counter).toString(), "content-type:", ""), "/x-", "/"));
                    }
                }
                if (mime.equals("")) {
                    serr = "No such mime-type";
                } else if (vb.InStr("|image/jpeg|image/jpg|image/png|image/gif|text/html|application/xhtml|application/xhtml+xml|", "|" + mime + "|") == 0){
                    serr = "Invalid mime-type";
                } else {
                    mime = vb.Replace(vb.Replace(vb.Replace(mime, "image/", ""), "text/", ""), "application/", "");
                    mime = vb.Replace(mime, "xhtml+xml", "xhtml");
                    fileName = FILE_EXISTS(new variant(0), mime);
                    tmpName = tmpName + "\\" + fileName;
                    //save responseBody to path
                    operator.invoke(oas,"SaveToFile",new pVector().add(tmpName));
                    //oas = (ADODB.Stream)null;
                    if (objFSO.FileExists(tmpName)) {
                        Response.AddHeader("Cache-control", "no-cache, public");
                        //Response.AddHeader "Pragma", "max-age=" & CCACHE
                        Response.setExpires(vb.CLng(vb.Round(CCACHE / 60.0)));
                        objFSO = (jasp.io.FileSystemObject)null;
                        Response.Write(callback + "(\"" + JSENCODE(FULL_URL() + PATH + "/" + fileName) + "\");");
                        Response.End();
                    } else {
                        serr = "Não pode criar o arquivo " + tmpName;
                    }
                }
                objFSO = (jasp.io.FileSystemObject)null;
            } else {
                serr = vb.CStr(counter) + "http error: ";
            }
        }
        Err.Goto0();

    } else if (url.equals("")){
        serr = "url variable is undefined";
    } else if (callback.equals("")){
        serr = "callback variable is undefined";
    }
    if (Err.Err().getNumber() != 0) {
        serr = Err.getDescription();
    } else if (serr.equals("")){
        serr = "unknown error, maybe the server from url is not available";
    }
    if (!(serr.equals(""))) {
        Response.AddHeader("Pragma", "no-cache");
        Response.AddHeader("Cache-control", "no-cache");
        Response.setExpires(0);
        ERROR_HANDLE(serr);
    }
    //xmlHttp = (MSXML2.ServerXMLHttp)null;
%>

<%! 
    String callback;
    FileSystemObject objFSO;
    int CCACHE;
    //Limit access-control, cache-control, delete old files
    public String FULL_URL() throws Exception {
        String a = "";
        vbarray b = new vbarray();
        String c = "";
        String d = "";
        String FULL_URL = "";
        a = "";
        c = Request.ServerVariables("SERVER_PORT").toString();
        d = Request.ServerVariables("HTTP_HOST").toString();
        if (c.equals("443")) {
            a = a + "https://";
        } else {
            a = a + "http://";
        }
        a = a + d;
        if (!(c.equals("80")) && !(c.equals("443")) && vb.InStr(d, ":") == 0) {
            a = a + ":" + c;
        }
        b = vb.Split(Request.ServerVariables("URL").toString(), "/");
        b.setItem(vb.UBound(b) ,"");
        FULL_URL = a + vb.Join(b, "/");
        return FULL_URL;
    }

    public variant ERROR_HANDLE(String s) throws Exception {
        variant ERROR_HANDLE = new variant();
        Response.Write(callback + "(\"error:" + JSENCODE(s) + "\");");
        Response.End();
        return ERROR_HANDLE;
    }

    public variant DELETE_OLD_FILES(String a) throws Exception {
        variant folder = new variant();
        variant files = new variant();
        variant folderIdx = new variant();
        double timer = 0;
        String fileSubstr = "";
        variant DELETE_OLD_FILES = new variant();
        folder.setObject(objFSO.GetFolder(a));
        files.setObject(operator.get(folder,"Files"));
        timer = vb.DateDiff("s", vb.CDate("01/01/1970 00:00:00"), vb.Now());
        if (operator.get(files,"count").unequals(new variant(0))) {
            for(int _each_i1 = 0; _each_i1 < files.getCount(); _each_i1 ++) {
                folderIdx = files.getItem(_each_i1);
                fileSubstr = vb.Mid(operator.get(folderIdx,"Name").toString(), 1.0, 10.0);
                if (((timer - vb.CLng(fileSubstr)) > vb.CInt(CCACHE))) {
                    //IF (folderIdx.Name+CCACHE)<timer Then
                    if (objFSO.FileExists(a + "\\" + operator.get(folderIdx,"Name"))) {
                        objFSO.DeleteFile(a + "\\" + operator.get(folderIdx,"Name"));
                    }
                }
            }
        }
        return DELETE_OLD_FILES;
    }

    public String FILE_EXISTS(variant s, String e) throws Exception {
        int max = 0;
        int min = 0;
        String my_num = "";
        String FILE_EXISTS = "";
        if (s.equals(new variant(0))) {
            max = 100000;
            min = 0;
            vb.Randomize();
            my_num = vb.CStr(vb.Int((max - min + 1) * vb.Rnd() + min)) + vb.Replace(vb.CStr(vb.Timer()), ".", "");
            FILE_EXISTS = FILE_EXISTS(new variant(vb.CStr(vb.DateDiff("s", vb.CDate("01/01/1970 00:00:00"), vb.Now())) + my_num), e);
        } else {
            if (objFSO.FileExists(s + "." + e)) {
                FILE_EXISTS = "." + e;
            } else {
                FILE_EXISTS = s + "." + e;
            }
        }
        return FILE_EXISTS;
    }

    public String JSENCODE(String s) throws Exception {
        vbarray a = new vbarray();
        vbarray b = new vbarray();
        int z = 0;
        int i = 0;
        int c = 0;
        String JSENCODE = "";
        //Based in VBS JSON 2.0.3, Copyright (c) 2009 Tuðrul Topuz, Under the MIT license.
        a = new vbarray(127);

        a.setItem(8 ,"\\b");
        a.setItem(9 ,"\\t");
        a.setItem(10 ,"\\n");
        a.setItem(12 ,"\\f");
        a.setItem(13 ,"\\r");
        a.setItem(34 ,"\\\"");
        a.setItem(47 ,"\\/");
        a.setItem(92 ,"\\\\");
        z = vb.Len(s) - 1;
        b.redim(z);
        for(i = 0; i <= z; i += 1){
            b.setItem(i ,vb.Mid(s, i + 1, 1.0));
            c = vb.Asc(b.getItem(i).toString());
            if (c < 127) {
                if (!(vb.IsEmpty(a.getItem(c)))) {
                    b.setItem(i ,a.getItem(c));
                } else if (c < 32){
                    b.setItem(i ,"\\u" + vb.Right("000" + vb.Hex(c), 4.0));
                }
            } else {
                b.setItem(i ,"\\u" + vb.Right("000" + vb.Hex(c), 4.0));
            }
        }
        JSENCODE = vb.Join(b, "");
        return JSENCODE;
    }

%> 

<%
    End();
    } catch(Exception ex) { 
        printStackTrace(ex);
    } 
%>