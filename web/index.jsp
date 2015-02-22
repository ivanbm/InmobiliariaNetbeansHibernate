                                                                
<%@page import="com.izv.modelo.ModeloImagen"%>
<%@page import="com.izv.hibernate.Imagen"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.izv.modelo.ModeloInmueble"%>
<%@page import="java.util.List"%>
<%@page import="com.izv.hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>

        <title>Inmobiliaria</title>
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
            <!-- BEGIN SLIDE -->
            <div id="slider_container">

                <div id="slideshow">                                      

                    <%
                        List<Inmueble> lista = (List<Inmueble>) ModeloInmueble.get();
                        List<Imagen> listaImagen;
                        String rutaC;
                        String[] partir;
                        String ruta;

                        for (int i = 0; i < lista.size(); i++) {
                            if (i == 4) {
                                break;
                            }
                            listaImagen = (List<Imagen>) ModeloImagen.getidInmueble(lista.get(i).getId() + "");
                            if (listaImagen.size() == 0) {
                                ruta = "images/sinImagen.jpg";
                            } else {
                                rutaC = listaImagen.get(0).getRuta().toString();
                                partir = rutaC.split("/");
                                ruta = "images/" + partir[1].toString() + "/" + partir[2].toString() + "/" + partir[3].toString();
                            }
                    %>  
                    <div class="desc">
                        <img src="<%= ruta%>" alt="" />
                        <div>
                            <span>Dirección: </span><%= lista.get(i).getCalle() + ", " + lista.get(i).getLocalidad()%><br/>
                                <span>Tipo: </span><%= lista.get(i).getTipo()%><br/>
                                <span class="precio">Precio: </span><%= lista.get(i).getPrecio()%><span> €</span><br/>
 
                            <div>
                                <div ><a href="control?target=inmueble&op=view&action=view&id=<%= lista.get(i).getId()%>">Ver Más</a></div>
                            </div>
                        </div>
                    </div>

                    <%
                        }
                    %>	

                </div><!-- end #slideshow -->
            </div><!-- end #slide -->
            <!-- END OF SLIDE -->

    </body>
</html>

