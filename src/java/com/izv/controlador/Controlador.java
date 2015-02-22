/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.izv.controlador;

import com.izv.hibernate.Imagen;
import com.izv.hibernate.Inmueble;
import com.izv.modelo.ModeloImagen;
import com.izv.modelo.ModeloInmueble;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Ivan
 */
@WebServlet(name = "Controlador", urlPatterns = {"/control"})
@MultipartConfig
public class Controlador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //1º Recibir datos para decidir "getParameter"
        //2º Decidir quien sabe o que debe responder
        //3º Generar información para el que sepa responder "setAttribute()"
        //4º Decidir como transfiero el control al que sabe responder(2 formas)
        //4.1 Redirección se utiliza en modificación de datos (update,insert,delete,...)
        //4.2 Forward dispatch
        //5º Transferir el control
        //do: insert, delete, update, select
        //target: tabla
        //action: view, do
        //view: vista
        String destino = "index.html";
        boolean forward = false;
        String target, op, action, view;

        //...
        target = request.getParameter("target");
        op = request.getParameter("op");
        action = request.getParameter("action");

        if (target.equals("inmueble") && op.equals("select") && action.equals("view")) {
            forward = true;
            destino = "WEB-INF/acciones/select.jsp";
            request.setAttribute("datos", ModeloInmueble.get());
            /************************** A N D R O I D **********************************/
        } else if (target.equals("inmueble") && op.equals("select_android") && action.equals("view")) {
            forward = true;
            destino = "WEB-INF/acciones/select_android.jsp";
            request.setAttribute("datos", ModeloInmueble.get());
            
        }else if (target.equals("inmueble") && op.equals("view_android") && action.equals("view")) {
            forward = true;
          
            request.setAttribute("inmuebleDetalle", ModeloInmueble.get2(request.getParameter("id")));
            destino = "WEB-INF/acciones/detalle_android.jsp";
            /**************************************************************************/
        }else if (target.equals("inmueble") && op.equals("view") && action.equals("view")) {
            forward = true;
          
            request.setAttribute("inmuebleDetalle", ModeloInmueble.get2(request.getParameter("id")));
            destino = "WEB-INF/acciones/detalle.jsp";
            
        } else if (target.equals("inmueble") && op.equals("delete") && action.equals("op")) {
            forward = false;
            ModeloInmueble.delete(request.getParameter("id"));
            eliminarCarpetaFotoPorID(Integer.parseInt(request.getParameter("id")));
            destino = "control?target=inmueble&op=select&action=view";
        } else if (target.equals("inmueble") && op.equals("insert") && action.equals("view")) {
            forward = true;
            destino = "WEB-INF/acciones/insert.jsp";
        } else  if (target.equals("inmueble") && op.equals("insert") && action.equals("op")) {
            forward = false;
            destino = "control?target=inmueble&op=select&action=view";
            Inmueble in = new Inmueble();
            in.setCalle(request.getParameter("calle"));
            in.setLocalidad(request.getParameter("localidad"));
            in.setPrecio(Integer.parseInt(request.getParameter("precio")));
            in.setSubido(Integer.parseInt(request.getParameter("subido")));
            in.setTipo(request.getParameter("tipo"));
            ModeloInmueble.insert(in);
        } else if (target.equals("inmueble") && op.equals("edit") && action.equals("view")) {
            forward = true;
            request.setAttribute("inmuebleEditar", ModeloInmueble.get2(request.getParameter("id")));
            destino = "WEB-INF/acciones/edit.jsp";
        } else if (target.equals("inmueble") && op.equals("edit") && action.equals("op")) {
            forward = false;
            request.setAttribute("inmuebleEditar", ModeloInmueble.get2(request.getParameter("id")));
            destino = "control?target=inmueble&op=select&action=view";
            Inmueble in = new Inmueble();
            in.setCalle(request.getParameter("calle"));
            in.setId(Integer.parseInt(request.getParameter("id")));
            in.setLocalidad(request.getParameter("localidad"));
            in.setPrecio(Integer.parseInt(request.getParameter("precio")));
            in.setSubido(Integer.parseInt(request.getParameter("subido")));
            in.setTipo(request.getParameter("tipo"));
            ModeloInmueble.edit(in);
        }if (target.equals("inmueble") && op.equals("subir") && action.equals("view")) {
            forward = true;
            request.setAttribute("idInmuebleFoto", ModeloInmueble.get2(request.getParameter("idInmuebleFoto")));
            destino = "WEB-INF/acciones/subir.jsp";
        } else if (target.equals("inmueble") && op.equals("subir") && action.equals("op")) {
            forward = true;
            
            String idInmuebleFoto = request.getParameter("idInmuebleFoto");
            
            File theDir=new File(getServletContext().getRealPath("/") + "images/inmuebles/"+idInmuebleFoto); 
             if (!theDir.exists()) {
                System.out.println("creating directory: ");
                boolean result = false;

                try{
                    theDir.mkdir();
                    result = true;
                 } catch(SecurityException se){
                    System.out.println(se);
                 }        
                 if(result) {    
                   System.out.println("DIR created");  
                 }
              }
            Boolean error = false;
            Part archivoPost = request.getPart("archivo");
            String[] fecha=getFecha().split("-");
            String nombreArchivoPost = "inmueble_"+idInmuebleFoto+"_"+fecha[0]+"_"+fecha[1]+"_"+fecha[2]+"_"+fecha[3]+"_"+fecha[4]+"_"+fecha[5];
            InputStream input = archivoPost.getInputStream();
            String destinoF = getServletContext().getRealPath("/") + "images/inmuebles/"+idInmuebleFoto+"/";
            response.setContentType("application/json");
            try {
                byte[] buffer = new byte[2048];
                OutputStream output = new FileOutputStream(new File(destinoF + nombreArchivoPost+".jpg"));
                try {
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                } catch (Exception e) {
                    System.out.println(e);
                    error = true;
                } finally {
                    output.close();
                }

            } catch (Exception e) {
                System.out.println(e);
                error = true;
            } finally {
                input.close();
            }
            if(error){
                
            }else{
                Imagen img = new Imagen();
                img.setIdInmueble(Integer.parseInt(idInmuebleFoto));
                img.setRuta(destinoF + nombreArchivoPost+".jpg");
                ModeloImagen.insert(img);
            }
            request.setAttribute("inmuebleDetalle", ModeloInmueble.get2(idInmuebleFoto));
            destino = "index.jsp";
            
        }if (target.equals("inmueble") && op.equals("eliminarFoto") && action.equals("view")) {
            forward = true;
            destino = "WEB-INF/acciones/gestionFotos.jsp";
            request.setAttribute("idInmuebleFotos", request.getParameter("idInmuebleFotos"));
        } else if (target.equals("inmueble") && op.equals("eliminarFoto") && action.equals("op")) {
            forward = true;
            String idFoto = request.getParameter("idFoto");
            int idInmueble = Integer.parseInt(request.getParameter("idInmueble"));
            Imagen img = ModeloImagen.get2(idFoto);
            eliminarFoto(img,idInmueble);
            ModeloImagen.delete(idFoto);
            
            request.setAttribute("inmuebleDetalle", ModeloInmueble.get2(idInmueble+""));
            destino = "WEB-INF/acciones/detalle.jsp";
        }

        if (forward) {
            request.getRequestDispatcher(destino).forward(request, response);
        } else {
            response.sendRedirect(destino);
        }

    }
    private String getFecha(){

        Calendar cal = new GregorianCalendar();
        Date date = cal.getTime();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
        String formatteDate;
        formatteDate = df.format(date);
        return formatteDate;

    }
    private void eliminarCarpetaFotoPorID(final int idInmuebleFoto){
        File carpetaFotos  = new File(getServletContext().getRealPath("/") + "images/inmuebles/"+idInmuebleFoto);
        if (carpetaFotos.isDirectory()) {
            String[] children = carpetaFotos.list();
            for (int i = 0; i < children.length; i++) {
                new File(carpetaFotos, children[i]).delete();
            }
            carpetaFotos.delete();
        }
    }
    private void eliminarFoto(Imagen img, int idInmuebleFoto){
        File archivoaBorrar = new File(img.getRuta());
        archivoaBorrar.delete();
    }
        

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
