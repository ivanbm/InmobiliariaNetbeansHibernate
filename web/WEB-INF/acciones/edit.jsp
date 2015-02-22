

<%@page import="com.izv.hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Inmueble i = (Inmueble) request.getAttribute("inmuebleEditar");
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <title>Editar Inmueble</title>
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

            <div id="maincontent">
                <div id="content" class="full">
                    <h2 class="underline">Añadir inmueble</h2>
                    <form action="control" method="POST">
                        <span class="spanAnadir">Calle: </span><input type="text" name="calle" value="<%= i.getCalle()%>" />
                        <br>
                            <span class="spanAnadir">Localidad: </span><input type="text" name="localidad" value="<%= i.getLocalidad()%>" />
                            <br>
                                <span class="spanAnadir">Tipo: </span>
                                <select name="tipo">
                                    <% if (i.getTipo().compareToIgnoreCase("piso") == 0) { %>
                                    <option value="casa">Casa</option>
                                    <option value="piso" selected>Piso</option>
                                    <option value="cochera">Cochera</option>
                                    <% } else if (i.getTipo().compareToIgnoreCase("cochera") == 0) { %>
                                    <option value="casa">Casa</option>
                                    <option value="piso" >Piso</option>
                                    <option value="cochera" selected>Cochera</option>
                                    <% } else if (i.getTipo().compareToIgnoreCase("casa") == 0) { %>
                                    <option value="casa" selected>Casa</option>
                                    <option value="piso" >Piso</option>
                                    <option value="habitacion" >Habitación</option>
                                    <option value="cochera" >Cochera</option>
                                    <option value="local" >Local</option>
                                    <% }%>
                                </select>
                                <br>
                                    <span>Precio: </span><input type="text" name="precio" value="<%= i.getPrecio()%>" />
                                    <br>
                                        <input type="hidden" name="target" value="inmueble" />
                                        <input type="hidden" name="op" value="edit" />
                                        <input type="hidden" name="action" value="op" />
                                        <input type="hidden" name="id" value="<%= i.getId()%>" />
                                        <input type="hidden" name="subido" value="1" />
                                        <input type="submit" value="Editar" />
                                        <br>
                                            </form>
                                            </div>
                                            </body>
                                            </html>







