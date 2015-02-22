<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.izv.modelo.ModeloImagen"%>
<%@page import="com.izv.hibernate.Imagen"%>
<%@page import="java.util.List"%>
<%@page import="com.izv.hibernate.Inmueble"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


    <%
            List<Inmueble> lista = (List<Inmueble>) request.getAttribute("datos");
            List<Imagen> listaImagen;
            JSONArray ajson = new JSONArray(lista);
            JSONObject json = new JSONObject();
            json.put("inmueble", ajson);
            out.println(json);
        
    %>	