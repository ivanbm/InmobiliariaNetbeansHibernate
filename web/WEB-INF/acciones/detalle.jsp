
<%@page import="com.izv.modelo.ModeloImagen"%>
<%@page import="com.izv.hibernate.Imagen"%>
<%@page import="com.izv.hibernate.Imagen"%>
<%@page import="com.izv.modelo.ModeloInmueble"%>
<%@page import="java.util.List"%>
<%@page import="com.izv.hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Inmueble i = (Inmueble) request.getAttribute("inmuebleDetalle");
%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Detalle de <% i.getTipo();%></title>
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
                <div id="content">
                    <h2>Imágenes </h2>                                 
                    <a href="control?target=inmueble&op=subir&action=view&idInmuebleFoto=<%= i.getId()%>">Añadir foto</a> 
                    <br> 
                        <div id="container-slider">
                            <ul id="slideshow_detail">
                                <%
                                    List<Imagen> listaImagen;
                                    int limite = 3;
                                    String rutaC;
                                    String[] partir;
                                    String ruta;

                                    listaImagen = (List<Imagen>) ModeloImagen.getidInmueble(i.getId() + "");
                                    if (listaImagen.size() == 0) {
                                        ruta = "images/sinImagen.jpg";
                                %>  
                                <li>
                                    <h3><%= i.getCalle()%></h3><br/>
                                    <span class="left">Dirección: </span><%= i.getCalle() + ", " + i.getLocalidad()%><br/>
                                    <span class="left">Tipo: </span><%= i.getTipo()%><br/>
                                    <span class="left">Precio: </span><%= i.getPrecio()%><span> €</span>
                                    <p />
                                    <img src="<%= ruta%>" alt="thumb" />
                                </li>
                                <%
                                } else {
                                    for (int x = 0; x < listaImagen.size(); x++) {
                                        rutaC = listaImagen.get(x).getRuta().toString();
                                        partir = rutaC.split("/");
                                        ruta = "images/" + partir[1].toString() + "/" + partir[2].toString() + "/" + partir[3].toString();

                                %>  
                                <li>
                                    <h3><%= i.getCalle()%></h3>

                                    <span><%= ruta%></span>
                                    <p />
                                    <img src="<%= ruta%>" alt="thumb" />

                                </li> 
                                <%

                                        }
                                    }
                                %>
                            </ul>
                        </div>
                </div>


                </body>
                </html>
