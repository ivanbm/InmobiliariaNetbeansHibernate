
<%@page import="com.izv.modelo.ModeloImagen"%>
<%@page import="com.izv.hibernate.Imagen"%>
<%@page import="java.util.List"%>
<%@page import="com.izv.hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <title>Ver Inmuebles</title>
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

        <div>
            <h2>Lista de inmuebles</h2>
            <a href="control?target=inmueble&op=insert&action=view">Añadir inmueble</a>
            <br>
                <br>
                    <ul class="mostrarIn">
                        <%
                            List<Inmueble> lista = (List<Inmueble>) request.getAttribute("datos");
                            List<Imagen> listaImagen;
                            String rutaC;
                            String[] partir;
                            String ruta;
                            for (Inmueble i : lista) {
                                listaImagen = (List<Imagen>) ModeloImagen.getidInmueble(i.getId() + "");
                                if (listaImagen.size() == 0) {
                                    ruta = "images/sinImagen.jpg";
                                } else {
                                    rutaC = listaImagen.get(0).getRuta().toString();
                                    partir = rutaC.split("/");
                                    ruta = "images/" + partir[1].toString() + "/" + partir[2].toString() + "/" + partir[3].toString();
                                }
                        %>  
                        <li>
                            <img src="<%= ruta%>" alt="" />
                            <div>
                                <span>Dirección: </span><%= i.getCalle() + ", " + i.getLocalidad()%><br/>
                                <span>Tipo: </span><%= i.getTipo()%><br/>
                                <span>Precio: </span><%= i.getPrecio()%><span> €</span>
                            </div>	
                            <a href="control?target=inmueble&op=delete&action=op&id=<%= i.getId()%>">Borrar</a>
                            <a href="control?target=inmueble&op=edit&action=view&id=<%= i.getId()%>">Editar</a>
                        </li>
                        <%
                            }
                        %>			
                    </ul>
                    </div>


                    </body>
                    </html>

















