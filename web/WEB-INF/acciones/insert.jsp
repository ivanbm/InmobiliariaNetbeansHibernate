
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <title>Añadir Inmueble</title>
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
                <span class="spanAnadir">Calle: </span><input type="text" name="calle" value="" />
                <br>
                    <span class="spanAnadir">Localidad: </span><input type="text" name="localidad" value="" />
                    <br>
                        <span class="spanAnadir">Tipo: </span>
                        <select name="tipo">
                            <option value="casa">Casa</option>
                            <option value="piso">Piso</option>
                            <option value="habitacion">Habitación</option>
                            <option value="cochera">Cochera</option>
                            <option value="local">Local</option>
                        </select>
                        <br>
                            <span class="spanAnadir">Precio: </span><input type="text" name="precio" value="" />
                            <br>
                                <input type="hidden" name="subido" value="1" />
                                <input type="hidden" name="target" value="inmueble" />
                                <input type="hidden" name="op" value="insert" />
                                <input type="hidden" name="action" value="op" />
                                <input type="submit" value="Insertar" />
                                <br>
                                    </form>
                                    <div class="clear"></div>
                                    </div><!-- end #content -->
                                    <div class="clear"></div>
                                    </div><!-- end #maincontent -->
                                    </div><!-- end #centercolumn -->

                                    </body>
                                    </html>






