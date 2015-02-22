<%-- 
    Document   : subir
    Created on : 01-feb-2015, 0:32:19
    Author     : Ivan
--%>

<%@page import="com.izv.hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Inmueble in = (Inmueble) request.getAttribute("idInmuebleFoto");
%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Añadir Foto</title>
        <link href="css/style.css" rel="stylesheet" type="text/css" />
    </head>
    <body>

        <div id="top-container">
            <div class="centercolumn">
                <div id="header">
                    <ul id="nav" class="menu">
                        <li><a href="index.jsp">Inicio</a></li>
                        <li><a href="control?target=inmueble&op=select&action=view" class="current">Inmuebles</a></li>
                        <li><a href="control?target=inmueble&op=insert&action=view" class="current">Añadir</a></li>

                    </ul>
                </div>
            </div>
        </div>


        <div class="centercolumn">


            <h2 class="underline">Subir foto</h2>
            <form action="control" method="post" enctype="multipart/form-data">
                <input type="file" name="archivo" />
                <input type="submit" value="subir" />
                <input type="hidden" name="idInmuebleFoto" value="<%= in.getId()%>" />
                <input type="hidden" name="target" value="inmueble" />
                <input type="hidden" name="op" value="subir" />
                <input type="hidden" name="action" value="op" />
            </form>

        </div>

    </body>
</html>

