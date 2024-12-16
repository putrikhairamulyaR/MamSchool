package servlets;

import dao.PresensiDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import model.User;

@WebServlet(name = "PresensiServlet", urlPatterns = {"/PresensiServlet"})
public class PresensiServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                addKehadiran(request, response);
            } catch (ParseException ex) {
                Logger.getLogger(PresensiServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("edit".equals(action)) {
            editKehadiran(request, response);
        }

    }

    protected void addKehadiran(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {

        User user = (User) request.getSession().getAttribute("user");

        PresensiDao PresensiDao = new PresensiDao();
        String Id = request.getParameter("id");
        int id = Integer.parseInt(Id);
        String attendanceParam = request.getParameter("attendance");
        String dateString = request.getParameter("Date");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // Match HTML date format
        Date releaseDate = null;
        releaseDate = formatter.parse(dateString);
        
        boolean cekPresensi = PresensiDao.addKehadiran(id, releaseDate, attendanceParam);

        if (cekPresensi) {
            response.getWriter().print("Berhasil Masuk");
        } else {
            response.getWriter().print(releaseDate);
        }

    }

    protected void editKehadiran(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
