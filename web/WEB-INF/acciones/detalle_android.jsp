<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.izv.modelo.ModeloImagen"%>
<%@page import="com.izv.hibernate.Imagen"%>
<%@page import="java.util.List"%>
<%@page import="com.izv.hibernate.Inmueble"%>
<%@page import="com.izv.modelo.ModeloInmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


    <%
            Inmueble i = (Inmueble) request.getAttribute("inmuebleDetalle");
            List<Imagen> listaImagen;
            listaImagen = (List<Imagen>) ModeloImagen.getidInmueble(i.getId() + "");
            JSONArray ajson = new JSONArray(listaImagen);
            JSONObject json = new JSONObject();
            json.put("fotos", ajson);
            out.println(json);
        
    %>	